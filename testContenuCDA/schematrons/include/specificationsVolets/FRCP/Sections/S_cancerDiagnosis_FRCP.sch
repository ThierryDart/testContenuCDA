<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_cancerDiagnosis_FRCP.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Cancer Diagnosis Section" (1.3.6.1.4.1.19376.1.7.3.1.3.14.1)
    au volet FRCP
    
    Historique :
    25/08/121 : CRI : Création
    25/10/17 : NMA : Renommage du schématron et mise à jour des messages d'erreur 
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_cancerDiagnosis_FRCP">


    <title>IHE PCC v3.0 FRCP Cancer Diagnosis Section</title>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']">
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:code[@code='G-1009']">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La présence du diagnostic (G-1009) de la tumeur est obligatoire.
        </assert>
      
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='21908-9'] ">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La classification 'TNM' de la tumeur est obligatoire.
        </assert>
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='21905-5'] ">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La classification 'T' de la tumeur est obligatoire.
        </assert>
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='21906-3'] ">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La classification 'N' de la tumeur est obligatoire.
        </assert>
        
        <assert test="cda:entry/cda:act/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:entryRelationship/cda:observation/cda:code[@code='21907-1'] ">
            [S_cancerDiagnosis_FRCP] Erreur de conformité au volet FRCP : La classification 'M' de la tumeur est obligatoire.
        </assert>

    </rule>
</pattern>