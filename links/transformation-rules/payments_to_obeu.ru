PREFIX obeu-attribute: <http://data.openbudgets.eu/ontology/dsd/attribute/>
PREFIX obeu-dimension: <http://data.openbudgets.eu/ontology/dsd/dimension/>
PREFIX obeu-measure:   <http://data.openbudgets.eu/ontology/dsd/measure/>
PREFIX obeu:           <http://data.openbudgets.eu/ontology/>
PREFIX pay:            <http://reference.data.gov.uk/def/payment#>
PREFIX qb:             <http://purl.org/linked-data/cube#>

INSERT {
  ?observation a qb:Observation ;
    obeu-measure:amount ?amount ;
    obeu-attribute:taxesIncluded ?taxesIncluded ;
    ?obeuDimension ?dimensionValue ;
    ?obeuAttribute ?attributeValue ;
    ?obeuProperty ?propertyValue .
}
WHERE {
  # Measures
  VALUES (?amountProperty ?taxesIncluded) {
         (pay:grossAmount true)
         (pay:netAmount   false)
  }
  # Attributes
  VALUES (?payAttribute ?obeuAttribute) {
         (pay:currency  obeu-attribute:currency)
  }
  # Dimensions
  VALUES (?payDimension           ?obeuDimension) {
         (pay:date                obeu-dimension:date)
         (pay:expenditureCategory obeu-dimension:operationCharacter)
         (pay:payee               obeu-dimension:partner)
         (pay:payer               obeu-dimension:organization)
         (pay:procurementCategory obeu-dimension:functionalClassification)
  }
  # Other properties
  VALUES (?payProperty ?obeuProperty) {
         (pay:contract obeu:contract)
         (pay:invoice  obeu-dimension:accountingRecord)
         (pay:unit     obeu-dimension:administrativeClassification)
  }

  ?observation ?amountProperty ?amount ;
    ?payDimension ?dimensionValue .
  OPTIONAL { ?observation ?payAttribute ?attributeValue . }
  OPTIONAL { ?observation ?payProperty ?propertyValue . }
}
