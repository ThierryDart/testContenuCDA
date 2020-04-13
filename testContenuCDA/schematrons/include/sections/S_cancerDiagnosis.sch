<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ cancerDiagnosis.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Cancer Diagnosis Section" (1.3.6.1.4.1.19376.1.7.3.1.3.14.1)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/08/121 : CRI : Création
    29/06/2017 : LBE : Ajout de la vérification de la présence de l'entrée cancerDiagnosisEntry, compte des templateId, code et conventions de nommage, modification vérification texte
    10/10/2017 : NMA : Correction du test sur la présence de l'entrée "cancer diagnosis entry"
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_cancerDiagnosis">


    <title>IHE PCC v3.0 Cancer Diagnosis Section</title>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.3.14.1']">
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId =3">
            [S_cancerDiagnosisSection.sch] Erreur de conformité PCC : La section cancer diagnosis doit contenir trois templateId (cardinalité [3..3])
        </assert>
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.6'">
            [S_cancerDiagnosisSection.sch] Erreur de conformité PCC : La section cancer diagnosis doit contenir le template Parent (active Problem Section) dont la valeur de l'attribut @root est fixée à '1.3.6.1.4.1.19376.1.5.3.1.3.6'
        </assert>
        <assert test="cda:templateId/@root='2.16.840.1.113883.10.20.1.11'">
            [S_cancerDiagnosisSection.sch] Erreur de conformité PCC : La section cancer diagnosis doit contenir le template de conformité CDD dont l'attribut @root est fixé à la valeur '2.16.840.1.113883.10.20.1.11' 
        </assert>
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité PCC : 'Cancer Diagnosis' ne peut être utilisé que comme section.</assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code ='72135-7']"> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité PCC : Le code de la section 'CancerDiagnosis Section' doit être '72135-7'</assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_cancerDiagnosisSection.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Cancer Diagnosis' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)</assert>
        <assert test="cda:text">
            [S_cancerDiagnosisSection.sch] Erreur de conformité PCC : Une section "Cancer Diagnosis" doit contenir un élément text"</assert>
        <assert test="cda:entry/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.7.3.1.4.14.1']">
            [S_cancerDiagnosisSection.sch] Erreur de conformité PCC : Une section Cancer diagnosis  doit contenir une entrée cancer diagnosis entry
        </assert>
    </rule>
</pattern>
