From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 08/27] drivers/crypto/of: don't use deprecated field in
	of_platform_driver
Date: Thu, 11 Mar 2010 11:22:32 -0700
Message-ID: <20100311182231.13103.47091.stgit__33919.2424239174$1268332983$gmane$org@angua>
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

 drivers/crypto/amcc/crypto4xx_core.c |    7 +++++--
 drivers/crypto/talitos.c             |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 1c3849f..36b5fb1 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1280,8 +1280,11 @@ static const struct of_device_id crypto4xx_match[] = {
 };
 
 static struct of_platform_driver crypto4xx_driver = {
-	.name		= "crypto4xx",
-	.match_table	= crypto4xx_match,
+	.driver = {
+		.name = "crypto4xx",
+		.owner = THIS_MODULE,
+		.of_match_table = crypto4xx_match,
+	},
 	.probe		= crypto4xx_probe,
 	.remove		= crypto4xx_remove,
 };
diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index fd529d6..917faf7 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1967,8 +1967,11 @@ static const struct of_device_id talitos_match[] = {
 MODULE_DEVICE_TABLE(of, talitos_match);
 
 static struct of_platform_driver talitos_driver = {
-	.name = "talitos",
-	.match_table = talitos_match,
+	.driver = {
+		.name = "talitos",
+		.owner = THIS_MODULE,
+		.of_match_table = talitos_match,
+	},
 	.probe = talitos_probe,
 	.remove = talitos_remove,
 };
