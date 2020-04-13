<?xml version="1.0" encoding="UTF-8"?>

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="JDV_BooleenEtendu_D2LM" is-a="dansJeuDeValeurs">
    <param name="path_jdv" value="$jdv_D2LM_BooleenEtendu"/>
    <param name="vue_elt" value="ClinicalDocument/component/structuredBody/component/section/entry/act/entryRelationship/observation/value"/>
    <param name="xpath_elt" value="/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:act/cda:entryRelationship/cda:observation[(cda:code/@code='G-1009') or (cda:code/@code='MED-010') or (cda:code/@code='MED-029')]/cda:value"/>
    <param name="nullFlavor" value="0"/>
</pattern>   
