From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 1/5] I2C: DaVinci: fix lost interrupt
Date: Thu, 20 Mar 2008 20:06:06 -0700
Message-ID: <1206068770-15458-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1206068770-15458-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1206068770-15458-1-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
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
Cc: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

DAVINCI_I2C_STR_REG is a write 1 to clear register,
so don't use a read/modify/write cycle.

Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Acked-by: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)
 mode change 100644 => 100755 drivers/i2c/busses/i2c-davinci.c

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
old mode 100644
new mode 100755
index cce5a61..fde2634
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -382,9 +382,8 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 			break;
 
 		case DAVINCI_I2C_IVR_ARDY:
-			w = davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG);
-			MOD_REG_BIT(w, DAVINCI_I2C_STR_ARDY, 1);
-			davinci_i2c_write_reg(dev, DAVINCI_I2C_STR_REG, w);
+			davinci_i2c_write_reg(dev,
+				DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_ARDY);
 			complete(&dev->cmd_complete);
 			break;
 
@@ -397,12 +396,9 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 				if (dev->buf_len)
 					continue;
 
-				w = davinci_i2c_read_reg(dev,
-							 DAVINCI_I2C_STR_REG);
-				MOD_REG_BIT(w, DAVINCI_I2C_IMR_RRDY, 0);
 				davinci_i2c_write_reg(dev,
-						      DAVINCI_I2C_STR_REG,
-						      w);
+					DAVINCI_I2C_STR_REG,
+					DAVINCI_I2C_IMR_RRDY);
 			} else
 				dev_err(dev->dev, "RDR IRQ while no "
 					"data requested\n");
@@ -428,9 +424,8 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 			break;
 
 		case DAVINCI_I2C_IVR_SCD:
-			w = davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG);
-			MOD_REG_BIT(w, DAVINCI_I2C_STR_SCD, 1);
-			davinci_i2c_write_reg(dev, DAVINCI_I2C_STR_REG, w);
+			davinci_i2c_write_reg(dev,
+				DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_SCD);
 			complete(&dev->cmd_complete);
 			break;
 
-- 
1.5.4


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
