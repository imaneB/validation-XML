###Validation-XML
Validation d'un fichier XML et son XSD avec Docker

le But de notre application est de valider un fichier XML et son XSD sur une machine 
supportant Docker,donc pour se faire on va suivre les étapes suivantes:
##### 1) L'installation du docker
>>apt-get install docker.io

##### 2)La configuration du proxy pour notre image
>>mkdir /etc/systemed/system/docker.service.d

#####2-1)L'installation de l'éditeur de texte 'vim' pour le terminal sous Linux
>>apt-get install vim

#####2-2)on crée un fichier texte pour la configuration de proxy 
>>vim /etc/systemed/system/docker.service.d/http_proxy.conf
###### On ajoute la ligne suivante dans le fichier http_proxy.conf
Environnement="HTTP_PROXY=https://10.0.4.2:3128/"

#####3) Manipulation de l'image

nous avons maintenant besoin de prendre une image de départ Debian pour notre conteneur 

>>docker pull debian

#####4)configuration de l'image docker
######Créer un fichier 'Dockerfile' à l'aide de la commande:
vim Dockerfile
######Ajouter les lignes suivantes au fichier 'Dockerfile'
FROM debian

Maintainer TSI15

RUN apt-get update && apt-get install libxml2-utils

ADD /home/validate-XML.sh

RUN chmod +x /home/validate-XML.sh

le contenu du Dockerfile nous permet de déclarer la base avec laquelle le conteneur va travailler qui est debian
et il met à jour et télécharge la librairie libxml2-utils,ensuite on ajoute le script shell qui valide les fichiers xml et xsd
et enfin on donne les droits d'éxecution au script shell.


##### 5)On crée ensuite le script shell 'validate-XML.sh'
 #!/bin/bash
 
xmllint --noout /répertoire/vers/xml-xsd/annuaire.xml --shema /répertoire/vers/xml-xsd/annuaire.xsd

##### 6) Construction du conteneur 'my_container'
>>docker build -t my_container ./

##### 7) Validation du fichier xml et son xsd :
A l'aide de cette commande on peut valider nos fichiers xml et xsd 
docker run -v /répertoire/vers/xml-xsd:/home my_container /home/validate-XML.sh annuaire.xml annuaire.xsd

##### 8)Résultat obtenu

home/annuaire.xml validates

