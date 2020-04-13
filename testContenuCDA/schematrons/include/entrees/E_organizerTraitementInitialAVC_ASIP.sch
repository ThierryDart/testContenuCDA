<?xml version="1.0" encoding="UTF-8"?>
<!--                 
                Entrée organizer RCP 
       
    Teste la conformité de l'organizer Traitement initial AVC (1.2.250.1.213.1.1.3.16), créée par l'ASIP Santé
    Au 18/08/2017, utilisée dans le volet AVC_AUNV
    
    Historique : 
    18/08/2017 : LBE :  Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_organizerTraitementInitialAVC_ASIP">
    <title>ASIP Santé organizer RCP </title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.16"]'>

        <assert
            test="self::cda:organizer[@classCode='BATTERY' and @moodCode='EVN']">
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, les attributs @classCode et @moodCode de l'élément observation sont fixés resectivement aux valeurs 'BATTERY' et 'EVN'</assert>
        <assert test="cda:code">
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, l'élément code doit être présent
        </assert>
       
        <assert test="cda:statusCode/@code='completed'">
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, le statusCode doit présent et fixé à la valeur @code='completed'
        </assert>
        <assert test="count(cda:author)=1">
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, il doit y avoir un élément author (cardinalité [1..1])
        </assert>
        <assert test="cda:component/cda:observation/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_organizerTraitementInitialAVC_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'organizer traitement initial AVC, il doit y avoir au moins une simple observation (templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13')
       </assert>
    </rule>

</pattern>