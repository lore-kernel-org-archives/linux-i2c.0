From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 17/27] drivers/sbus/of: don't use deprecated field in
	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:22 -0700
Message-ID: <20100311182321.13103.29782.stgit__26124.0275962793$1268332265$gmane$org@angua>
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

 drivers/sbus/char/bbc_i2c.c     |    7 +++++--
 drivers/sbus/char/display7seg.c |    7 +++++--
 drivers/sbus/char/envctrl.c     |    7 +++++--
 drivers/sbus/char/flash.c       |    7 +++++--
 drivers/sbus/char/uctrl.c       |    7 +++++--
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 1543ac3..8bfdd63 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -414,8 +414,11 @@ static const struct of_device_id bbc_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, bbc_i2c_match);
 
 static struct of_platform_driver bbc_i2c_driver = {
-	.name		= "bbc_i2c",
-	.match_table	= bbc_i2c_match,
+	.driver = {
+		.name = "bbc_i2c",
+		.owner = THIS_MODULE,
+		.of_match_table = bbc_i2c_match,
+	},
 	.probe		= bbc_i2c_probe,
 	.remove		= __devexit_p(bbc_i2c_remove),
 };
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index d0a10f4..e1db005 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -265,8 +265,11 @@ static const struct of_device_id d7s_match[] = {
 MODULE_DEVICE_TABLE(of, d7s_match);
 
 static struct of_platform_driver d7s_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= d7s_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = d7s_match,
+	},
 	.probe		= d7s_probe,
 	.remove		= __devexit_p(d7s_remove),
 };
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 84a4310..dc9e8ef 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1130,8 +1130,11 @@ static const struct of_device_id envctrl_match[] = {
 MODULE_DEVICE_TABLE(of, envctrl_match);
 
 static struct of_platform_driver envctrl_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= envctrl_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = envctrl_match,
+	},
 	.probe		= envctrl_probe,
 	.remove		= __devexit_p(envctrl_remove),
 };
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index dc8f95d..0e8ae6b 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -208,8 +208,11 @@ static const struct of_device_id flash_match[] = {
 MODULE_DEVICE_TABLE(of, flash_match);
 
 static struct of_platform_driver flash_driver = {
-	.name		= "flash",
-	.match_table	= flash_match,
+	.driver = {
+		.name = "flash",
+		.owner = THIS_MODULE,
+		.of_match_table = flash_match,
+	},
 	.probe		= flash_probe,
 	.remove		= __devexit_p(flash_remove),
 };
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index acc6738..5f25366 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -425,8 +425,11 @@ static const struct of_device_id uctrl_match[] = {
 MODULE_DEVICE_TABLE(of, uctrl_match);
 
 static struct of_platform_driver uctrl_driver = {
-	.name		= "uctrl",
-	.match_table	= uctrl_match,
+	.driver = {
+		.name = "uctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = uctrl_match,
+	},
 	.probe		= uctrl_probe,
 	.remove		= __devexit_p(uctrl_remove),
 };
