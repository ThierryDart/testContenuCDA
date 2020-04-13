<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    BIOentry.sch :
    Contenu :
        Conformité structurelle d'une entrée résultats d'examens biologiques  
    Paramètres d'appel :
        Néant
    Historique :
    22/07/11 : FMY ASIP/PRAS : Création
    23/05/17 : NMA : Suppression du premier assert
    04/07/18 : NMA : Ajout du test de présence d'attributs pour le code de l'entryRelationship
    08/03/19 : NMA : Mise à jour du contrôl des attributs pour prendre en compte les cas où on n'a pas de code Loinc et pour tester les observations dans des organizers
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_BIOentry_CRBIO">
    <p>Conformité structurelle d'une entry d'un CR d'examens biologiques</p>
    <rule context="cda:entry/cda:templateId[@root=$templateEntry]">
       <!-- <assert test="./cda:templateId[@root=$templateEntry]"> 
            Erreur de conformité CR-BIO :
            une entry d'un CR de biologie doit se conformer au template 
            avec @root = "<value-of select="$templateEntry"/>". </assert>-->
        <assert test="../@typeCode"> 
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO :
            un élément entry d'un CR de biologie doit comporter l'attribut typeCode. </assert>
        <assert test="../cda:act and 
                (../cda:act/cda:code[@codeSystem = $OIDLOINC] or not(../cda:act/cda:code/@code))"> 
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO :
            Un élément entry doit avoir un élément fils act et le code de cet act s'il existe,
            doit appartenir à la terminologie LOINC. </assert>
        <assert test="../cda:act/cda:statusCode[@code = 'completed'] or
                ../cda:act/cda:statusCode[@code = 'active'] or
                ../cda:act/cda:statusCode[@code = 'aborted']"> 
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO :
            Un élément entry doit avoir un élément fils act avec un statusCode@code valant 
            'completed', 'active' ou 'aborted'. </assert>
        <assert test="../cda:act/cda:entryRelationship[@typeCode = 'COMP']">
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO : 
            Un élément entry doit avoir au moins un petit fils act/entryRelationship
            avec un attribut typeCode valant 'COMP'. </assert>
    </rule>
    <rule context="cda:entry[cda:templateId[@root=$templateEntry]]/cda:act/cda:entryRelationship/cda:observation">
        <assert test="cda:code[@code and @codeSystem=$OIDLOINC and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])">
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </assert>
    </rule>
    <rule context="cda:entry[cda:templateId[@root=$templateEntry]]/cda:act/cda:entryRelationship/cda:observation/cda:code/cda:translation">
        <assert test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)">
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
        </assert>
    </rule>
    
    <rule context="cda:entry[cda:templateId[@root=$templateEntry]]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation">
        <assert test="cda:code[@code and @codeSystem=$OIDLOINC and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])">
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </assert>
    </rule>
    <rule context="cda:entry[cda:templateId[@root=$templateEntry]]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation/cda:code/cda:translation">
        <assert test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)">
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
        </assert>
    </rule>
    <rule context="cda:entry[cda:templateId[@root=$templateEntry]]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation">
        <assert test="cda:code[@code and @codeSystem=$OIDLOINC and @displayName] or (cda:code[not(@code)] and cda:code[not(@displayName)] and cda:code[not(@codeSystemName)] and cda:code[not(@codeSystem)])">
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO : Si le code d'identification est un code universel LOINC, les attributs @code, @displayName et @codeSystem sont obligatoires.
        </assert>
    </rule>
    <rule context="cda:entry[cda:templateId[@root=$templateEntry]]/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:organizer/cda:component/cda:observation/cda:code/cda:translation">
        <assert test="(@code and @codeSystem='1.2.250.1.213.1.1.5.130' and @displayName and @codeSystemName) or (not(@codeSystem='1.2.250.1.213.1.1.5.130') and @code and @displayName and @codeSystemName)">
            [E_BIOentry_CRBIO] Erreur de conformité CR-BIO : Si le code d'identification est un code d'attente LOINC, les attributs @code, @displayName, @codeSystemName et @codeSystem sont obligatoires. Si le code d'identification est un code de portée locale, les attributs @code, @displayName et @codeSystemName sont obligatoires.
        </assert>
    </rule>
    
</pattern>
