<?xml version="1.0" encoding="UTF-8"?>
<!--
    Historique :
    
    17/02/20 : NMA : Création

-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="dansTypeCode" abstract="true" 
         xmlns:svs="urn:ihe:iti:svs:2008">
    <p>Conformité du typeCode au JDV</p>
    <rule context="$xpath_elt">
        <let name="att_typeCode" value="@typeCode"/>
        
        
        <assert test="document($path_jdv)//svs:Concept[@code=$att_typeCode]">
       
            [dansTypeCode] L'élément <value-of select="$vue_elt"/>
            [<value-of select="$att_typeCode"/>] 
            doit faire partie du jeu de valeurs <value-of select="$path_jdv"/>.
        </assert>
    </rule>
</pattern>   
