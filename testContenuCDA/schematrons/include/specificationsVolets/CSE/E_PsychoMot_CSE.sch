<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_PsychoMot_CSE.sch ]O@%#o>>=-
    
    Teste les entrées des examens physiques relatifs développement psychomoteur du volet du CI-SIS Certificats de santé de l'enfant 
    CS9, et CS24 pour la section "Child Functional Status Assessment Section/Psychomotor development" 
    
    
    Historique :
    24/06/11 : CRI : Création
    25/07/11 : CRI : Extension aux profils CS9 et CS24
    12/10/17 : NMA : Ajout du nom du schématron sur les messages d'erreur et suppression des tests sur la motricité symétrique des 4 membres pour le CS24
    22/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_PsychoMot_CSE">
    <title>IHE PCC v3.0 Psychomotor development</title>
    
    <!-- ****** Contexte = Psychomotor Development section ****** -->
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.4"]'>

        
        <!-- Éléments spécifiques au CS9 -->
        <!-- Tient assis sans appui -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-190")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Tient assis sans appui" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-190"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        <!-- Réagit à son prénom -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-191")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Réagit à son prénom" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-191"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>        
        <!--  Répète une syllabe -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-192")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Répète une syllabe" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-192"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>      
        <!-- Se déplace -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-193")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Se déplace" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-193"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        <!-- Saisit un objet avec participation du pouce -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-194")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Saisit un objet avec participation du pouce" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-194"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        <!-- Pointe du doigt -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-202")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Pointe du doigt" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-202"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        <!-- Joue à coucou le voilà -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-213")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Joue à coucou le voilà" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-213"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        <!-- Motricité symétrique des 4 membres -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-195")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Motricité symétrique des 4 membres" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-195"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        
        
        <!-- ******** Éléments spécifiques au CS24 ********* -->
        
        <!-- Comprend une consigne simple -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-196")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Comprend une consigne simple" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-196"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        
        <!-- Nomme au moins une image -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-197")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Nomme au moins une image" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-197"]/cda:value/@value)'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        
        <!-- Superpose des objets -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-198")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Superpose des objets" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-198"]/cda:value/@value)'> 
            <!-- Note any missing optional elements -->
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        
        <!--  Associe deux mots -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-199")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Associe deux mots" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-199"]/cda:value/@value)'> 
            <!-- Note any missing optional elements -->
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>
        
        <!--  Motricité symétrique des 4 membres -->
       <!-- <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:code/@code="XX-MCH012")'>
            [CSEPsychoMotEnt.sch] Erreur de Conformité volet CSE: La mention de l'élément "Motricité symétrique des 4 membres" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation[cda:code/@code="XX-MCH012"]/cda:value/@value)'> 
            <!-\- Note any missing optional elements -\->
            [CSEPsychoMotEnt.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>        -->
        
        <!--  Marche acquise -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-200")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Marche acquise" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-200"]/cda:value/@value)'> 
            <!-- Note any missing optional elements -->
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>  
        
        <!--  Âge de la marche acquise -->
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation/cda:code/@code="MED-201")'>
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: La mention de l'élément "Âge de la marche acquise" est obligatoire
        </assert>
        <assert test='not(//cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            (.//cda:entry/cda:observation[cda:code/@code="MED-201"]/cda:value/@value)'> 
            <!-- Note any missing optional elements -->
            [E_PsychoMot_CSE.sch] Erreur de Conformité volet CSE: Le résultat de l'observation doit être reporté (pas de Nullflavor) 
        </assert>  

    </rule>
</pattern>
