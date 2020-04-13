<?xml version="1.0" encoding="UTF-8"?>

<!-- Schématron du document CNAM-HR (Historique des remboursements)
        
        Auteur : ASIP Santé 
        Version : 0.1
        Historque :
        16/10/2019 : Création 
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="HR"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CNAM-HR.sch">

        <title>Rapport de conformité du document aux spécifications du volet CNAM-HR</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

        <!--  Abstract patterns  -->
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>
        <include href="abstract/personName20110627.sch"/>

        <phase id="HR">
                <active pattern="variables"/>
                <p>Vérification complète de la conformité au CI-SIS</p>
        </phase>
        <pattern id="variables">
                
                <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody">
                        <assert test="cda:component/cda:section/cda:templateId[@root='2.16.840.1.113883.10.20.1.8']"> 
                                [CNAM-HR] Erreur de conformité au volet CNAM-HR : La section "Traitements" (2.16.840.1.113883.10.20.1.8) doit être présente.
                        </assert>
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.23']"> 
                                [CNAM-HR] Erreur de conformité au volet CNAM-HR : La section "Vaccinations" (1.3.6.1.4.1.19376.1.5.3.1.3.23) doit être présente.
                        </assert>
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.1']"> 
                                [CNAM-HR] Erreur de conformité au volet CNAM-HR : La section "Dispositifs médicaux" (1.2.250.1.213.1.1.2.1) doit être présente.
                        </assert>
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.1.5.3.3']"> 
                                [CNAM-HR] Erreur de conformité au volet CNAM-HR : La section "Historique des prises en charge médicales (Hospitalisations)" (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.3) doit être présente.
                        </assert>
                        <assert test="cda:component/cda:section[cda:code/cda:translation[@code='67803-7']]/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11']"> 
                                [CNAM-HR] Erreur de conformité au volet CNAM-HR : La section "Actes et interventions (Soins médicaux ou dentaires)" (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11) doit être présente.
                        </assert>
                        <assert test="cda:component/cda:section[cda:code/cda:translation[@code='18726-0']]/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11']"> 
                                [CNAM-HR] Erreur de conformité au volet CNAM-HR : La section "Actes et interventions (Radiologie)" (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11) doit être présente.
                        </assert>
                        <assert test="cda:component/cda:section[cda:code/cda:translation[@code='26436-6']]/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11']"> 
                                [CNAM-HR] Erreur de conformité au volet CNAM-HR : La section "Actes et interventions (Biologie)" (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11) doit être présente.
                        </assert>
                </rule>
                
        </pattern>
</schema>
