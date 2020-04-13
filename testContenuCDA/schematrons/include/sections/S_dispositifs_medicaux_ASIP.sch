<?xml version="1.0" encoding="UTF-8"?>

<!-- Schématron Section Dispositifs médicaux ASIP 
    
   Teste la conformité de la section Dispositifs médicaux (1.2.250.1.213.1.1.2.1) créée par l'ASIP Santé
    
   Cette section est utilisée par les volets PRC, LDL et CNAM-HR
    
   Historique :
   17/08/2017 : Création
   16/10/2019 : Modification pour intégrer la nouvelle entrée de type 'supply' pour les DM, à la place de l'ancienne entrée de type 'organizer' conservée pour l'instant car utilisée dans les volets PRC et LDL.    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_dispositifs_medicaux_ASIP">
    <title>ASIP Santé Section dispositifs médicaux</title>
    
    <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test="$count_templateId = 1">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un seul templateId (cardinalité [1..1])
        </assert>
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un id (cardinalité [1..1])
        </assert>
        <assert test="cda:text">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section doit contenir un élément text
        </assert> 
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "46264-8"]'>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : Le code de la section Dispositifs médicaux doit être 46264-8 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'élément 'codeSystem' correspond à la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des entrées optionnelles (ancienne version de l'entrée Dispositif médical de type 'organizer' utilisée dans les volets PRC et LDL). -->
        <assert test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.2' or cda:entry/cda:supply/cda:templateId/@root='1.2.250.1.213.1.1.3.20'">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section Dispositifs médicaux doit contenir des entrées 'Dipositif médical' :
            - de type 'organizer' (1.2.250.1.213.1.1.3.2) (ancienne version utilisée uniquement pour les volets PRC et LDL) ;
            - de type 'supply' (1.2.250.1.213.1.1.3.20) (nouvelle version). 
        </assert>
        
    </rule>
    
    <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']/cda:entry/cda:organizer/cda:templateId">
        <assert test="not(../../../cda:entry/cda:supply)">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section Dispositifs médicaux doit contenir des entrées 'Dipositif médical' de type organizer (1.2.250.1.213.1.1.3.2) ou de type supply (1.2.250.1.213.1.1.3.20) mais pas les deux
        </assert>
        
        <report test="not(@root='1.2.250.1.213.1.1.3.2')">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section Dispositifs médicaux doit contenir des entrées 'Dipositif médical' de type 'organizer' (1.2.250.1.213.1.1.3.2) (ancienne version utilisée uniquement pour les volets PRC et LDL) ;
        </report> 
    </rule>
    
    <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.1']/cda:entry/cda:supply/cda:templateId">
        <report test="not(@root='1.2.250.1.213.1.1.3.20' or @root='2.16.840.1.113883.10.20.1.34')">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : La section Dispositifs médicaux doit contenir des entrées 'Dipositif médical' de type 'supply' (1.2.250.1.213.1.1.3.20 et 2.16.840.1.113883.10.20.1.35) (nouvelle version). 
        </report>
        <assert test="../cda:templateId/@root='1.2.250.1.213.1.1.3.20'">
            [S_dispositifs_medicaux_ASIP.sch] Erreur de Conformité CI-SIS (Section ASIP Santé) : L'entrée 'Dipositif médical' de type 'supply' doit avoir le templateId root="1.2.250.1.213.1.1.3.20"
        </assert>
    </rule>
    
</pattern>
