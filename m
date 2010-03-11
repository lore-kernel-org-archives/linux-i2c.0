From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 03/27] drivers/watchdog/of: don't use deprecated .name and
	.owner in of_platform_driver
Date: Thu, 11 Mar 2010 11:22:04 -0700
Message-ID: <20100311182204.13103.79395.stgit__15783.5791972049$1268332233$gmane$org@angua>
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

 drivers/watchdog/cpwd.c        |    7 +++++--
 drivers/watchdog/gef_wdt.c     |    8 +++++---
 drivers/watchdog/mpc8xxx_wdt.c |    8 ++++----
 drivers/watchdog/riowd.c       |    7 +++++--
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 89da14f..4215b5d 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -676,8 +676,11 @@ static const struct of_device_id cpwd_match[] = {
 MODULE_DEVICE_TABLE(of, cpwd_match);
 
 static struct of_platform_driver cpwd_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= cpwd_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = cpwd_match,
+	},
 	.probe		= cpwd_probe,
 	.remove		= __devexit_p(cpwd_remove),
 };
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index abdbad0..ca0f4c6 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -303,9 +303,11 @@ static const struct of_device_id gef_wdt_ids[] = {
 };
 
 static struct of_platform_driver gef_wdt_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "gef_wdt",
-	.match_table	= gef_wdt_ids,
+	.driver = {
+		.name = "gef_wdt",
+		.owner = THIS_MODULE,
+		.of_match_table = gef_wdt_ids,
+	},
 	.probe		= gef_wdt_probe,
 };
 
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 4e3941c..7b55974 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -273,12 +273,12 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
 
 static struct of_platform_driver mpc8xxx_wdt_driver = {
-	.match_table	= mpc8xxx_wdt_match,
 	.probe		= mpc8xxx_wdt_probe,
 	.remove		= __devexit_p(mpc8xxx_wdt_remove),
-	.driver		= {
-		.name	= "mpc8xxx_wdt",
-		.owner	= THIS_MODULE,
+	.driver = {
+		.name = "mpc8xxx_wdt",
+		.owner = THIS_MODULE,
+		.of_match_table = mpc8xxx_wdt_match,
 	},
 };
 
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index ae57bf9..e7973bf 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -238,8 +238,11 @@ static const struct of_device_id riowd_match[] = {
 MODULE_DEVICE_TABLE(of, riowd_match);
 
 static struct of_platform_driver riowd_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= riowd_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = riowd_match,
+	},
 	.probe		= riowd_probe,
 	.remove		= __devexit_p(riowd_remove),
 };
