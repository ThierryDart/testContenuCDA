<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   CI-SIS_TLM-DA.csh
   
   Auteur : ANS
   version : 0.5
   ......................................................................................................................................................    
   Historique :
   30/08/2019 : Création
   19/12/2019 : Corrections
   ......................................................................................................................................................       
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="TLM-DA"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_TLM-DA.sch">
        <title>Rapport de conformité du document TLM-DA</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
        
        <!-- Abstract patterns -->        
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>   
        <include href="abstract/personName20110627.sch"/>
 
        <!-- Sections spécifiques au document TLM-DA -->
        <include href="include/sections/S_anamneseEtFacteursDeRisques_FR.sch"/>
        <include href="include/sections/S_anamnese_FR.sch"/>
        <include href="include/sections/S_traitementsEtDispositifsMedicaux_FR.sch"/>
        
        <!-- Entrées spécifiques au document TLM-DA -->
        <!-- Néant -->
       
        <!-- Entete spécifiques au document TLM-DA -->
        <include href="include/specificationsVolets/TLM/Entete_TLM-DA.sch"/>
        
        
        <phase id="TLM-DA">
                <active pattern="variables"/>
                
                <!--Entete-->
                <active pattern="Entete_TLM-DA"/>
                
                <!--Corps-->
                <active pattern="S_anamneseEtFacteursDeRisques_FR"/>
                <active pattern="S_anamnese_FR"/>
                <active pattern="S_traitementsEtDispositifsMedicaux_FR"/>                
        </phase>

        <pattern id="variables">
                                
                <rule context="cda:ClinicalDocument">
                        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.38']"> 
                            [CI-SIS_TLM-DA] Le templateID du document TLM-DA (1.2.250.1.213.1.1.1.38) doit être présent.
                    </assert>                    
                </rule>
                
                <rule context='cda:ClinicalDocument/cda:component/cda:structuredBody'>
                        
                        <!-- Présence obligatoire de la section Anamnèse et facteurs de risques (1.2.250.1.213.1.1.2.68) -->
                        <assert test='cda:component/cda:section/cda:templateId[@root = "1.2.250.1.213.1.1.2.68"]'>
                                [Corps_TLM-DA.sch] Erreur de conformité document TLM-DA : La section Anamnèse et facteurs de risques (1.2.250.1.213.1.1.2.68) est obligatoire.  
                        </assert>
                            
                </rule>
                
                <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.68']]">
                        <!-- Présence obligatoire de la section Anamnèse (1.2.250.1.213.1.1.2.69) -->
                        <assert test="cda:component/cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.69']]"> 
                                [VSM] Erreur de conformité document TLM-DA : La section Anamnèse (1.2.250.1.213.1.1.2.69) est obligatoire.
                        </assert>
                </rule>
                
        </pattern>
</schema>
