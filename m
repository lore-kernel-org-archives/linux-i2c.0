From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 11/27] drivers/macintosh/of: don't use deprecated field in
	of_platform_driver
Date: Thu, 11 Mar 2010 11:22:48 -0700
Message-ID: <20100311182248.13103.6111.stgit__4748.50527612052$1268332983$gmane$org@angua>
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

 drivers/macintosh/smu.c              |    7 +++++--
 drivers/macintosh/therm_pm72.c       |    7 +++++--
 drivers/macintosh/therm_windtunnel.c |    7 +++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index f96feeb..4e912b2 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -670,8 +670,11 @@ static const struct of_device_id smu_platform_match[] =
 
 static struct of_platform_driver smu_of_platform_driver =
 {
-	.name 		= "smu",
-	.match_table	= smu_platform_match,
+	.driver = {
+		.name = "smu",
+		.owner = THIS_MODULE,
+		.of_match_table = smu_platform_match,
+	},
 	.probe		= smu_platform_probe,
 };
 
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index f5b0f9e..c99f937 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -2221,8 +2221,11 @@ static const struct of_device_id fcu_match[] =
 
 static struct of_platform_driver fcu_of_platform_driver = 
 {
-	.name 		= "temperature",
-	.match_table	= fcu_match,
+	.driver = {
+		.name = "temperature",
+		.owner = THIS_MODULE,
+		.of_match_table = fcu_match,
+	},
 	.probe		= fcu_of_probe,
 	.remove		= fcu_of_remove
 };
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 7fb8b4d..dc6a47a 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -464,8 +464,11 @@ static const struct of_device_id therm_of_match[] = {{
 };
 
 static struct of_platform_driver therm_of_driver = {
-	.name		= "temperature",
-	.match_table	= therm_of_match,
+	.driver = {
+		.name = "temperature",
+		.owner = THIS_MODULE,
+		.of_match_table = therm_of_match,
+	},
 	.probe		= therm_of_probe,
 	.remove		= therm_of_remove,
 };
