<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Traitement au long cours  ASIP Santé
    
   Teste la conformité de la section traitement au long cours  (1.2.250.1.213.1.1.2.32) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par le volet VSM
    
    Historique :
    17/08/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_traitementLongCours_ASIP">
    <title>ASIP Santé Section Traitement au long cours </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.32"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
       <!-- <assert test="cda:text">
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert>     --> 
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "18776-5"]'>
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section 'Traitement au long cours' doit être '18776-5' </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <!-- Vérification des sous-sections optionnelles -->
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.19'">
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La sous-section optionnelle est la section Traitements (Medications - 1.3.6.1.4.1.19376.1.5.3.1.3.19).         
        </assert>
        
        <assert test="(not(cda:component/cda:section) and cda:text) or (cda:component/cda:section and not(cda:text))">
            [S_traitementLongCours_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : 
            La section doit contenir un élément text s’il n’y a pas de sous-section Traitement (1.3.6.1.4.1.19376.1.5.3.1.3.19).
            La section ne doit pas contenir d’élément text s’il y a une ou plusieurs sous-sections Traitement (1.3.6.1.4.1.19376.1.5.3.1.3.19)
                    
        </assert>

    </rule>

</pattern>
