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

PREFIX example:        <http://example.openbudgets.eu/vocabulary/>

INSERT {
  [ a qb:Observation;
    obeu-measure:amount ?netAmount;
    obeu-attribute:taxesIncluded false;
    obeu-dimension:date ?date;
    obeu-attribute:currency obeu-currency:GBP;
    obeu-dimension:expenditureCategory ?category; 
    obeu-dimension:procurementCategory ?procurementCategory;   
    obeu-dimension:administrativeClassification ?unit;
    obeu-dimension:organization ?payer;
    obeu-dimension:partner ?payee;
    obeu-dimension:operationCharacter obeu-operation:expenditure ] .
    
 [ a qb:Observation;
    obeu-measure:amount ?grossAmount;
    obeu-attribute:taxesIncluded true;
    obeu-dimension:date ?date;
    obeu-attribute:currency obeu-currency:GBP;
    obeu-dimension:expenditureCategory ?category; 
    obeu-dimension:procurementCategory ?procurementCategory;   
    obeu-dimension:administrativeClassification ?unit;
    obeu-dimension:organization ?payer;
    obeu-dimension:partner ?payee;
    obeu-dimension:operationCharacter obeu-operation:expenditure ] .
}
WHERE {
  ?expenditure-line pay:netAmount ?netAmount;
    pay:grossAmount ?grossAmount;
    pay:netAmount ?netAmount;
    pay:expenditureCategory ?category;
    pay:payment ?payment .
  
  ?payment pay:unit ?unit;  
    pay:payee ?payee;
    pay:payer ?payer;
    pay:date ?date;
    pay:purchase ?purchase .
    
  ?purchase pay:procurementCategory ?procurementCategory.
          
}

#the examples of Payments documentation seem to be contradictory with available DSD
#the query is designed according to the examples at https://data.gov.uk/resources/payments

# creation of additional properties
INSERT DATA {
  example:expenditureCategory rdfs:subPropertyOf obeu-dimension:classification, pay:expenditureCategory .
  example:procurementCategory rdfs:subPropertyOf obeu-dimension:functionalClassification, pay:procurementCategory .
}

#currency is not specified, expecting GBP since it is gov.uk vocabulary:
INSERT DATA {
obeu-currency:GBP a skos:Concept ;
  skos:prefLabel "Pound sterling"@en ;
  skos:notation "GBP" ;
  dbp:isoCode "GBP" ;
  owl:sameAs <http://dbpedia.org/resource/GBP> ;
  skos:topConceptOf obeu-codelist:currency ;
  skos:inScheme obeu-codelist:currency .
}