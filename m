From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/6] Blackfin I2C/TWI driver: add driver descriptions,
	versions and some module useful information
Date: Wed, 12 Mar 2008 16:28:50 +0000 (UTC)
Message-ID: <1205479360-25240-5-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Date: Fri, 14 Mar 2008 00:22:38 -0700
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 674c053..6ce6873 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -707,7 +707,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iface);
 
-	dev_info(&pdev->dev, "Blackfin I2C TWI controller, regs_base@%p\n",
+	dev_info(&pdev->dev, "Blackfin BF5xx on-chip I2C TWI Contoller, regs_base@%p\n",
 		iface->regs_base);
 
 	return 0;
@@ -760,9 +760,9 @@ static void __exit i2c_bfin_twi_exit(void)
 	platform_driver_unregister(&i2c_bfin_twi_driver);
 }
 
-MODULE_AUTHOR("Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>");
-MODULE_DESCRIPTION("I2C-Bus adapter routines for Blackfin TWI");
-MODULE_LICENSE("GPL");
-
 module_init(i2c_bfin_twi_init);
 module_exit(i2c_bfin_twi_exit);
+
+MODULE_AUTHOR("Bryan Wu, Sonic Zhang");
+MODULE_DESCRIPTION("Blackfin BF5xx on-chip I2C TWI Contoller Driver");
+MODULE_LICENSE("GPL");
-- 
1.5.4.3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
