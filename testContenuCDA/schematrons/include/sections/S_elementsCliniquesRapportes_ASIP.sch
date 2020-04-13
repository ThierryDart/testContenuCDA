<?xml version="1.0" encoding="UTF-8"?>

<!--  CI-SIS  Section: 1.2.250.1.213.1.1.2.46 -->

<!--                 Section Éléments cliniques rapportés ASIP Santé
    
    Teste la conformité de la section "Eléments Cliniques Rapportés" (1.2.250.1.213.1.1.2.46)
    aux spécifications du CI-SIS
   
   
    
    Historique :
    24/06/11 : CRI : Création
    13/12/16 : LBE : mise en commentaire de la condition imposant le code 55752-0.  Il faut discuter de la possibilité de publier une section générique et de la surcontraindre en fonction des besoins des volets
    17/08/2017 : LBE : Mise à jour aux nouvelles contraintes et conventions de nommage
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_elementsCliniquesRapportes_ASIP">
    <title>CI-SIS - Section Eléments Cliniques Rapportés</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.46"]'> 
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) :  'Eléments Cliniques Rapportés' ne peut être utilisé que comme section. 
        </assert> 
        <assert test="count(cda:id)">
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : L'élément doit contenir un id unique (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : Un élément texte doit être présent dans la section éléments cliniques rapportés
        </assert>
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "55107-7"]'> 
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : Le code de la section 'Eléments Cliniques Rapportés' doit être '55107-7' 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        
        <!-- Vérifier la présence d'un organizer 'Document Attaché' -->
        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.3.18"]'>
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : Cette section doit contenir un organizer 'Document Attaché'. 
        </assert> 
        
        <!-- Vérifier la présence d'un label 'Information Clinique' -->
        <assert test='(.//cda:templateId[@root = "1.2.250.1.213.1.1.3.18"])'>
           <!-- or(.//cda:organizer[cda:templateId/@root = "1.2.250.1.213.1.1.3.18"]/cda:component/cda:observation/cda:value/@code="55752-0")'>-->
            [S_elementsCliniquesRapportes_ASIP.sch] erreur de conformité CI-SIS (ASIP Santé) : L'organizer 'Document Attaché' de cette section doit être identifié comme 'Information Clinique'. 
        </assert> 

    </rule>
    
</pattern>