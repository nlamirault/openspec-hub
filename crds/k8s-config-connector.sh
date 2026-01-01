#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  # Accesscontextmanager
  "accesscontextmanager_v1alpha1_accesscontextmanageraccesslevelcondition.yaml"
  "accesscontextmanager_v1alpha1_accesscontextmanagergcpuseraccessbinding.yaml"
  "accesscontextmanager_v1beta1_accesscontextmanageraccesslevel.yaml"
  "accesscontextmanager_v1beta1_accesscontextmanageraccesspolicy.yaml"
  "accesscontextmanager_v1beta1_accesscontextmanagerserviceperimeter.yaml"
  "accesscontextmanager_v1beta1_accesscontextmanagerserviceperimeterresource.yaml"

  # Aiplatform
  "aiplatform_v1alpha1_aiplatformmodel.yaml"

  # Alloydb
  "alloydb_v1beta1_alloydbbackup.yaml"
  "alloydb_v1beta1_alloydbcluster.yaml"
  "alloydb_v1beta1_alloydbinstance.yaml"
  "alloydb_v1beta1_alloydbuser.yaml"

  # Analytics
  "analytics_v1alpha1_analyticsaccount.yaml"

  # Apigateway
  "apigateway_v1alpha1_apigatewayapiconfig.yaml"
  "apigateway_v1alpha1_apigatewaygateway.yaml"
  "apigateway_v1beta1_apigatewayapi.yaml"

  # Apigee
  "apigee_v1alpha1_apigeeaddonsconfig.yaml"
  "apigee_v1alpha1_apigeenataddress.yaml"
  "apigee_v1alpha1_apigeesyncauthorization.yaml"
  "apigee_v1beta1_apigeeendpointattachment.yaml"
  "apigee_v1beta1_apigeeenvgroup.yaml"
  "apigee_v1beta1_apigeeenvgroupattachment.yaml"
  "apigee_v1beta1_apigeeenvironment.yaml"
  "apigee_v1beta1_apigeeinstance.yaml"
  "apigee_v1beta1_apigeeinstanceattachment.yaml"
  "apigee_v1beta1_apigeeorganization.yaml"

  # Apikeys
  "apikeys_v1alpha1_apikeyskey.yaml"

  # Appengine
  "appengine_v1alpha1_appenginedomainmapping.yaml"
  "appengine_v1alpha1_appenginefirewallrule.yaml"
  "appengine_v1alpha1_appengineflexibleappversion.yaml"
  "appengine_v1alpha1_appengineservicesplittraffic.yaml"
  "appengine_v1alpha1_appenginestandardappversion.yaml"

  # Apphub
  "apphub_v1alpha1_apphubdiscoveredservice.yaml"
  "apphub_v1alpha1_apphubdiscoveredworkload.yaml"
  "apphub_v1beta1_apphubapplication.yaml"

  # Artifactregistry
  "artifactregistry_v1beta1_artifactregistryrepository.yaml"

  # Asset
  "asset_v1beta1_assetfeed.yaml"
  "asset_v1beta1_assetsavedquery.yaml"

  # Assuredworkloads
  "assuredworkloads_v1alpha1_assuredworkloadsworkload.yaml"

  # Backupdr
  "backupdr_v1alpha1_backupdrmanagementserver.yaml"
  "backupdr_v1beta1_backupdrbackupplan.yaml"
  "backupdr_v1beta1_backupdrbackupplanassociation.yaml"
  "backupdr_v1beta1_backupdrbackupvault.yaml"

  # Batch
  "batch_v1alpha1_batchjob.yaml"
  "batch_v1alpha1_batchtask.yaml"

  # Beyondcorp
  "beyondcorp_v1alpha1_beyondcorpappconnection.yaml"
  "beyondcorp_v1alpha1_beyondcorpappconnector.yaml"
  "beyondcorp_v1alpha1_beyondcorpappgateway.yaml"

  # Bigquery
  "bigquery_v1alpha1_bigquerydatasetaccess.yaml"
  "bigquery_v1beta1_bigquerydataset.yaml"
  "bigquery_v1beta1_bigqueryjob.yaml"
  "bigquery_v1beta1_bigqueryroutine.yaml"
  "bigquery_v1beta1_bigquerytable.yaml"

  # Bigqueryanalyticshub
  "bigqueryanalyticshub_v1beta1_bigqueryanalyticshubdataexchange.yaml"
  "bigqueryanalyticshub_v1beta1_bigqueryanalyticshublisting.yaml"

  # Bigquerybiglake
  "bigquerybiglake_v1alpha1_biglakecatalog.yaml"
  "bigquerybiglake_v1alpha1_biglakedatabase.yaml"
  "bigquerybiglake_v1beta1_biglaketable.yaml"

  # Bigqueryconnection
  "bigqueryconnection_v1beta1_bigqueryconnectionconnection.yaml"

  # Bigquerydatapolicy
  "bigquerydatapolicy_v1alpha1_bigquerydatapolicy.yaml"
  "bigquerydatapolicy_v1alpha1_bigquerydatapolicydatapolicy.yaml"

  # Bigquerydatatransfer
  "bigquerydatatransfer_v1beta1_bigquerydatatransferconfig.yaml"

  # Bigqueryreservation
  "bigqueryreservation_v1alpha1_bigqueryreservationcapacitycommitment.yaml"
  "bigqueryreservation_v1beta1_bigqueryreservationassignment.yaml"
  "bigqueryreservation_v1beta1_bigqueryreservationreservation.yaml"

  # Bigtable
  "bigtable_v1alpha1_bigtableauthorizedview.yaml"
  "bigtable_v1alpha1_bigtablebackup.yaml"
  "bigtable_v1alpha1_bigtablecluster.yaml"
  "bigtable_v1alpha1_bigtablelogicalview.yaml"
  "bigtable_v1alpha1_bigtablematerializedview.yaml"
  "bigtable_v1beta1_bigtableappprofile.yaml"
  "bigtable_v1beta1_bigtablegcpolicy.yaml"
  "bigtable_v1beta1_bigtableinstance.yaml"
  "bigtable_v1beta1_bigtabletable.yaml"

  # Billing
  "billing_v1alpha1_billingaccount.yaml"

  # Billingbudgets
  "billingbudgets_v1beta1_billingbudgetsbudget.yaml"

  # Binaryauthorization
  "binaryauthorization_v1beta1_binaryauthorizationattestor.yaml"
  "binaryauthorization_v1beta1_binaryauthorizationpolicy.yaml"

  # Certificatemanager
  "certificatemanager_v1alpha1_certificatemanagercertificateissuanceconfig.yaml"
  "certificatemanager_v1beta1_certificatemanagercertificate.yaml"
  "certificatemanager_v1beta1_certificatemanagercertificatemap.yaml"
  "certificatemanager_v1beta1_certificatemanagercertificatemapentry.yaml"
  "certificatemanager_v1beta1_certificatemanagerdnsauthorization.yaml"

  # Cloudasset
  "cloudasset_v1alpha1_cloudassetfolderfeed.yaml"
  "cloudasset_v1alpha1_cloudassetorganizationfeed.yaml"
  "cloudasset_v1alpha1_cloudassetprojectfeed.yaml"

  # Cloudbuild
  "cloudbuild_v1beta1_cloudbuildtrigger.yaml"
  "cloudbuild_v1beta1_cloudbuildworkerpool.yaml"

  # Clouddeploy
  "clouddeploy_v1alpha1_clouddeploydeploypolicy.yaml"
  "clouddeploy_v1alpha1_deploycustomtargettype.yaml"
  "clouddeploy_v1beta1_clouddeploydeliverypipeline.yaml"

  # Clouddms
  "clouddms_v1alpha1_clouddmsconversionworkspace.yaml"
  "clouddms_v1alpha1_clouddmsmigrationjob.yaml"
  "clouddms_v1alpha1_clouddmsprivateconnection.yaml"

  # Cloudfunctions
  "cloudfunctions_v1beta1_cloudfunctionsfunction.yaml"

  # Cloudfunctions2
  "cloudfunctions2_v1alpha1_cloudfunctions2function.yaml"

  # Cloudidentity
  "cloudidentity_v1beta1_cloudidentitygroup.yaml"
  "cloudidentity_v1beta1_cloudidentitymembership.yaml"

  # Cloudids
  "cloudids_v1beta1_cloudidsendpoint.yaml"

  # Cloudiot
  "cloudiot_v1alpha1_cloudiotdevice.yaml"
  "cloudiot_v1alpha1_cloudiotdeviceregistry.yaml"

  # Cloudquota
  "cloudquota_v1beta1_apiquotaadjustersettings.yaml"
  "cloudquota_v1beta1_apiquotapreference.yaml"

  # Cloudscheduler
  "cloudscheduler_v1beta1_cloudschedulerjob.yaml"

  # Cloudtasks
  "cloudtasks_v1alpha1_tasksqueue.yaml"

  # Colab
  "colab_v1alpha1_colabruntime.yaml"
  "colab_v1alpha1_colabruntimetemplate.yaml"

  # Composer
  "composer_v1beta1_composerenvironment.yaml"

  # Compute
  "compute_v1alpha1_computeautoscaler.yaml"
  "compute_v1alpha1_computebackendbucketsignedurlkey.yaml"
  "compute_v1alpha1_computebackendservicesignedurlkey.yaml"
  "compute_v1alpha1_computediskresourcepolicyattachment.yaml"
  "compute_v1alpha1_computeglobalnetworkendpoint.yaml"
  "compute_v1alpha1_computeglobalnetworkendpointgroup.yaml"
  "compute_v1alpha1_computeinstancegroupnamedport.yaml"
  "compute_v1alpha1_computeinterconnect.yaml"
  "compute_v1alpha1_computemachineimage.yaml"
  "compute_v1alpha1_computenetworkattachment.yaml"
  "compute_v1alpha1_computenetworkedgesecurityservice.yaml"
  "compute_v1alpha1_computenetworkendpoint.yaml"
  "compute_v1alpha1_computenetworkfirewallpolicyrule.yaml"
  "compute_v1alpha1_computenetworkpeeringroutesconfig.yaml"
  "compute_v1alpha1_computeorganizationsecuritypolicy.yaml"
  "compute_v1alpha1_computeorganizationsecuritypolicyassociation.yaml"
  "compute_v1alpha1_computeorganizationsecuritypolicyrule.yaml"
  "compute_v1alpha1_computeperinstanceconfig.yaml"
  "compute_v1alpha1_computeregionautoscaler.yaml"
  "compute_v1alpha1_computeregiondiskresourcepolicyattachment.yaml"
  "compute_v1alpha1_computeregionperinstanceconfig.yaml"
  "compute_v1alpha1_computeregionsslpolicy.yaml"
  "compute_v1beta1_computeaddress.yaml"
  "compute_v1beta1_computebackendbucket.yaml"
  "compute_v1beta1_computebackendservice.yaml"
  "compute_v1beta1_computedisk.yaml"
  "compute_v1beta1_computeexternalvpngateway.yaml"
  "compute_v1beta1_computefirewall.yaml"
  "compute_v1beta1_computefirewallpolicy.yaml"
  "compute_v1beta1_computefirewallpolicyassociation.yaml"
  "compute_v1beta1_computefirewallpolicyrule.yaml"
  "compute_v1beta1_computeforwardingrule.yaml"
  "compute_v1beta1_computehealthcheck.yaml"
  "compute_v1beta1_computehttphealthcheck.yaml"
  "compute_v1beta1_computehttpshealthcheck.yaml"
  "compute_v1beta1_computeimage.yaml"
  "compute_v1beta1_computeinstance.yaml"
  "compute_v1beta1_computeinstancegroup.yaml"
  "compute_v1beta1_computeinstancegroupmanager.yaml"
  "compute_v1beta1_computeinstancetemplate.yaml"
  "compute_v1beta1_computeinterconnectattachment.yaml"
  "compute_v1beta1_computemanagedsslcertificate.yaml"
  "compute_v1beta1_computenetwork.yaml"
  "compute_v1beta1_computenetworkendpointgroup.yaml"
  "compute_v1beta1_computenetworkfirewallpolicy.yaml"
  "compute_v1beta1_computenetworkfirewallpolicyassociation.yaml"
  "compute_v1beta1_computenetworkpeering.yaml"
  "compute_v1beta1_computenodegroup.yaml"
  "compute_v1beta1_computenodetemplate.yaml"
  "compute_v1beta1_computepacketmirroring.yaml"
  "compute_v1beta1_computeprojectmetadata.yaml"
  "compute_v1beta1_computeregionnetworkendpointgroup.yaml"
  "compute_v1beta1_computereservation.yaml"
  "compute_v1beta1_computeresourcepolicy.yaml"
  "compute_v1beta1_computeroute.yaml"
  "compute_v1beta1_computerouter.yaml"
  "compute_v1beta1_computerouterinterface.yaml"
  "compute_v1beta1_computerouternat.yaml"
  "compute_v1beta1_computerouterpeer.yaml"
  "compute_v1beta1_computesecuritypolicy.yaml"
  "compute_v1beta1_computeserviceattachment.yaml"
  "compute_v1beta1_computesharedvpchostproject.yaml"
  "compute_v1beta1_computesharedvpcserviceproject.yaml"
  "compute_v1beta1_computesnapshot.yaml"
  "compute_v1beta1_computesslcertificate.yaml"
  "compute_v1beta1_computesslpolicy.yaml"
  "compute_v1beta1_computesubnetwork.yaml"
  "compute_v1beta1_computetargetgrpcproxy.yaml"
  "compute_v1beta1_computetargethttpproxy.yaml"
  "compute_v1beta1_computetargethttpsproxy.yaml"
  "compute_v1beta1_computetargetinstance.yaml"
  "compute_v1beta1_computetargetpool.yaml"
  "compute_v1beta1_computetargetsslproxy.yaml"
  "compute_v1beta1_computetargettcpproxy.yaml"
  "compute_v1beta1_computetargetvpngateway.yaml"
  "compute_v1beta1_computeurlmap.yaml"
  "compute_v1beta1_computevpngateway.yaml"
  "compute_v1beta1_computevpntunnel.yaml"

  # Configcontroller
  "configcontroller_v1beta1_configcontrollerinstance.yaml"

  # Configdelivery
  "configdelivery_v1alpha1_configdeliveryresourcebundle.yaml"

  # Container
  "container_v1beta1_containercluster.yaml"
  "container_v1beta1_containernodepool.yaml"

  # Containeranalysis
  "containeranalysis_v1alpha1_containeranalysisoccurrence.yaml"
  "containeranalysis_v1beta1_containeranalysisnote.yaml"

  # Containerattached
  "containerattached_v1beta1_containerattachedcluster.yaml"

  # Datacatalog
  "datacatalog_v1alpha1_datacatalogentry.yaml"
  "datacatalog_v1alpha1_datacatalogentrygroup.yaml"
  "datacatalog_v1alpha1_datacatalogtag.yaml"
  "datacatalog_v1alpha1_datacatalogtagtemplate.yaml"
  "datacatalog_v1beta1_datacatalogpolicytag.yaml"
  "datacatalog_v1beta1_datacatalogtaxonomy.yaml"

  # Dataflow
  "dataflow_v1beta1_dataflowflextemplatejob.yaml"
  "dataflow_v1beta1_dataflowjob.yaml"

  # Dataform
  "dataform_v1beta1_dataformrepository.yaml"

  # Datafusion
  "datafusion_v1beta1_datafusioninstance.yaml"

  # Dataplex
  "dataplex_v1alpha1_dataplexentrygroup.yaml"
  "dataplex_v1alpha1_dataplexentrytype.yaml"
  "dataplex_v1alpha1_dataplexlake.yaml"
  "dataplex_v1alpha1_dataplextask.yaml"
  "dataplex_v1alpha1_dataplexzone.yaml"

  # Dataproc
  "dataproc_v1alpha1_dataprocbatch.yaml"
  "dataproc_v1alpha1_dataprocjob.yaml"
  "dataproc_v1alpha1_dataprocnodegroup.yaml"
  "dataproc_v1beta1_dataprocautoscalingpolicy.yaml"
  "dataproc_v1beta1_dataproccluster.yaml"
  "dataproc_v1beta1_dataprocworkflowtemplate.yaml"

  # Datastore
  "datastore_v1alpha1_datastoreindex.yaml"

  # Datastream
  "datastream_v1alpha1_datastreamconnectionprofile.yaml"
  "datastream_v1alpha1_datastreamprivateconnection.yaml"
  "datastream_v1alpha1_datastreamroute.yaml"
  "datastream_v1alpha1_datastreamstream.yaml"

  # Deploymentmanager
  "deploymentmanager_v1alpha1_deploymentmanagerdeployment.yaml"

  # Dialogflow
  "dialogflow_v1alpha1_dialogflowagent.yaml"
  "dialogflow_v1alpha1_dialogflowentitytype.yaml"
  "dialogflow_v1alpha1_dialogflowfulfillment.yaml"
  "dialogflow_v1alpha1_dialogflowintent.yaml"

  # Dialogflowcx
  "dialogflowcx_v1alpha1_dialogflowcxagent.yaml"
  "dialogflowcx_v1alpha1_dialogflowcxentitytype.yaml"
  "dialogflowcx_v1alpha1_dialogflowcxflow.yaml"
  "dialogflowcx_v1alpha1_dialogflowcxintent.yaml"
  "dialogflowcx_v1alpha1_dialogflowcxpage.yaml"
  "dialogflowcx_v1alpha1_dialogflowcxwebhook.yaml"

  # Discoveryengine
  "discoveryengine_v1alpha1_discoveryenginedatastore.yaml"
  "discoveryengine_v1alpha1_discoveryenginedatastoretargetsite.yaml"
  "discoveryengine_v1alpha1_discoveryengineengine.yaml"

  # Dlp
  "dlp_v1beta1_dlpdeidentifytemplate.yaml"
  "dlp_v1beta1_dlpinspecttemplate.yaml"
  "dlp_v1beta1_dlpjobtrigger.yaml"
  "dlp_v1beta1_dlpstoredinfotype.yaml"

  # Dns
  "dns_v1alpha1_dnsresponsepolicy.yaml"
  "dns_v1alpha1_dnsresponsepolicyrule.yaml"
  "dns_v1beta1_dnsmanagedzone.yaml"
  "dns_v1beta1_dnspolicy.yaml"
  "dns_v1beta1_dnsrecordset.yaml"

  # Documentai
  "documentai_v1alpha1_documentaiprocessor.yaml"
  "documentai_v1alpha1_documentaiprocessordefaultversion.yaml"
  "documentai_v1beta1_documentaiprocessorversion.yaml"

  # Edgecontainer
  "edgecontainer_v1alpha1_edgecontainermachine.yaml"
  "edgecontainer_v1beta1_edgecontainercluster.yaml"
  "edgecontainer_v1beta1_edgecontainernodepool.yaml"
  "edgecontainer_v1beta1_edgecontainervpnconnection.yaml"

  # Edgenetwork
  "edgenetwork_v1beta1_edgenetworknetwork.yaml"
  "edgenetwork_v1beta1_edgenetworksubnet.yaml"

  # Essentialcontacts
  "essentialcontacts_v1beta1_essentialcontactscontact.yaml"

  # Eventarc
  "eventarc_v1alpha1_eventarcchannel.yaml"
  "eventarc_v1alpha1_eventarcgooglechannelconfig.yaml"
  "eventarc_v1beta1_eventarctrigger.yaml"

  # Filestore
  "filestore_v1alpha1_filestoresnapshot.yaml"
  "filestore_v1beta1_filestorebackup.yaml"
  "filestore_v1beta1_filestoreinstance.yaml"

  # Firebase
  "firebase_v1alpha1_firebaseandroidapp.yaml"
  "firebase_v1alpha1_firebaseproject.yaml"
  "firebase_v1alpha1_firebasewebapp.yaml"

  # Firebasedatabase
  "firebasedatabase_v1alpha1_firebasedatabaseinstance.yaml"

  # Firebasehosting
  "firebasehosting_v1alpha1_firebasehostingchannel.yaml"
  "firebasehosting_v1alpha1_firebasehostingsite.yaml"

  # Firebasestorage
  "firebasestorage_v1alpha1_firebasestoragebucket.yaml"

  # Firestore
  "firestore_v1alpha1_firestorebackupschedule.yaml"
  "firestore_v1alpha1_firestoredocument.yaml"
  "firestore_v1alpha1_firestorefield.yaml"
  "firestore_v1beta1_firestoredatabase.yaml"
  "firestore_v1beta1_firestoreindex.yaml"

  # Gkebackup
  "gkebackup_v1alpha1_gkebackupbackup.yaml"
  "gkebackup_v1alpha1_gkebackupbackupplan.yaml"
  "gkebackup_v1alpha1_gkebackuprestore.yaml"
  "gkebackup_v1alpha1_gkebackuprestoreplan.yaml"

  # Gkehub
  "gkehub_v1beta1_gkehubfeature.yaml"
  "gkehub_v1beta1_gkehubfeaturemembership.yaml"
  "gkehub_v1beta1_gkehubmembership.yaml"

  # Healthcare
  "healthcare_v1alpha1_healthcareconsentstore.yaml"
  "healthcare_v1alpha1_healthcaredataset.yaml"
  "healthcare_v1alpha1_healthcaredicomstore.yaml"
  "healthcare_v1alpha1_healthcarefhirstore.yaml"
  "healthcare_v1alpha1_healthcarehl7v2store.yaml"

  # Iam
  "iam_v1alpha1_iamdenypolicy.yaml"
  "iam_v1beta1_iamaccessboundarypolicy.yaml"
  "iam_v1beta1_iamauditconfig.yaml"
  "iam_v1beta1_iamcustomrole.yaml"
  "iam_v1beta1_iampartialpolicy.yaml"
  "iam_v1beta1_iampolicy.yaml"
  "iam_v1beta1_iampolicymember.yaml"
  "iam_v1beta1_iamserviceaccount.yaml"
  "iam_v1beta1_iamserviceaccountkey.yaml"
  "iam_v1beta1_iamworkforcepool.yaml"
  "iam_v1beta1_iamworkforcepoolprovider.yaml"
  "iam_v1beta1_iamworkloadidentitypool.yaml"
  "iam_v1beta1_iamworkloadidentitypoolprovider.yaml"

  # Iap
  "iap_v1beta1_iapbrand.yaml"
  "iap_v1beta1_iapidentityawareproxyclient.yaml"
  "iap_v1beta1_iapsettings.yaml"

  # Identityplatform
  "identityplatform_v1alpha1_identityplatformdefaultsupportedidpconfig.yaml"
  "identityplatform_v1alpha1_identityplatforminboundsamlconfig.yaml"
  "identityplatform_v1alpha1_identityplatformprojectdefaultconfig.yaml"
  "identityplatform_v1alpha1_identityplatformtenantdefaultsupportedidpconfig.yaml"
  "identityplatform_v1alpha1_identityplatformtenantinboundsamlconfig.yaml"
  "identityplatform_v1beta1_identityplatformconfig.yaml"
  "identityplatform_v1beta1_identityplatformoauthidpconfig.yaml"
  "identityplatform_v1beta1_identityplatformtenant.yaml"
  "identityplatform_v1beta1_identityplatformtenantoauthidpconfig.yaml"

  # Kms
  "kms_v1alpha1_kmscryptokeyversion.yaml"
  "kms_v1alpha1_kmskeyringimportjob.yaml"
  "kms_v1alpha1_kmssecretciphertext.yaml"
  "kms_v1beta1_kmsautokeyconfig.yaml"
  "kms_v1beta1_kmscryptokey.yaml"
  "kms_v1beta1_kmsimportjob.yaml"
  "kms_v1beta1_kmskeyhandle.yaml"
  "kms_v1beta1_kmskeyring.yaml"

  # Logging
  "logging_v1alpha1_logginglink.yaml"
  "logging_v1beta1_logginglogbucket.yaml"
  "logging_v1beta1_logginglogexclusion.yaml"
  "logging_v1beta1_logginglogmetric.yaml"
  "logging_v1beta1_logginglogsink.yaml"
  "logging_v1beta1_logginglogview.yaml"

  # Managedkafka
  "managedkafka_v1alpha1_managedkafkaconsumergroup.yaml"
  "managedkafka_v1beta1_managedkafkacluster.yaml"
  "managedkafka_v1beta1_managedkafkatopic.yaml"

  # Memcache
  "memcache_v1beta1_memcacheinstance.yaml"

  # Memorystore
  "memorystore_v1alpha1_memorystoreinstance.yaml"

  # Metastore
  "metastore_v1alpha1_metastorefederation.yaml"
  "metastore_v1alpha1_metastoreservice.yaml"
  "metastore_v1beta1_metastorebackup.yaml"

  # Mlengine
  "mlengine_v1alpha1_mlenginemodel.yaml"

  # Monitoring
  "monitoring_v1beta1_monitoringalertpolicy.yaml"
  "monitoring_v1beta1_monitoringdashboard.yaml"
  "monitoring_v1beta1_monitoringgroup.yaml"
  "monitoring_v1beta1_monitoringmetricdescriptor.yaml"
  "monitoring_v1beta1_monitoringmonitoredproject.yaml"
  "monitoring_v1beta1_monitoringnotificationchannel.yaml"
  "monitoring_v1beta1_monitoringservice.yaml"
  "monitoring_v1beta1_monitoringservicelevelobjective.yaml"
  "monitoring_v1beta1_monitoringuptimecheckconfig.yaml"

  # Netapp
  "netapp_v1alpha1_netappbackuppolicy.yaml"
  "netapp_v1alpha1_netappbackupvault.yaml"

  # Networkconnectivity
  "networkconnectivity_v1alpha1_networkconnectivityinternalrange.yaml"
  "networkconnectivity_v1alpha1_networkconnectivityserviceconnectionpolicy.yaml"
  "networkconnectivity_v1beta1_networkconnectivityhub.yaml"
  "networkconnectivity_v1beta1_networkconnectivityspoke.yaml"

  # Networkmanagement
  "networkmanagement_v1alpha1_networkmanagementconnectivitytest.yaml"

  # Networksecurity
  "networksecurity_v1beta1_networksecurityauthorizationpolicy.yaml"
  "networksecurity_v1beta1_networksecurityclienttlspolicy.yaml"
  "networksecurity_v1beta1_networksecurityservertlspolicy.yaml"

  # Networkservices
  "networkservices_v1alpha1_networkservicesedgecachekeyset.yaml"
  "networkservices_v1alpha1_networkservicesedgecacheorigin.yaml"
  "networkservices_v1alpha1_networkservicesedgecacheservice.yaml"
  "networkservices_v1alpha1_networkservicesservicebinding.yaml"
  "networkservices_v1beta1_networkservicesendpointpolicy.yaml"
  "networkservices_v1beta1_networkservicesgateway.yaml"
  "networkservices_v1beta1_networkservicesgrpcroute.yaml"
  "networkservices_v1beta1_networkserviceshttproute.yaml"
  "networkservices_v1beta1_networkservicesmesh.yaml"
  "networkservices_v1beta1_networkservicestcproute.yaml"
  "networkservices_v1beta1_networkservicestlsroute.yaml"

  # Notebooks
  "notebooks_v1alpha1_notebooksenvironment.yaml"
  "notebooks_v1beta1_notebookinstance.yaml"

  # Orgpolicy
  "orgpolicy_v1alpha1_orgpolicypolicy.yaml"
  "orgpolicy_v1beta1_orgpolicycustomconstraint.yaml"

  # Osconfig
  "osconfig_v1alpha1_osconfigpatchdeployment.yaml"
  "osconfig_v1beta1_osconfigguestpolicy.yaml"
  "osconfig_v1beta1_osconfigospolicyassignment.yaml"

  # Oslogin
  "oslogin_v1alpha1_osloginsshpublickey.yaml"

  # Privateca
  "privateca_v1beta1_privatecacapool.yaml"
  "privateca_v1beta1_privatecacertificate.yaml"
  "privateca_v1beta1_privatecacertificateauthority.yaml"
  "privateca_v1beta1_privatecacertificatetemplate.yaml"

  # Privilegedaccessmanager
  "privilegedaccessmanager_v1beta1_privilegedaccessmanagerentitlement.yaml"

  # Pubsub
  "pubsub_v1beta1_pubsubschema.yaml"
  "pubsub_v1beta1_pubsubsnapshot.yaml"
  "pubsub_v1beta1_pubsubsubscription.yaml"
  "pubsub_v1beta1_pubsubtopic.yaml"

  # Pubsublite
  "pubsublite_v1alpha1_pubsublitesubscription.yaml"
  "pubsublite_v1alpha1_pubsublitetopic.yaml"
  "pubsublite_v1beta1_pubsublitereservation.yaml"

  # Recaptchaenterprise
  "recaptchaenterprise_v1alpha1_recaptchaenterprisefirewallpolicy.yaml"
  "recaptchaenterprise_v1beta1_recaptchaenterprisekey.yaml"

  # Redis
  "redis_v1beta1_rediscluster.yaml"
  "redis_v1beta1_redisinstance.yaml"

  # Resourcemanager
  "resourcemanager_v1beta1_folder.yaml"
  "resourcemanager_v1beta1_project.yaml"
  "resourcemanager_v1beta1_resourcemanagerlien.yaml"
  "resourcemanager_v1beta1_resourcemanagerpolicy.yaml"

  # Run
  "run_v1beta1_runjob.yaml"
  "run_v1beta1_runservice.yaml"

  # Secretmanager
  "secretmanager_v1beta1_secretmanagersecret.yaml"
  "secretmanager_v1beta1_secretmanagersecretversion.yaml"

  # Securesourcemanager
  "securesourcemanager_v1beta1_securesourcemanagerinstance.yaml"
  "securesourcemanager_v1beta1_securesourcemanagerrepository.yaml"

  # Securitycenter
  "securitycenter_v1alpha1_securitycenternotificationconfig.yaml"
  "securitycenter_v1alpha1_securitycentersource.yaml"

  # Servicedirectory
  "servicedirectory_v1beta1_servicedirectoryendpoint.yaml"
  "servicedirectory_v1beta1_servicedirectorynamespace.yaml"
  "servicedirectory_v1beta1_servicedirectoryservice.yaml"

  # Servicenetworking
  "servicenetworking_v1alpha1_servicenetworkingpeereddnsdomain.yaml"
  "servicenetworking_v1beta1_servicenetworkingconnection.yaml"

  # Serviceusage
  "serviceusage_v1alpha1_serviceusageconsumerquotaoverride.yaml"
  "serviceusage_v1beta1_service.yaml"
  "serviceusage_v1beta1_serviceidentity.yaml"

  # Sourcerepo
  "sourcerepo_v1beta1_sourcereporepository.yaml"

  # Spanner
  "spanner_v1alpha1_spannerinstanceconfig.yaml"
  "spanner_v1beta1_spannerbackupschedule.yaml"
  "spanner_v1beta1_spannerdatabase.yaml"
  "spanner_v1beta1_spannerinstance.yaml"

  # Speech
  "speech_v1beta1_speechcustomclass.yaml"
  "speech_v1beta1_speechphraseset.yaml"
  "speech_v1beta1_speechrecognizer.yaml"

  # Sql
  "sql_v1beta1_sqldatabase.yaml"
  "sql_v1beta1_sqlinstance.yaml"
  "sql_v1beta1_sqlsslcert.yaml"
  "sql_v1beta1_sqluser.yaml"

  # Storage
  "storage_v1alpha1_storagefolder.yaml"
  "storage_v1alpha1_storagehmackey.yaml"
  "storage_v1alpha1_storagemanagedfolder.yaml"
  "storage_v1beta1_storageanywherecache.yaml"
  "storage_v1beta1_storagebucket.yaml"
  "storage_v1beta1_storagebucketaccesscontrol.yaml"
  "storage_v1beta1_storagedefaultobjectaccesscontrol.yaml"
  "storage_v1beta1_storagenotification.yaml"

  # Storagetransfer
  "storagetransfer_v1alpha1_storagetransferagentpool.yaml"
  "storagetransfer_v1beta1_storagetransferjob.yaml"

  # Tags
  "tags_v1alpha1_tagslocationtagbinding.yaml"
  "tags_v1beta1_tagstagbinding.yaml"
  "tags_v1beta1_tagstagkey.yaml"
  "tags_v1beta1_tagstagvalue.yaml"

  # Tpu
  "tpu_v1alpha1_tpunode.yaml"
  "tpu_v1alpha1_tpuvirtualmachine.yaml"

  # Vertexai
  "vertexai_v1alpha1_vertexaifeaturestore.yaml"
  "vertexai_v1alpha1_vertexaifeaturestoreentitytype.yaml"
  "vertexai_v1alpha1_vertexaifeaturestoreentitytypefeature.yaml"
  "vertexai_v1alpha1_vertexaiindexendpoint.yaml"
  "vertexai_v1alpha1_vertexaitensorboard.yaml"
  "vertexai_v1beta1_vertexaidataset.yaml"
  "vertexai_v1beta1_vertexaiendpoint.yaml"
  "vertexai_v1beta1_vertexaiindex.yaml"
  "vertexai_v1beta1_vertexaimetadatastore.yaml"

  # Vmwareengine
  "vmwareengine_v1alpha1_vmwareengineexternalaccessrule.yaml"
  "vmwareengine_v1alpha1_vmwareenginenetwork.yaml"
  "vmwareengine_v1alpha1_vmwareenginenetworkpeering.yaml"
  "vmwareengine_v1alpha1_vmwareenginenetworkpolicy.yaml"
  "vmwareengine_v1alpha1_vmwareengineprivatecloud.yaml"
  "vmwareengine_v1beta1_vmwareengineexternaladdress.yaml"

  # Vpcaccess
  "vpcaccess_v1beta1_vpcaccessconnector.yaml"

  # Workflowexecutions
  "workflowexecutions_v1alpha1_workflowsexecution.yaml"

  # Workflows
  "workflows_v1alpha1_workflowsworkflow.yaml"

  # Workstations
  "workstations_v1beta1_workstation.yaml"
  "workstations_v1beta1_workstationcluster.yaml"
  "workstations_v1beta1_workstationconfig.yaml"

)

# renovate: datasource=github-tags depName=GoogleCloudPlatform/k8s-config-connector
export VERSION=1.141.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/GoogleCloudPlatform/k8s-config-connector/v${VERSION}/crds/${crd_file}"
}