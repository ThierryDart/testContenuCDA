<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Motif d'hospitalisation ANS
    
   Teste la conformité de la section Motif d'hospitalisation (1.2.250.1.213.1.1.2.6) créée par l'ANS
    
    Historique :
    10/01/2020 : NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_MotifHospitalisation_ANS">
    <title>Section Motif d'hospitalisation ANS</title>

    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.6"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_MotifHospitalisation_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_MotifHospitalisation_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_MotifHospitalisation_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "46241-6"]'>
            [S_MotifHospitalisation_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section Abdomen doit être 46241-6 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_historiqueExamensBiologiques_ASIP.sch] Erreur de Conformité CI-SIS (Section ANS) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>

    </rule>

</pattern>
