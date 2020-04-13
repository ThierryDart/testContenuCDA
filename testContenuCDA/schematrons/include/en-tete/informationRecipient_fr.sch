<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    informationRecipient_fr.sch :
    Contenu :
        Contrôle de la conformité de l'élément informationRecipient de l'en-tête en fonction du volet de structuration minimale
    Paramètres d'appel :
        Néant
    Historique :
        28/07/11 : FMY ASIP/PRAS : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="informationRecipient_fr">
    <rule context="cda:informationRecipient/cda:intendedRecipient">
        <let name="count_id" value="count(cda:id)"/>
        <assert test="cda:id[@root='1.2.250.1.71.4.2.1'] and cda:id[@extension]">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/id doit être présent avec l'attribut @root fixé à "1.2.250.1.71.4.2.1" et l'attribut @extension doit être présent
        </assert>
        <assert test="$count_id = 1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendRecipient/id doit être présent une seule fois (cardinalité [1..1])
        </assert>
        <assert test="cda:informationRecipient">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient doit être présent (cardinalité [1..1])
        </assert>
    </rule>
    <!-- règle testant l'élément receivedOrganization -->
    <rule context="cda:informationRecipient/cda:intendedRecipient/cda:receivedOrganization">
        <let name="count_id" value="count(cda:id)"/>
        <let name="count_name" value="count(cda:name)"/>
        <assert test="$count_id &lt;=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/receivedOrganization/id ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_name =1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/receivedOrganization/name doit être présent, mais qu'une seule fois (cardinalité [1..1])            
        </assert>
        
    </rule>
    <!-- règle testant l'élément informationRecipient -->
    <rule context="cda:informationRecipient/cda:intendedRecipient/cda:informationRecipient">
        <let name="count_name" value="count(cda:name)"/>
        <let name="count_family" value="count(cda:name/cda:family)"/>
        <let name="count_given" value="count(cda:name/cda:given)"/>
        <let name="count_prefix" value="count(cda:name/cda:prefix)"/>
         
        <assert test="$count_name &lt;=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient/name ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_family=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient/name/family doit être présent, mais qu'une seule fois (cardinalité [1..1])
        </assert>
        <assert test="$count_given &lt;=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient/name/given ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_prefix &lt;=1">
            [informationRecipient_fr.sch] Erreur de conformité au CI-SIS : L'élément intendedRecipient/informationRecipient/name/prefix ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
        </assert>
    </rule>
</pattern>