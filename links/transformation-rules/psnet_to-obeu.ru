PREFIX obeu:           <http://data.openbudgets.eu/ontology/>
PREFIX obeu-attribute: <http://data.openbudgets.eu/ontology/dsd/attribute/>
PREFIX obeu-dimension: <http://data.openbudgets.eu/ontology/dsd/dimension/>
PREFIX obeu-measure: <http://data.openbudgets.eu/ontology/dsd/measure/>
PREFIX obeu-operation: <http://data.openbudgets.eu/resource/codelist/operation-character/>
PREFIX owl:            <http://www.w3.org/2002/07/owl#>
PREFIX pay:            <http://reference.data.gov.uk/def/payment#>
PREFIX rdfs:           <http://www.w3.org/2000/01/rdf-schema#>   
PREFIX psnet: 			<http://publicspending.net/ontology#>
PREFIX qb:             <http://purl.org/linked-data/cube#>
PREFIX org:            <http://www.w3.org/ns/org#>
PREFIX time:           <http://www.w3.org/2006/time#>
PREFIX skos:           <http://www.w3.org/2004/02/skos/core#>

INSERT {
  ?payment a qb:Observation;
    obeu-measure:amount ?amount;
    obeu-dimension:functionalClassification ?cpv;
    obeu-dimension:organization ?payer;
    obeu-dimension:partner ?payee;
    obeu-dimension:date [
      time:hasBeginning [
        time:inXSDDateTime ?date .
      ];               
      time:hasEnd [
        time:inXSDDateTime ?date .
      ] .
    ] .
    ?cpv skos:notation ?cpvCode .
}
WHERE {
  ?payment a psnet:Payment;
     psnet:paymentAmount ?amount;
     psnet:payer ?payer;
     psnet:payee ?payee;
     psnet:cpv ?cpv;
     psnet:date ?date .
  ?cpv psnet:cpvCode ?cpvCode .        
}