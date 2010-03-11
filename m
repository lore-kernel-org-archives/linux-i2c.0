From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 06/27] drivers/block/of: don't use deprecated field in
	of_platform_driver
Date: Thu, 11 Mar 2010 11:22:21 -0700
Message-ID: <20100311182220.13103.76284.stgit__2327.49203355542$1268332975$gmane$org@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dwmw2@infrade
List-Id: linux-i2c@vger.kernel.org

.name, .match_table and .owner are duplicated in both of_platform_driver
and device_driver, so the of_platform_driver copies will be removed soon.

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---

 drivers/ata/pata_of_platform.c |    7 +++++--
 drivers/ata/sata_fsl.c         |    7 +++++--
 drivers/block/xsysace.c        |    5 ++---
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 19da29f..5a1b82c 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -91,8 +91,11 @@ static struct of_device_id pata_of_platform_match[] = {
 MODULE_DEVICE_TABLE(of, pata_of_platform_match);
 
 static struct of_platform_driver pata_of_platform_driver = {
-	.name		= "pata_of_platform",
-	.match_table	= pata_of_platform_match,
+	.driver = {
+		.name = "pata_of_platform",
+		.owner = THIS_MODULE,
+		.of_match_table = pata_of_platform_match,
+	},
 	.probe		= pata_of_platform_probe,
 	.remove		= __devexit_p(pata_of_platform_remove),
 };
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index ce4136e..463fb9c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1426,8 +1426,11 @@ static struct of_device_id fsl_sata_match[] = {
 MODULE_DEVICE_TABLE(of, fsl_sata_match);
 
 static struct of_platform_driver fsl_sata_driver = {
-	.name		= "fsl-sata",
-	.match_table	= fsl_sata_match,
+	.driver = {
+		.name = "fsl-sata",
+		.owner = THIS_MODULE,
+		.of_match_table = fsl_sata_match,
+	},
 	.probe		= sata_fsl_probe,
 	.remove		= sata_fsl_remove,
 #ifdef CONFIG_PM
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index e1c95e2..cffcd71 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1237,13 +1237,12 @@ static const struct of_device_id ace_of_match[] __devinitconst = {
 MODULE_DEVICE_TABLE(of, ace_of_match);
 
 static struct of_platform_driver ace_of_driver = {
-	.owner = THIS_MODULE,
-	.name = "xsysace",
-	.match_table = ace_of_match,
 	.probe = ace_of_probe,
 	.remove = __devexit_p(ace_of_remove),
 	.driver = {
 		.name = "xsysace",
+		.owner = THIS_MODULE,
+		.of_match_table = ace_of_match,
 	},
 };
 
