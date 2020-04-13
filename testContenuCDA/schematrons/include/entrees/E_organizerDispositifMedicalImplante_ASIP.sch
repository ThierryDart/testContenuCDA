<?xml version="1.0" encoding="UTF-8"?>
<!--                 
                Entrée organizer dispositif médical implanté 
       
    Teste la conformité de l'organizer dispositif medical implanté (1.2.250.1.213.1.1.3.2), créée par l'ASIP Santé
    Au 18/08/2017, utilisée dans les volets PRC_DCI, PRC_PPV, PRC_PSC, PRC_TAP
    
    Historique : 
    18/08/2017 : LBE :  Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_organizerDispositifMedicalImplante_ASIP">
    <title>ASIP Santé organizer dispositif médical implanté </title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.1.3.1"]'>

        <assert
            test="self::cda:organizer[@classCode='CLUSTER' and @moodCode='EVN']">
            [E_organizerDispositifMedicalImplante_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer dispositif médical implanté , les attributs @classCode et @moodCode de l'élément observation sont fixés resectivement aux valeurs 'CLUSTER' et 'EVN'</assert>

        <assert test='count(cda:id)=1'>
            [E_organizerDispositifMedicalImplante_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer dispositif médical implanté il doit y avoir un élément id (cardinalité [1..1])
        </assert>
        <assert test="cda:statusCode/@code='Completed'">
            [E_organizerDispositifMedicalImplante_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer dispositif médical implanté  le statusCode doit présent et fixé à la valeur @code='Completed'
        </assert>
       <assert test="cda:component/cda:observation/cda:templateId/@root='1.2.250.1.213.1.1.1.3.1'">
           [E_organizerDispositifMedicalImplante_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer dispositif médical implanté, il doit y avoir au moins une observation dispositifs médicaux (templateId/@root='1.2.250.1.213.1.1.1.3.1')
       </assert>
    </rule>

</pattern>