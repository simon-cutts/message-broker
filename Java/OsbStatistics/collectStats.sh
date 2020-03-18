#!/bin/sh
#
# WARNING: No longer required. Repalced by StatisticsWeb
#
# Gather statistics about the OSB on an hourly basis
#
# Requires 2 parameters:
#
#     username
#     password
#
#

MW_HOME=/u01/app/oracle/product/fmw

STATS_CLASSPATH=CLASSPATH:/u01/app/oracle/deployment_packages/release-1.0/osb/Statistics.jar:${MW_HOME}/wlserver_10.3/server/lib/weblogic.jar:${MW_HOME}/osb/lib/sb-kernel-api.jar:${MW_HOME}/osb/modules/com.bea.common.configfwk_1.6.0.0.jar:${MW_HOME}/modules/com.bea.core.management.core_2.9.0.1.jar:${MW_HOME}/modules/com.bea.core.management.jmx_1.4.2.0.jar:${MW_HOME}/osb/lib/sb-kernel-impl.jar
java -classpath ${STATS_CLASSPATH} uk.ac.open.osb.statistics.CollectorTask soa-dev-1.open.ac.uk 7001 $1 $2 /home/oracle/statistics