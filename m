From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 15/27] drivers/spi/of: don't use deprecated field in
	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:11 -0700
Message-ID: <20100311182310.13103.62043.stgit__30206.6680430018$1268332863$gmane$org@angua>
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

 drivers/spi/mpc52xx_psc_spi.c |    4 +---
 drivers/spi/mpc52xx_spi.c     |    8 +++++---
 drivers/spi/spi_mpc8xxx.c     |    7 +++++--
 drivers/spi/spi_ppc4xx.c      |    2 +-
 drivers/spi/xilinx_spi_of.c   |    2 +-
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index f12cfd9..babd529 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -513,14 +513,12 @@ static const struct of_device_id mpc52xx_psc_spi_of_match[] = {
 MODULE_DEVICE_TABLE(of, mpc52xx_psc_spi_of_match);
 
 static struct of_platform_driver mpc52xx_psc_spi_of_driver = {
-	.owner = THIS_MODULE,
-	.name = "mpc52xx-psc-spi",
-	.match_table = mpc52xx_psc_spi_of_match,
 	.probe = mpc52xx_psc_spi_of_probe,
 	.remove = __exit_p(mpc52xx_psc_spi_of_remove),
 	.driver = {
 		.name = "mpc52xx-psc-spi",
 		.owner = THIS_MODULE,
+		.of_match_table = mpc52xx_psc_spi_of_match,
 	},
 };
 
diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
index 907c39a..792ffb9 100644
--- a/drivers/spi/mpc52xx_spi.c
+++ b/drivers/spi/mpc52xx_spi.c
@@ -557,9 +557,11 @@ static const struct of_device_id mpc52xx_spi_match[] __devinitconst = {
 MODULE_DEVICE_TABLE(of, mpc52xx_spi_match);
 
 static struct of_platform_driver mpc52xx_spi_of_driver = {
-	.owner = THIS_MODULE,
-	.name = "mpc52xx-spi",
-	.match_table = mpc52xx_spi_match,
+	.driver = {
+		.name = "mpc52xx-spi",
+		.owner = THIS_MODULE,
+		.of_match_table = mpc52xx_spi_match,
+	},
 	.probe = mpc52xx_spi_probe,
 	.remove = __exit_p(mpc52xx_spi_remove),
 };
diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 38b9c32..fd90c30 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -1311,8 +1311,11 @@ static const struct of_device_id of_mpc8xxx_spi_match[] = {
 MODULE_DEVICE_TABLE(of, of_mpc8xxx_spi_match);
 
 static struct of_platform_driver of_mpc8xxx_spi_driver = {
-	.name		= "mpc8xxx_spi",
-	.match_table	= of_mpc8xxx_spi_match,
+	.driver = {
+		.name = "mpc8xxx_spi",
+		.owner = THIS_MODULE,
+		.of_match_table = of_mpc8xxx_spi_match,
+	},
 	.probe		= of_mpc8xxx_spi_probe,
 	.remove		= __devexit_p(of_mpc8xxx_spi_remove),
 };
diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
index 6d8d402..fa6f01c 100644
--- a/drivers/spi/spi_ppc4xx.c
+++ b/drivers/spi/spi_ppc4xx.c
@@ -586,12 +586,12 @@ static const struct of_device_id spi_ppc4xx_of_match[] = {
 MODULE_DEVICE_TABLE(of, spi_ppc4xx_of_match);
 
 static struct of_platform_driver spi_ppc4xx_of_driver = {
-	.match_table = spi_ppc4xx_of_match,
 	.probe = spi_ppc4xx_of_probe,
 	.remove = __exit_p(spi_ppc4xx_of_remove),
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.of_match_table = spi_ppc4xx_of_match,
 	},
 };
 
diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
index ed34a8d..416a8cd 100644
--- a/drivers/spi/xilinx_spi_of.c
+++ b/drivers/spi/xilinx_spi_of.c
@@ -108,12 +108,12 @@ static const struct of_device_id xilinx_spi_of_match[] = {
 MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
 
 static struct of_platform_driver xilinx_spi_of_driver = {
-	.match_table = xilinx_spi_of_match,
 	.probe = xilinx_spi_of_probe,
 	.remove = __exit_p(xilinx_spi_of_remove),
 	.driver = {
 		.name = "xilinx-xps-spi",
 		.owner = THIS_MODULE,
+		.of_match_table = xilinx_spi_of_match,
 	},
 };
 
