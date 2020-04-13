<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    humanSubstanceAdministrationSite20120830.sch :
    Contenu :
    Contrôle du code de la voie d'administration

    Paramètres d'appel :
        Néant 
    Historique :
        27/06/11 : CRI ASIP/PRAS : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="humanSubstanceAdministrationSite" is-a="dansJeuDeValeurs">
    <p>Conformité des demandes d'examen complémentaires</p>
    <param name="path_jdv" value="$jdv_humanSubstanceAdministrationSite"/>
    <param name="vue_elt" value="section/entry/substanceAdministration/approachSiteCode"/>
    <param name="xpath_elt" value="cda:section/cda:entry/cda:substanceAdministration/cda:approachSiteCode"/>
    <param name="nullFlavor" value="1"/>
</pattern>   


