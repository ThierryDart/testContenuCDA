<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_statutDoc.sch ]O@%#o>>=-
    
    Teste la conformité de la section ASIP Statut du document : 1.2.250.1.213.1.1.2.35
    aux spécifications du CI-SIS
    
    Historique :
    25/08/12 : CRI : Création
    14/01/2013 : CRI : adaptation au value set modifié: 3 statuts: "en cours", "complété", "validé"
    18/01/2013 : CRI : "neutralisation" de l'intitulé des value sets et des codes pour une utilisation transversale de la section
    03/07/17 : NMA : Ajout du test sur le nombre de templateIds et renommage du schématron
    28/07/17 : LBE : Correction de la syntaxe du test pour simple Observation
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_statutDoc">

    <title>ASIP Section Statut du document</title>
        
        
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.35"]'> 
            <!-- Verifier que le templateId est utilisé correctement --> 
            <assert test='../cda:section'> 
                [S_statutDoc] Erreur de conformité CI-SIS : 'Statut du document' ne peut être utilisé que comme section
            </assert> 
            <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "33557-0"]'> 
            [S_statutDoc] Erreur de conformité CI-SIS : Le code de la section 'Statut du document' doit être '33557-0'              
            </assert> 
            <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
                [S_statutDoc] Erreur de conformité CI-SIS :  L'élément 'codeSystem' de la section 
                'Statut du document' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
            </assert> 
            
        <assert test='cda:title'>
            [S_statutDoc] Erreur de conformité CI-SIS : Cette section doit avoir un titre significatif de son contenu.
        </assert>
        
        <assert test='count(cda:id)=1'>
            [S_statutDoc] Erreur de conformité CI-SIS : La section doit avoir un identifiant unique permettant de les identifier.
        </assert>
        
        <assert test="count(cda:templateId)=1">
            [S_statutDoc] Erreur de conformité CI-SIS : Un seul templateId doit être présent pour cette section
        </assert>
      
        <assert test="cda:entry/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
            [S_statutDoc] Erreur de conformité CI-SIS : Cette section comporte obligatoirement une simple Observation
        </assert>
        
        
        
        <!-- 
        <assert test="cda:entry/cda:observation/cda:code[@code='CDA_001'] and 
            cda:entry/cda:observation/cda:value[@code='CDA_002' or
            @code='RCP_003' or
            @code='RCP_004']">
            [statutDocSection]: La valeur donnée pour le Statut du document ne fait pas partie des valeurs permises.
        </assert>      -->  
    </rule>
</pattern>

