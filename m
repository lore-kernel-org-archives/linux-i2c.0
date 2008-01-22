From: Kalle Pokki <kalle.pokki-loK5ZF7nR+A@public.gmane.org>
Subject: [PATCH] i2c-bfin-twi: Register adapter with a specific bus
	number
Date: Tue, 22 Jan 2008 23:40:15 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0801222335050.11948@pc-213-140-179-32.aina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

All the users of this driver explicitly specify the I2C bus numbers
to be used in their platform data. Make the driver respect that.

Signed-off-by: Kalle Pokki <kalle.pokki-loK5ZF7nR+A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 67224a4..7dbdaeb 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -550,6 +550,7 @@ static int i2c_bfin_twi_probe(struct platform_device *dev)
 
 	p_adap = &iface->adap;
 	p_adap->id = I2C_HW_BLACKFIN;
+	p_adap->nr = dev->id;
 	strlcpy(p_adap->name, dev->name, sizeof(p_adap->name));
 	p_adap->algo = &bfin_twi_algorithm;
 	p_adap->algo_data = iface;
@@ -576,7 +577,7 @@ static int i2c_bfin_twi_probe(struct platform_device *dev)
 	bfin_write_TWI_CONTROL(bfin_read_TWI_CONTROL() | TWI_ENA);
 	SSYNC();
 
-	rc = i2c_add_adapter(p_adap);
+	rc = i2c_add_numbered_adapter(p_adap);
 	if (rc < 0)
 		free_irq(iface->irq, iface);
 	else
-- 
1.4.4.2


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
