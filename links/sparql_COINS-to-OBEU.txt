PREFIX obeu:           <http://data.openbudgets.eu/ontology/>
PREFIX obeu-attribute: <http://data.openbudgets.eu/ontology/dsd/attribute/>
PREFIX obeu-dimension: <http://data.openbudgets.eu/ontology/dsd/dimension/>
PREFIX obeu-measure:   <http://data.openbudgets.eu/ontology/dsd/measure/>
PREFIX obeu-operation: <http://data.openbudgets.eu/resource/codelist/operation-character/>
PREFIX owl:            <http://www.w3.org/2002/07/owl#>
PREFIX pay:            <http://reference.data.gov.uk/def/payment#>
PREFIX rdfs:           <http://www.w3.org/2000/01/rdf-schema#>   
PREFIX qb:             <http://purl.org/linked-data/cube#>
PREFIX org:            <http://www.w3.org/ns/org#>
PREFIX time:           <http://www.w3.org/2006/time#>                                  
PREFIX obeu-currency:  <http://data.openbudgets.eu/resource/codelist/currency/>


PREFIX coins-measure:   <http://finance.data.gov.uk/dsd/coins/measure/> 
PREFIX coins-dimension: <http://finance.data.gov.uk/dsd/coins/dimension/> 
PREFIX coins-attribute: <http://finance.data.gov.uk/dsd/coins/attribute/> 

INSERT {
  ?coins-record a qb:Observation;
    obeu-measure:amount ?amount;
    obeu-attribute:currency obeu-currency:GBP;
    obeu-dimension:economicClassification ?accCode; 
    obeu-dimension:functionalClassification ?cofog;
    obeu-dimension:organization ?depCode;
    obeu-dimension:partner ?counterCode;
    obeu-dimension:programmeClassification ?progCode;
    obeu-dimension:operationCharacter obeu-operation:expenditure . #based on the fact that COINS are supposed to be spending data
}
WHERE {
  ?coins-record coins-measure:amount ?amountInThousands; #not clear what negative numbers mean
    coins-dimension:departmentCode ?depCode;
    coins-dimension:counterpartyCode ?counterCode;
    coins-dimension:programmeObjectCode ?progCode;
    coins-attribute:cofog ?cofog;
    coins-dimension:accountCode ?accCode . 
          
  BIND (?amountInThousands * 1000.0 AS ?amount)  
}


#expects existing GBP currency:
INSERT DATA {
obeu-currency:GBP a skos:Concept ;
  skos:prefLabel "Pound sterling"@en ;
  skos:notation "GBP" ;
  dbp:isoCode "GBP" ;
  owl:sameAs <http://dbpedia.org/resource/GBP> ;
  skos:topConceptOf obeu-codelist:currency ;
  skos:inScheme obeu-codelist:currency .
}

#conversion of time/date probably impossible with SPARQL
#time specification looks like this
#<http://finance.data.gov.uk/def/coins/time/m2010m> <http://www.w3.org/2004/02/skos/core#prefLabel> "March 2010 MTH"@en .
#<http://finance.data.gov.uk/def/coins/time/m2010m> <http://www.w3.org/2004/02/skos/core#notation> "m2010m" .
#<http://finance.data.gov.uk/def/coins/time/m2010m> <http://www.w3.org/2000/01/rdf-schema#label> "March 2010 MTH"@en .
#<http://finance.data.gov.uk/def/coins/time/m2010m> <http://www.w3.org/2000/01/rdf-schema#comment> "" .
#<http://finance.data.gov.uk/def/coins/time/m2010m> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2004/02/skos/core#Concept> .
#<http://finance.data.gov.uk/def/coins/time/m2010m> <http://www.w3.org/2004/02/skos/core#topConceptOf> <http://finance.data.gov.uk/def/coins/time> .
#<http://finance.data.gov.uk/def/coins/time/m2010m> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://finance.data.gov.uk/def/coins/Time> .
#i.e. only free text spec of the date value, needs parsing
#linked from observation with sdmx:refPeriod