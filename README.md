###Validation-XML
Validation d'un fichier XML et son XSD avec Docker

le But de notre application est de valider un fichier XML et son XSD sur une machine 
supportant Docker,donc pour se faire on va suivre les étapes suivantes:
##### 1) L'installation du docker
>>apt-get install docker.io

##### 2)La configuration du proxy pour notre image
>>mkdir /etc/systemed/system/docker.service.d

#####3)L'installation de l'éditeur de texte 'vim' pour le terminal sous Linux
>>apt-get install vim

#####4)on crée un fichier texte pour la configuration de proxy 
>>vim /etc/systemed/system/docker.service.d/http_proxy.conf
###### On ajoute la ligne suivante dans le fichier http_proxy.conf
Environnement="HTTP_PROXY=https://10.0.4.2:3128/"

#####5) Manipulation de l'image

nous avons maintenant besoin de prendre une image de départ Debian pour notre conteneur 

>>docker pull debian

#####6)configuration de l'image docker
######on crée un fichier 'Dockerfile'
vim Dockerfile
on ajout les lignes suivantes au fichier 'Dockerfile'
FROM debian
Maintainer TSI15
RUN apt-get update && apt-get install libxml2-utils
ADD /home/validate-XML.sh
RUN chmod +x /home/validate-XML.sh

##### 7)On crée ensuite le script shell 'validate-XML.sh'
 #!/bin/bash
xmllint --noout /répertoire/vers/xml-xsd/annuaire.xml --shema /répertoire/vers/xml-xsd/annuaire.xsd

##### 8) Construction du conteneur 'my_container'
>>docker build -t my_container ./

##### 9) Validation du fichier xml et son xsd :
A l'aide de la commande suivante on peut valider nos fichiers xml et xsd 
docker run -v /répertoire/vers/xml-xsd:/home my_container /home/validate-XML.sh annuaire.xml annuaire.xsd

##### 10)Résultat obtenu

home/annuaire.xml validates

