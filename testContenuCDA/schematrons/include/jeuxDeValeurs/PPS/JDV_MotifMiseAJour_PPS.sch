<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_MotifMiseAJour_PPS" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_miseAJour"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:observation[(cda:code/@code='GEN-037')]/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
