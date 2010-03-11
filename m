From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 22/27] drivers/i2c/of: don't use deprecated field in
	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:49 -0700
Message-ID: <20100311182349.13103.39322.stgit__37574.0431053147$1268332387$gmane$org@angua>
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

 drivers/i2c/busses/i2c-cpm.c     |   10 +++++-----
 drivers/i2c/busses/i2c-ibm_iic.c |    7 +++++--
 drivers/i2c/busses/i2c-mpc.c     |    8 ++++----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 9c2e100..47994d2 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -718,13 +718,13 @@ static const struct of_device_id cpm_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, cpm_i2c_match);
 
 static struct of_platform_driver cpm_i2c_driver = {
-	.match_table	= cpm_i2c_match,
 	.probe		= cpm_i2c_probe,
 	.remove		= __devexit_p(cpm_i2c_remove),
-	.driver		= {
-		.name	= "fsl-i2c-cpm",
-		.owner	= THIS_MODULE,
-	}
+	.driver = {
+		.name = "fsl-i2c-cpm",
+		.owner = THIS_MODULE,
+		.of_match_table = cpm_i2c_match,
+	},
 };
 
 static int __init cpm_i2c_init(void)
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index b1bc6e2..21dba9d 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -807,8 +807,11 @@ static const struct of_device_id ibm_iic_match[] = {
 };
 
 static struct of_platform_driver ibm_iic_driver = {
-	.name	= "ibm-iic",
-	.match_table = ibm_iic_match,
+	.driver = {
+		.name = "ibm-iic",
+		.owner = THIS_MODULE,
+		.of_match_table = ibm_iic_match,
+	},
 	.probe	= iic_probe,
 	.remove	= __devexit_p(iic_remove),
 };
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 0123a6e..6063dc3 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -674,12 +674,12 @@ MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
 
 /* Structure for a device driver */
 static struct of_platform_driver mpc_i2c_driver = {
-	.match_table	= mpc_i2c_of_match,
 	.probe		= fsl_i2c_probe,
 	.remove		= __devexit_p(fsl_i2c_remove),
-	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= DRV_NAME,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = DRV_NAME,
+		.of_match_table = mpc_i2c_of_match,
 	},
 };
 
