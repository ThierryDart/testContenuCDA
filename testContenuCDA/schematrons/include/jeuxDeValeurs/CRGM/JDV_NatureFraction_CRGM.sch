<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_NatureFraction_CRGM" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_CRGM_NatureFraction"/>
    <param name="vue_elt"
        value="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/value"/>
    <param name="xpath_elt"
        value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:organizer/cda:component/cda:observation[cda:code/@code='MED-301']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>
