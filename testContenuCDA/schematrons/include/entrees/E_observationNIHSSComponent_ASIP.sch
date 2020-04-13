<?xml version="1.0" encoding="UTF-8"?>
<!--                 
                Entrée observation score NIHSS
       
    Teste la conformité de l'observation E.	NIHSS Component entry  (1.2.250.1.213.1.1.3.8), créée par l'ASIP Santé
    Au 18/08/2017, utilisée dans le volet AVC_AUNV
    
    Historique : 
    18/08/2017 : LBE :  Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_observationNIHSSComponent_ASIP">
    <title>ASIP</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.8"]'>

        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, les attributs @classCode, @moodCode de l'élément observation sont fixés resectivement aux valeurs 'OBS', 'EVN' </assert>

        <assert test='count(cda:id)=1'>
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il doit y avoir un élément id (cardinalité [1..1])
        </assert>
        <assert test="count(cda:templateId)=3">
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il doit y avoir trois templateId (crdinalité [3..3])
        </assert>
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il doit y avoir le template Id de la simple observation (’1.3.6.1.4.1.19376.1.5.3.1.4.13’)
        </assert>
        <assert test="cda:templateId/@root='2.16.840.1.113883.10.20.1.31'">
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, Il doit y avoir le templateId/@root='2.16.840.1.113883.10.20.1.31'
        </assert>
        <assert test="cda:statusCode/@code='completed'">
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, le statusCode doit présent et fixé à la valeur @code='completed'
        </assert>
        <assert test="cda:effectiveTime">
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, un élément effectiveTime doit être présent 
        </assert>
        <assert test="count(cda:value)=1">
            [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il doit y avoir un élément value (cardinalité [1..1])
        </assert>
       <assert test="count(cda:interpretationCode)&lt;=1">
           [E_observationNIHSSComponent_ASIP.sch] Erreur de conformité CI-SIS (ASIP Santé) : Dans l'observation NIHSS component, il peut y avoir un interpretationCode (cardinalité [0..1])
       </assert>
    </rule>

</pattern>