<?xml version="1.0" encoding="UTF-8"?>

<!-- CI-SIS, Volet deSysnthèse Médicale

        
        Auteur : NMA 
        Version : 0.1
        Historque :
        27/09/2019 NMA : Création 
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="VSM"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_VSM.sch">

        <title>Rapport de conformité du document aux spécifications du volet VSM</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

        <!--  Abstract patterns  -->
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>
        <include href="abstract/personName20110627.sch"/>


        <phase id="VSM">
                <active pattern="variables"/>
                <p>Vérification complète de la conformité au CI-SIS</p>


        </phase>
        <pattern id="variables">

                
                <rule context="cda:ClinicalDocument">
                        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.13']"> 
                                [VSM] Le template "Conformité au VSM" (1.2.250.1.213.1.1.1.13) doit être présent.
                        </assert>
                       <!-- <assert test="./cda:code[@code='SYNTH' and @codeSystem='1.2.250.1.213.1.1.4.12']"> 
                                [VSM] L'élément code doit avoir @code ="SYNTH" et @codeSystem = "1.2.250.1.213.1.1.4.12"/>. 
                        </assert>    -->
                </rule>
                
                <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody">
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.29']"> 
                                [VSM] Erreur de conformité au volet VSM : La section "Pathologies, antécédents, allergies et facteurs de risque" (1.2.250.1.213.1.1.2.29) doit être présente.
                        </assert>
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.27']"> 
                                [VSM] Erreur de conformité au volet VSM : La section "Résultats" (1.3.6.1.4.1.19376.1.5.3.1.3.27) doit être présente.
                        </assert>
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.32']"> 
                                [VSM] Erreur de conformité au volet VSM : La section "Traitement au long cours" (1.2.250.1.213.1.1.2.32) doit être présente.
                        </assert>
                </rule>
                
                <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.32']]">
                        <assert test="cda:component/cda:section[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.19']]/cda:text"> 
                            [VSM] Erreur de conformité au volet VSM : Dans une section "Traitements" (1.3.6.1.4.1.19376.1.5.3.1.3.19) l'élément text est obligatoire.
                    </assert>
                </rule>
                
        </pattern>
</schema>
