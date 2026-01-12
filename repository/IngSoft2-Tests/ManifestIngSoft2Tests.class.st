"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestIngSoft2Tests',
	#superclass : 'PackageManifest',
	#category : 'IngSoft2-Tests-Manifest',
	#package : 'IngSoft2-Tests',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestIngSoft2Tests class >> ruleLongMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'IngSoft2-Tests')) #'2026-01-12T11:38:51.54854-03:00') )
]
