<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_laborAndDelivery_CSE.sch ]O@%#o>>=-
    
    Teste les entrées de la section PCC Labor and Delivery (1.3.6.1.4.1.19376.1.5.3.1.1.21.2.3) utilisée dans le volet du CI-SIS 
    "Certificats de santé de l'enfant du 8ème jour"
    
    Historique :
    25/07/11 : CRI : Création
    11/10/17 : NMA : Ajout du nom du schématron sur les messages d'erreur
    21/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_laborAndDelivery_CSE">
    <title>CSE Labor and Delivery entries</title>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.21.2.3']">
        <!-- Attribution à la mère -->
        <assert test="cda:subject/cda:relatedSubject/cda:code/@code='MTH'"> 
            [E_laborAndDelivery_CSE.sch] Erreur de conformité au volet CS8: La section "Labor and Delivery" dans le contexte du CS8 doit être attribué à la mère.</assert>
        
        <assert test="cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7']/cda:entry/cda:observation/cda:code/@code='F-84640'"> 
            [E_laborAndDelivery_CSE.sch] Erreur de conformité au volet CS8: Cette section doit mentionner le type du début du travail (F-84640).</assert>
        
        <assert test="cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7']/cda:entry/cda:observation/cda:code/@code='MED-168'"> 
            [E_laborAndDelivery_CSE.sch] Erreur de conformité au volet CS8: Cette section doit mentionner l'analgésie utilisée au cours de l'accouchement(MED-168).</assert>
        
        <assert test="cda:component/cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7']/cda:entry/cda:observation/cda:code/@code='MED-169'"> 
            [E_laborAndDelivery_CSE.sch] Erreur de conformité au voletCS8: Cette section doit mentionner le type d'accouchement réalisé (MED-169).</assert>
    </rule>
</pattern>
