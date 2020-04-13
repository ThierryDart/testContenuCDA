<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    DLU_FLUDT 
   auteur : NMA
   version : 0.0.6 
   Ce volet décrit les données contenues dans un document de CR-BIO
   ......................................................................................................................................................    
    Historique :
       03/10/17 : NMA : Création
       14/03/18 : NMA : MAJ du pattern variables
       -->


<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CRBIO"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CR-BIO.sch">
    
	<title>Rapport de conformité du document aux spécifications du volet CR de Biologie</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
	
	
	<!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
	
	<include href="abstract/dansJeuDeValeurs.sch"/>
	<include href="abstract/IVL_TS.sch"/>   
	<include href="abstract/personName20110627.sch"/>

	<!-- Sections relatives au volet CR-BIO -->
	<include href="include/specificationsVolets/BIO/sections/S_BIOsectionN1Code_CRBIO.sch"/>
	<include href="include/specificationsVolets/BIO/sections/S_BIOsectionN1Struct_CRBIO.sch"/>
	<include href="include/specificationsVolets/BIO/sections/S_BIOsectionN2Struct_CRBIO.sch"/>
	
	
	<!-- Entrées relatives au volet CR-BIO -->
	<include href="include/specificationsVolets/BIO/entrees/E_BIOentry_CRBIO.sch"/>
	<include href="include/specificationsVolets/BIO/entrees/E_BIOexamen_CRBIO.sch"/>
	<include href="include/specificationsVolets/BIO/entrees/E_BIOisolat_CRBIO.sch"/>
	<include href="include/specificationsVolets/BIO/entrees/E_BIOlaboExecutant_CRBIO.sch"/>
	<include href="include/specificationsVolets/BIO/entrees/E_BIOprelevement_CRBIO.sch"/>
	<include href="include/specificationsVolets/BIO/entrees/E_BIOresultat_CRBIO.sch"/>
	
	<!-- Contraintes relatives à l'entête du volet CR-BIO -->
	
	<include href="include/specificationsVolets/BIO/entete/Entete_BIO.sch"/>
	
	<phase id="CRBIO">
		<active pattern="variables"/>
		<!-- activation des sections -->
		<active pattern="S_BIOsectionN1Struct_CRBIO"/>
		<active pattern="S_BIOsectionN1Code_CRBIO"/>
		<active pattern="S_BIOsectionN2Struct_CRBIO"/>
		
		<!-- Activation des entrées  -->
		<active pattern="E_BIOentry_CRBIO"/>
		<active pattern="E_BIOexamen_CRBIO"/>
		<active pattern="E_BIOisolat_CRBIO"/>
		<active pattern="E_BIOlaboExecutant_CRBIO"/>
		<active pattern="E_BIOprelevement_CRBIO"/>
		<active pattern="E_BIOresultat_CRBIO"/>
				
		<active pattern="Entete_BIO"/>
		
	</phase>
	
	
	
	<!-- ::::::::::::::::::::::::::::::::::::: -->
	<!--           Variables globales          -->
	<!-- ::::::::::::::::::::::::::::::::::::: -->
	
	<pattern id="variables">
		<let name="enteteHL7France" value="'2.16.840.1.113883.2.8.2.1'"/>               <!-- conformité guide en-tête CDA de HL7 France -->
		<let name="templateCRBiologie" value="'1.3.6.1.4.1.19376.1.3.3'"/>              <!-- conformité volet CR d'examens biologiques -->
		<let name="templateSectN1" value="'1.3.6.1.4.1.19376.1.3.3.2.1'"/>              <!-- conformité section N1 de CR de biologie -->
		<let name="templateSectN2" value="'1.3.6.1.4.1.19376.1.3.3.2.2'"/>              <!-- conformité section N2 de CR de biologie -->
		<let name="templateEntry" value="'1.3.6.1.4.1.19376.1.3.1'"/>                   <!-- conformité entry de CR de biologie -->
		<let name="templatePerformer" value="'1.3.6.1.4.1.19376.1.3.3.1.7'"/>           <!-- conformité exécutant examen ou analyse de biologie -->
		<let name="templatePartACP" value="'1.3.6.1.4.1.19376.1.8.1.4.7'"/>             <!-- conformité participant entry de CR-ACP ou biologie -->
		<let name="templateExamen" value="'1.3.6.1.4.1.19376.1.3.1.4'"/>                <!-- conformité examen biologique dans entry de CR-BIO -->
		<let name="templateIsolat" value="'1.3.6.1.4.1.19376.1.3.1.5'"/>                <!-- conformité isolat biologique dans entry de CR-BIO -->
		<let name="templateResultat" value="'1.3.6.1.4.1.19376.1.3.1.6'"/>              <!-- conformité résultat biologique dans entry de CR-BIO -->
		<let name="templateObservationMedia" value="'1.3.6.1.4.1.19376.1.8.1.4.10'"/>   <!-- conformité image illustrative dans observationMedia -->
		<let name="typeCodeCRBio" value="'11502-2'"/>                                   <!-- typeCode de CR d'examens biologiques -->
		<let name="OIDphysique" value="'1.2.250.1.71.4.2.1'"/>                          <!-- OID PS personnes physiques -->
		<let name="OIDmorale" value="'1.2.250.1.71.4.2.2'"/>                            <!-- OID PS personnes morales -->
		<let name="OIDINS-c" value="'1.2.250.1.213.1.4.2'"/>                            <!-- OID de l'INS-c -->
		<let name="OIDLOINC" value="'2.16.840.1.113883.6.1'"/>                          <!-- OID de LOINC -->
		<let name="OIDNABM" value="'1.2.250.1.213.2.7'"/>                               <!-- OID de NABM -->
		<let name="templateCRNonStructure" value="'1.2.250.1.213.1.1.2.60'"/>           <!-- conformité volet CR non structuré -->
		<!-- chemins relatifs des fichiers jeux de valeurs -->
		<let name="jdv_chapitresBiologie" value="'../jeuxDeValeurs/JDV_BIO_Chapitres-CISIS.xml'"/>
		<let name="jdv_interpretation" value="'../jeuxDeValeurs/JDV_BIO_Interpretation-CISIS.xml'"/>

		
		<rule context="cda:ClinicalDocument">
			<assert test="./cda:templateId[@root=$templateCRBiologie]"> 
				[CI-SIS_CRBiologie] Erreur de conformité CR-BIO :
				L'élément ClinicalDocument/templateId doit être présent 
				avec @root = "<value-of select="$templateCRBiologie"/>".</assert>
			<assert test="./cda:code[@code=$typeCodeCRBio and @codeSystem=$OIDLOINC]"> 
				[CI-SIS_CRBiologie] Erreur de conformité CR-BIO : 
				L'élément code doit avoir @code = <value-of select="$typeCodeCRBio"/> et @codeSystem = <value-of select="$OIDLOINC"/>. </assert>
			<assert
				test="./cda:versionNumber[@value] and number(./cda:versionNumber/@value) &gt; 0">
				[CI-SIS_CRBiologie] Erreur de conformité CR-BIO : 
				L'élément "versionNumber" doit être présent dans l'en-tête, avec un attribut @value contenant un entier positif. </assert>
			<assert
				test="not(./cda:versionNumber[@nullFlavor])">
				[CI-SIS_CRBiologie] Erreur de conformité CR-BIO : 
				L'attribut nullFlavor est interdit pour l'élément "versionNumber". </assert>
		</rule>
	</pattern>
</schema>
