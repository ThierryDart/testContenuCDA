<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ ER_problemStatusObservation_fr.sch ]O@%#o>>=-
    
    Teste les entrées de la section Problem Status Observation (1.3.6.1.4.1.19376.1.5.3.1.4.1.1)
    
    27/06/17 : NMA : Création
   
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="ER_problemStatusObservation_fr">
        <title>CI-SIS Problem Status Observation</title>
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.1.1"]'>

            <assert test='cda:value[@xsi:type="CE" and (@codeSystem="1.2.250.1.213.2.12" or @codeSystem="1.2.250.1.213.1.1.4.2.286")] and 
                cda:value[@code = "CDA_002" or
                @code = "G-A201" or
                @code = "G-A202" or
                @code = "G-A230" or
                @code = "G-A270" or
                @code = "G-A378" or
                @code = "G-A397" or
                @code = "G-A500"]'>
                [ER_problemStatusObservation_fr] Erreur de Conformité CI-SIS : Pour tout élément de type 'Problem Status', l'élément 'value' signale le statut clinique.
                Il est toujours représenté utilisant le datatype 'CE' (xsi:type='CE'). 
                Il sera codé à partir d'un jeu de valeurs provenant de la nomenclature SNOMED 3.5.
            </assert>

        </rule>
        
        
    </pattern>
    
        
