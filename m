From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 16/27] drivers/scsi/of: don't use deprecated field in
	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:16 -0700
Message-ID: <20100311182316.13103.87138.stgit__4672.58546636931$1268332766$gmane$org@angua>
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

 drivers/scsi/qlogicpti.c |    7 +++++--
 drivers/scsi/sun_esp.c   |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 7374fbe..16dc12e 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1456,8 +1456,11 @@ static const struct of_device_id qpti_match[] = {
 MODULE_DEVICE_TABLE(of, qpti_match);
 
 static struct of_platform_driver qpti_sbus_driver = {
-	.name		= "qpti",
-	.match_table	= qpti_match,
+	.driver = {
+		.name = "qpti",
+		.owner = THIS_MODULE,
+		.of_match_table = qpti_match,
+	},
 	.probe		= qpti_sbus_probe,
 	.remove		= __devexit_p(qpti_sbus_remove),
 };
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 4369b76..10ba30a 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -632,8 +632,11 @@ static const struct of_device_id esp_match[] = {
 MODULE_DEVICE_TABLE(of, esp_match);
 
 static struct of_platform_driver esp_sbus_driver = {
-	.name		= "esp",
-	.match_table	= esp_match,
+	.driver = {
+		.name = "esp",
+		.owner = THIS_MODULE,
+		.of_match_table = esp_match,
+	},
 	.probe		= esp_sbus_probe,
 	.remove		= __devexit_p(esp_sbus_remove),
 };
