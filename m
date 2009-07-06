From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 2/2] i2c-davinci: behave with i2cdetect
Date: Mon,  6 Jul 2009 15:48:36 -0700
Message-ID: <1246920516-31462-3-git-send-email-khilman@deeprootsystems.com>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
 <1246920516-31462-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246920516-31462-2-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Make i2c-davinci cope properly with "i2cdetect":  don't spew
syslog spam on perfectly normal behaviors, or respond to any
address other than the one reserved for the SMBus host.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index ee3fbb8..1f3d89c 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -187,6 +187,11 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
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
@@ -387,7 +392,7 @@ static void terminate_write(struct davinci_i2c_dev *dev)
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
 
 	if (!dev->terminate)
-		dev_err(dev->dev, "TDR IRQ while no data to send\n");
+		dev_dbg(dev->dev, "TDR IRQ while no data to send\n");
 }
 
 /*
@@ -473,9 +478,14 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
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
-- 
1.6.3.3
