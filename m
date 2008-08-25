From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc4] i2c-davinci: behave with i2cdetect
Date: Sun, 24 Aug 2008 23:42:53 -0700
Message-ID: <200808242342.53944.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
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
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Make i2c-davinci cope properly with "i2cdetect":  don't spew
syslog spam on perfectly normal behaviors, or respond to any
address other than the one reserved for the SMBus host.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -188,6 +188,11 @@ static int i2c_davinci_init(struct davin
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
 
+	/* Respond at reserved "SMBus Host" slave address" (and zero);
+	 * we seem to have no option to not respond...
+	 */
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_OAR_REG, 0x08);
+
 	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
 	dev_dbg(dev->dev, "PSC  = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
@@ -400,7 +405,7 @@ static void terminate_write(struct davin
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
 
 	if (!dev->terminate)
-		dev_err(dev->dev, "TDR IRQ while no data to send\n");
+		dev_dbg(dev->dev, "TDR IRQ while no data to send\n");
 }
 
 /*
@@ -494,9 +499,14 @@ static irqreturn_t i2c_davinci_isr(int t
 			break;
 
 		case DAVINCI_I2C_IVR_AAS:
-			dev_warn(dev->dev, "Address as slave interrupt\n");
-		}/* switch */
-	}/* while */
+			dev_dbg(dev->dev, "Address as slave interrupt\n");
+			break;
+
+		default:
+			dev_warn(dev->dev, "Unrecognized irq stat %d\n", stat);
+			break;
+		}
+	}
 
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
