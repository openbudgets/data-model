PREFIX dbo:            <http://dbpedia.org/ontology/>
PREFIX ls:             <http://linkedspending.aksw.org/ontology/>
PREFIX obeu-attribute: <http://data.openbudgets.eu/ontology/dsd/attribute/>
PREFIX obeu-dimension: <http://data.openbudgets.eu/ontology/dsd/dimension/>
PREFIX owl:            <http://www.w3.org/2002/07/owl#>
PREFIX rdfs:           <http://www.w3.org/2000/01/rdf-schema#>
PREFIX sdmx-attribute: <http://purl.org/linked-data/sdmx/2009/attribute#>

INSERT {
  ?observation obeu-dimension:date ?dateUri ;
    obeu-dimension:fiscalYear ?yearUri ;
    obeu-attribute:currency ?currency ;
    obeu-attribute:location ?refArea .
}
WHERE {
  ?observation ls:refDate ?refDate ;
    ls:refYear ?refYear ;
    dbo:currency ?currency ;
    sdmx-attribute:refArea ?refArea .    
  
  BIND("http://reference.data.gov.uk/id/" AS ?refDataGov)
  BIND(URI(CONCAT(?refDataGov, "gregorian-day/", ?refDate)) AS ?dateUri) 
  BIND(URI(CONCAT(?refDataGov, "gregorian-year/", ?refYear)) AS ?yearUri) 
}