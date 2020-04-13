<?xml version="1.0" encoding="UTF-8"?>
<!--                 
                Entrée organizer RCP 
       
    Teste la conformité de l'organizer RCP (1.2.250.1.213.1.1.3.7), créée par l'ASIP Santé
    Au 18/08/2017, utilisée dans le volet FRCP
    
    Historique : 
    18/08/2017 : LBE :  Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_organizerRCP_ASIP">
    <title>ASIP Santé organizer RCP </title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.7"]'>

        <assert
            test="self::cda:organizer[@classCode='CLUSTER' and @moodCode='EVN']">
            [E_organizerRCP_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer RCP, les attributs @classCode et @moodCode de l'élément observation sont fixés resectivement aux valeurs 'CLUSTER' et 'EVN'</assert>
        <assert test="cda:code">
            [E_organizerRCP_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer RCP, l'élément code doit être présent
        </assert>
       
        <assert test="cda:statusCode/@code='completed'">
            [E_organizerRCP_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer RCP, le statusCode doit présent et fixé à la valeur @code='completed'
        </assert>
        <assert test="cda:component/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            ’1.3.6.1.4.1.19376.1.5.3.1.4.13, il doit y avoir au moins une simple observation (templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13')
       </assert>
    </rule>

</pattern>