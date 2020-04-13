<?xml version="1.0" encoding="UTF-8"?>

<!--  Schématron de la Section Références externes
    
    Cette section contient des entrées Références Externes permettant de faire référence à d'autres documents
    
    Historique :
    31/01/2017 : Création
    04/07/2017 : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    08/08/2017 : Ajout des contraintes sur les id et le text
    02/10/2019 : Modification du code de la section (remplacement de 'LP72255-0' par '55107-7')
                 Correction des libellés des erreurs
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_citationDocuments">
    <title>CI-SIS Citation de documents Section</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.55"]'> 
        <!-- Verifier que le templateId est utilisé correctement -->         
        
        <assert test='../cda:section'> 
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé): La section Références externes ne peut être utilisée que comme section.
        </assert> 
        <assert test="count(cda:templateId)=1">
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : La section Références externes ne doit contenir qu'un seul templateId.
        </assert>
        <assert test="count(cda:id)=1">
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : La section Références externes doit contenir un et un seul élément id.
        </assert>
        <assert test="cda:text">
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : La section Références externes doit contenir un élément text.
        </assert>
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "55107-7"]'> 
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : Le code de la section Références externes doit être '55107-7'.              
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : L'élément 'codeSystem' de la section Références externes doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert> 
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.4"]'> 
            <!-- Vérifier que la section contient des éléments externalReference Entry -->
            [S_citationDocuments_ASIP.sch] Erreur de Conformité CI-SIS (ASIP Santé) : La section Références externes doit contenir des entrée de type "Références externes" (1.3.6.1.4.1.19376.1.5.3.1.4.4).
        </assert> 
    </rule> 
    
</pattern>