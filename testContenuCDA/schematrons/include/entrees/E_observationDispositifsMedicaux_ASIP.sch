<?xml version="1.0" encoding="UTF-8"?>
<!--                 
                Entrée observation dispositifs médicaux 
       
    Teste la conformité de l'observation des dispositifs médicaux (1.2.250.1.213.1.1.1.3.1), créée par l'ASIP Santé
    Au 18/08/2017, utilisée dans les volets PRC_DCI, PRC_PPV, PRC_PSC, PRC_TAP
    
    Historique : 
    18/08/2017 : LBE :  Création
    20/10/2017 : NMA : Correction du test sur le statutCode
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_observationDispositifsMedicaux_ASIP">
    <title>ASIP</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.1.3.1"]'>

        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [E_observationDispositifsMedicaux_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, les attributs @classCode et @moodCode de l'élément observation sont fixés resectivement aux valeurs 'OBS' et 'EVN'</assert>

        <assert test='count(cda:id)=1'>
            [E_observationDispositifsMedicaux_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux,il doit y avoir un élément id (cardinalité [1..1])
        </assert>
        <assert test="count(cda:templateId)=2">
            [E_observationDispositifsMedicaux_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, il doit y avoir deux templateId (crdinalité [2..2])
        </assert>
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_observationDispositifsMedicaux_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, il doit y avoir le template Id de la simple observation (’1.3.6.1.4.1.19376.1.5.3.1.4.13’)
        </assert>
        <assert test="cda:statusCode/@code='completed'">
           [E_observationDispositifsMedicaux_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, le statusCode doit présent et fixé à la valeur @code='completed'
        </assert>
        <assert test="cda:effectiveTime">
            [E_observationDispositifsMedicaux_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, un élément effectiveTime doit être présent 
        </assert>
        <assert test="count(cda:value)=1">
            [E_observationDispositifsMedicaux_ASIP.sch]  :Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation dispositif médicaux, il doit y avoir un élément value (cardinalité [1..1])
        </assert>
    </rule>

</pattern>