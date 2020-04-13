<?xml version="1.0" encoding="UTF-8"?>


<!--                  -=<<o#%@O[ E_CodedVitalSigns_CSE.sch ]O@%#o>>=-
    
    Teste les entrées des examens physiques relatifs aux signes vitaux du volet du CI-SIS Certificats de santé de l'enfant 
    CS9, et CS24 pour la section "Coded Vital Signs Section"
    Teste la validité des entrées du volet
    Teste la cohérence des unités utilisées pour les éléments de type PQ
    
    Historique :
    27/06/11 : CRI : Création
    25/07/11 : CRI : Ajout entrées
    11/10/17 : NMA : Ajout du nom du schématron dans les messsages d'erreur
    07/02/18 : NMA : Mise à jour du code pour l'IMC
    02/04/19 : APE : Mise à jour des codes LOINC
    26/04/19 : NMA : Mise à jour des asserts suite à la MAJ des codes LOINC
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_CodedVitalSigns_CSE">
    <title>IHE PCC v3.0 Vital Signs Observation</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.2']">
        
        <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"] and
            cda:templateId[@root="2.16.840.1.113883.10.20.1.31"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Les OID des templates parents 
            (2.16.840.1.113883.10.20.1.31 et 1.3.6.1.4.1.19376.1.5.3.1.4.13) 
            de l'élément 'Vital Signs Observation' doivent être présents.
        </assert>
        <assert test='cda:code[@codeSystem="2.16.840.1.113883.6.1"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: L'attribut 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>        
        <assert test='cda:code[
         @code="2708-6" or
        @code="8280-0" or
        @code="8287-5" or
        @code="8302-2" or
        @code="8306-3" or
        @code="8310-5" or
        @code="8462-4" or
        @code="8480-6" or
        @code="8867-4" or
        @code="9272-6" or
        @code="9274-2" or
        @code="9279-1" or
        @code="29463-7" or
        @code="39156-5"
        ]'>                   
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: L'attribut 'code' doit être codé dans la nomenclature LOINC selon les valeurs prévues. 
        </assert>
        <assert test='cda:value[@xsi:type="PQ" or @xsi:type="REAL" or @xsi:type="INT"] '>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: L'attribut 'value' sera présent et s'exprimera dans le type de donnée spécifiée par le volet.
        </assert>
        
        <assert test='not(cda:code[@code="9279-1"]) or cda:value[@unit="/min"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 9279-1 
            aura une valeur s'exprimant en "/min".           
        </assert>
        <assert test='not(cda:code[@code="8867-4"]) or cda:value[@unit="/min"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 8867-4 
            aura une valeur s'exprimant en "/min".
        </assert>
        <assert test='not(cda:code[@code="2708-6"]) or cda:value[@unit="%"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 2708-6  
            aura une valeur s'exprimant en "%".
        </assert>
        <assert test='not(cda:code[@code="8480-6"]) or cda:value[@unit="mm[Hg]"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 8480-6
            aura une valeur s'exprimant en "mm[Hg]".
        </assert>
        <assert test='not(cda:code[@code="8462-4"]) or cda:value[@unit="mm[Hg]"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 8462-4
            aura une valeur s'exprimant en "mm[Hg]".
        </assert>
        <assert test='not(cda:code[@code="8310-5"]) or cda:value[@unit="Cel" or @unit="[degF]"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 8310-5
            aura une valeur s'exprimant en "Cel" or "[degF]".
        </assert>
        <assert test='not(cda:code[@code="8302-2"]) or cda:value[@unit="m" or
            @unit="cm" or @unit="[in_us]" or @unit="[in_uk]"]'>
            [E_CodedVitalSigns_CSE.sch]  Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 8302-2
            aura une valeur s'exprimant en "m" ou "cm" ou "[in_us]" ou "[in_uk]".
        </assert>
        <assert test='not(cda:code[@code="8306-3"]) or cda:value[@unit="m" or
            @unit="cm" or @unit="[in_us]" or @unit="[in_uk]"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 8306-3
            aura une valeur s'exprimant en "m" ou "cm" ou "[in_us]" ou "[in_uk]".
        </assert>
        <assert test='not(cda:code[@code="8287-5"]) or cda:value[@unit="m" or
            @unit="cm" or @unit="[in_us]" or @unit="[in_uk]"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 8287-5
            aura une valeur s'exprimant en "m" ou "cm" ou "[in_us]" ou "[in_uk]".
        </assert>
        <assert test='not(cda:code[@code="29463-7"]) or cda:value[@unit="kg" or
            @unit="g" or @unit="[lb_av]" or @unit="[oz_av]"]'>
            [E_CodedVitalSigns_CSE.sch] Erreur de Conformité volet CSE: Un élément 'Vital Signs Observation' codé 29463-7
            aura une valeur s'exprimant en "kg" ou "g" ou "[lb_av]" ou "[oz_av]".
        </assert>
    </rule>
</pattern>