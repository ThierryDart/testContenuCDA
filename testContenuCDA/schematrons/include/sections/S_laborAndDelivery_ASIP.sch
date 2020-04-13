<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Labor and Delivery ASIP Santé
    
   Teste la conformité de la section Labor and Delivery (1.2.250.1.213.1.1.2.13) créée par l'ASIP Santé
    
    Au 17/08/2017, cette section est utilisée par les volets OBS_SNE, CSE_CS8
    
    Historique :
    17/08/2017 : LBE : Création
    14/01/2020 : NMA : Supprimer le test que cette entrée hérite de Labor and Delivry d'IHE car c'est une section narrative et celle d'IHE est codée
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_laborAndDelivery_ASIP">
    <title>ASIP Santé Section Labor and delivery </title>

    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.13"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
             
        <assert test="$count_templateId &gt; 0">
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir au moins un templateId (cardinalité [1..*])
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert> 
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "57074-7"]'>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Abdomen doit être 57074-7
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_laborAndDelivery_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>


    </rule>

</pattern>
