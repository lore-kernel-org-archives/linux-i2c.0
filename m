From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 20/27] drivers/mmc/of: don't use deprecated field in
	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:38 -0700
Message-ID: <20100311182338.13103.88443.stgit__25186.4328551621$1268332095$gmane$org@angua>
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

 drivers/mmc/host/sdhci-of-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index dfe5cea..7802a54 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -205,8 +205,11 @@ static const struct of_device_id sdhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, sdhci_of_match);
 
 static struct of_platform_driver sdhci_of_driver = {
-	.driver.name = "sdhci-of",
-	.match_table = sdhci_of_match,
+	.driver = {
+		.name = "sdhci-of",
+		.owner = THIS_MODULE,
+		.of_match_table = sdhci_of_match,
+	},
 	.probe = sdhci_of_probe,
 	.remove = __devexit_p(sdhci_of_remove),
 	.suspend = sdhci_of_suspend,
