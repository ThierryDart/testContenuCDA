<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section image illustrative ASIP Santé
    
   Teste la conformité de la section images illustratives (1.2.250.1.213.1.1.2.37) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par les volets D2LM, CR-RTN
    
    Historique :
    17/08/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_imagesIllustratives_ASIP">
    <title>ASIP Santé  Section score NIHSS </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.37"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId = 1">
            [S_sectionImagesIllustratives_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_sectionImagesIllustratives_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_sectionImagesIllustratives_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_sectionImagesIllustratives_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "52040-3"]'>
            [S_sectionImagesIllustratives_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 52040-3 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_sectionImagesIllustratives_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        <!-- Vérification des entrées optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.18'">
            [S_sectionImagesIllustratives_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Les entrées optionnelles autorisées sont : 
            Simple Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)
            Organizer document attaché (1.2.250.1.213.1.1.3.18)     
        </assert>

    </rule>

</pattern>
