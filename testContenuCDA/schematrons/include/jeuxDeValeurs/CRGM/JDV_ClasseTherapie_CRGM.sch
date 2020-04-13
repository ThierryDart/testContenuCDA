<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_ClasseTherapie_CRGM" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_CRGM_ClasseTherapie"/>
    <param name="vue_elt"
        value="ClinicalDocument/component/structuredBody/component/section/entry/organizer/component/observation/entryRelationship/observation/value"/>
    <param name="xpath_elt"
        value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:organizer/cda:component/cda:observation/cda:entryRelationship/cda:observation[cda:code/@code='69335-8']/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>