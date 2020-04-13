<?xml version="1.0" encoding="UTF-8"?>

<!-- E_codedSocialHistory_CSE.sch 
    
    Teste les entrées du volet du CI-SIS Certificats de santé de l'enfant 
    CS8, CS9, et CS24 pour la section "Coded Social History"
    Note: Ce schematron est commun aux trois volets CS8, CS9, CS24
    
    Historique :
    24/06/11 : CRI : Création
    25/07/11 : CRI : Compatbilité du schematron aux trois volets CS8, CS9, CS24
    06/03/12 : CRI : Supression des références à SNOMED CT
    11/10/17 : NMA : Suppression du teste sur la garde à temps complet et du type de garde
    21/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    15/05/18 : NMA : MAJ du volet par rapport aux modifications d'APE
    14/02/18 : APE : Profession de la mère et du père non présents dans le CS8
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_codedSocialHistory_CSE">
    <title>IHE PCC v3.0 Coded Social History Section</title>
    
    <!-- ****** Contexte : Coded Social History Section ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.16.1"]'>
        
        <!-- Niveau de scolarité + affectation  (mère seulement) -->
        <!--<assert test='//cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code/@code="S-00610"'>             
            [E_codedSocialHistory_CSE.sch] Erreur de Conformité volet CSE: L'entrée "niveau de scolarité" doit obligatoirement faire partie des entrées de la section "Coded Social History"
        </assert>
        <assert test='.//cda:entry/cda:observation[cda:code/@code="S-00610"]/cda:subject[@typeCode="SBJ"]/cda:relatedSubject/cda:code/@code="MTH"'>             
            [E_codedSocialHistory_CSE.sch] Erreur de Conformité volet CSE: l'entrée "niveau de scolarité" doit obligatoirement être affectée à la mère
        </assert>-->
      
        <!-- Profession mère : présent dans CS9 et CS24 / absent dans CS8 -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"] or /cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or .//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="MTH"]/cda:code/@code="ORG-099"'>             
            [E_codedSocialHistory_CSE.sch] Erreur de Conformité volet CSE: L'entrée "Profession" pour la mère de l'enfant doit obligatoirement faire partie des entrées de la section 
            "Habitus, Mode de vie"
        </assert>
        <!-- Profession père : présent dans CS9 et CS24 / absent dans CS8 -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"] or /cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or .//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="FTH"]/cda:code/@code="ORG-099"'>             
            [E_codedSocialHistory_CSE.sch] Erreur de Conformité volet CSE: L'entrée "Profession" pour le père de l'enfant doit obligatoirement faire partie des entrées de la section 
            "Habitus, Mode de vie"
        </assert>        
        <!-- Activité professionnelle mère : présent dans CS8, CS9 et CS24 -->
        <assert test='.//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="MTH"]/cda:code/@code="ORG-075"'>             
            [E_codedSocialHistory_CSE.sch] Erreur de Conformité volet CSE: L'entrée "Activité professionnelle" pour la mère de l'enfant doit obligatoirement faire partie des entrées de la section 
            "Habitus, Mode de vie"
        </assert>
        <!-- Activité professionnelle père : présent dans CS8, CS9 et CS24 -->
        <assert test='.//cda:entry/cda:observation[cda:subject/cda:relatedSubject/cda:code/@code="FTH"]/cda:code/@code="ORG-075"'>             
            [E_codedSocialHistory_CSE.sch] Erreur de Conformité volet CSE: L'entrée "Activité professionnelle" pour le père de l'enfant doit obligatoirement faire partie des entrées de la section 
            "Habitus, Mode de vie"
        </assert>
       
<!--        <!-\- Type de garde de l'enfant  CS24 seulement -\->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:code/@code="XX-MCH178")'>             
            [CSECodedSocialHistoryEnt.sch] Erreur de Conformité volet CSE: L'entrée "Type de garde de l'enfant" doit obligatoirement faire partie des entrées de la section 
            "Coded Social History.
        </assert>-->
        <!-- Garde à temps complet CS9 et CS24 seulement  -->
        <!--<assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"] or /cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            .//cda:entry/cda:observation/cda:code/@code="XX-MCH179"'>             
            [CSECodedSocialHistoryEnt.sch] Erreur de Conformité volet CSE: L'entrée "Garde à temps complet" doit obligatoirement faire partie des entrées de la section 
            "Coded Social History.
        </assert>-->
        
        <!-- Risque de saturnisme  CS9 et CS24 seulement -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"] or /cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            .//cda:entry/cda:observation/cda:code/@code="MED-181"'>             
            [E_codedSocialHistory_CSE.sch] Erreur de Conformité volet CSE: L'entrée "Risque de staurnisme" doit obligatoirement faire partie des entrées de la section 
            "Habitus, Mode de vie".
        </assert>
    </rule>
</pattern>


