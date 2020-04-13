<?xml version="1.0" encoding="UTF-8"?>


<!-- 
    CI-SIS_LDL.sch - ASIP/PML
   
    ......................................................................................................................................................    
    Historique :
        16/08/16 : JDU : Création
        19/12/16 : NMA : Modification des entrées, sections et JDV
        14/03/18 : NMA : MAJ du pattern Variables
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="LDL-SES"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_LDL_SES.sch">
    <title>Rapport de conformité du document aux spécifications du volet LDL-SES</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!--  Abstract patterns  -->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>
 

    <!--=<<o#%@O[ JDV ]O@%#o>>=-->
    <include href="include/jeuxDeValeurs/LDL/JDV_ModaliteEntree_LDL.sch"/>
    <include href="include/jeuxDeValeurs/LDL/JDV_ModaliteSortie_LDL.sch"/>

    <!--Entete-->
    <include href="include/specificationsVolets/LDL/SES/Entete/Entete_LDL_SES.sch"/>
    
    <phase id="LDL-SES">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>

        <!-- Activation values sets -->
        <active pattern="JDV_ModaliteEntree_LDL"/>
        <active pattern="JDV_ModaliteSortie_LDL"/>

        <!--Entete-->
        <active pattern="Entete_LDL_SES"/>
        
    </phase>
    
    <pattern id="variables">
 
        <let name="jdv_LDL_ModaliteEntree" value="'../jeuxDeValeurs/JDV_ModaliteEntree_CI-SIS.xml'"/>
        <let name="jdv_LDL_ModaliteSortie" value="'../jeuxDeValeurs/JDV_ModaliteSortie_CI-SIS.xml'"/>
        
    </pattern>
    
    
</schema>