<?xml version="1.0" encoding="UTF-8"?>
<!--                 
                Entrée organizer RCP 
       
    Teste la conformité de l'organizer Document attaché (1.2.250.1.213.1.1.3.18), créée par l'ASIP Santé
    Au 18/08/2017, utilisée dans les D2LM, CR-RTN
    
    Historique : 
    18/08/2017 : LBE :  Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_organizerDocumentAttache_ASIP">
    <title>ASIP Santé organizer RCP </title>
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.3.18"]'>

        <assert test="self::cda:organizer[@classCode = 'CLUSTER' and @moodCode = 'EVN']">
            [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans
            l'organizer Document attaché, les attributs @classCode et @moodCode de l'élément
            observation sont fixés resectivement aux valeurs 'CLUSTER' et 'EVN'</assert>
        <assert test="count(cda:id) = 1"> [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité
            CI-SIS (ASIP Santé) : Dans l'organizer Document attaché, il doit y avoir un élément id
            (cardinalité [1..1]) </assert>
        <assert test="cda:code"> [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité CI-SIS
            (ASIP Santé) : Dans l'organizer Document attaché, l'élément code doit être présent </assert>

        <assert test="cda:statusCode/@code = 'completed'"> [E_organizerDocumentAttache_ASIP.sch]
            Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer Document attaché, le
            statusCode doit présent et fixé à la valeur @code='Completed' </assert>

        <assert
            test="cda:component/cda:observation/cda:templateId/@root = '1.3.6.1.4.1.19376.1.5.3.1.4.13'"
            > [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans
            l'organizer Document attaché,il doit y avoir au moins une simple observation
            (templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13') </assert>
        <assert
            test="cda:component/cda:observationMedia[@classCode = 'OBS' and @moodCode = 'EVN']/cda:value[@mediaType and @representation = 'B64']"
            > [E_organizerDocumentAttache_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans
            l'organizer Document attaché, il doit y avoir au moins un observation media, contenant
            une value dont le XPath est le suivant :
            cda:component/cda:observationMedia[@classCode='OBS' and
            @moodCode='EVN']/cda:value[@mediaType='text/xml' and @representation='B64'] </assert>
    </rule>

</pattern>
