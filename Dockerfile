FROM debian
Maintainer TSI15
RUN apt-get update && apt-get install libxml2-utils
ADD /home/validate-XML.sh
RUN chmod +x /home/validate-XML.sh
