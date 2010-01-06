From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/4] i2c: davinci: Remove MOD_REG_BIT and IO_ADDRESS usage
Date: Wed,  6 Jan 2010 14:54:57 +0530
Message-ID: <1262769900-2710-2-git-send-email-chaithrika@ti.com>
References: <1262769900-2710-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1262769900-2710-1-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Cleanup the DaVinci I2C driver. Remove MOD_REG_BIT macro.
Also use ioremap instead of IO_ADDRESS macro.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   77 +++++++++++++++++++-------------------
 1 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index c89687a..44a3cb3 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -37,7 +37,6 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-
 #include <mach/i2c.h>
 
 /* ----- global defines ----------------------------------------------- */
@@ -71,37 +70,29 @@
 #define DAVINCI_I2C_IVR_NACK	0x02
 #define DAVINCI_I2C_IVR_AL	0x01
 
-#define DAVINCI_I2C_STR_BB	(1 << 12)
-#define DAVINCI_I2C_STR_RSFULL	(1 << 11)
-#define DAVINCI_I2C_STR_SCD	(1 << 5)
-#define DAVINCI_I2C_STR_ARDY	(1 << 2)
-#define DAVINCI_I2C_STR_NACK	(1 << 1)
-#define DAVINCI_I2C_STR_AL	(1 << 0)
-
-#define DAVINCI_I2C_MDR_NACK	(1 << 15)
-#define DAVINCI_I2C_MDR_STT	(1 << 13)
-#define DAVINCI_I2C_MDR_STP	(1 << 11)
-#define DAVINCI_I2C_MDR_MST	(1 << 10)
-#define DAVINCI_I2C_MDR_TRX	(1 << 9)
-#define DAVINCI_I2C_MDR_XA	(1 << 8)
-#define DAVINCI_I2C_MDR_RM	(1 << 7)
-#define DAVINCI_I2C_MDR_IRS	(1 << 5)
-
-#define DAVINCI_I2C_IMR_AAS	(1 << 6)
-#define DAVINCI_I2C_IMR_SCD	(1 << 5)
-#define DAVINCI_I2C_IMR_XRDY	(1 << 4)
-#define DAVINCI_I2C_IMR_RRDY	(1 << 3)
-#define DAVINCI_I2C_IMR_ARDY	(1 << 2)
-#define DAVINCI_I2C_IMR_NACK	(1 << 1)
-#define DAVINCI_I2C_IMR_AL	(1 << 0)
-
-#define MOD_REG_BIT(val, mask, set) do { \
-	if (set) { \
-		val |= mask; \
-	} else { \
-		val &= ~mask; \
-	} \
-} while (0)
+#define DAVINCI_I2C_STR_BB	BIT(12)
+#define DAVINCI_I2C_STR_RSFULL	BIT(11)
+#define DAVINCI_I2C_STR_SCD	BIT(5)
+#define DAVINCI_I2C_STR_ARDY	BIT(2)
+#define DAVINCI_I2C_STR_NACK	BIT(1)
+#define DAVINCI_I2C_STR_AL	BIT(0)
+
+#define DAVINCI_I2C_MDR_NACK	BIT(15)
+#define DAVINCI_I2C_MDR_STT	BIT(13)
+#define DAVINCI_I2C_MDR_STP	BIT(11)
+#define DAVINCI_I2C_MDR_MST	BIT(10)
+#define DAVINCI_I2C_MDR_TRX	BIT(9)
+#define DAVINCI_I2C_MDR_XA	BIT(8)
+#define DAVINCI_I2C_MDR_RM	BIT(7)
+#define DAVINCI_I2C_MDR_IRS	BIT(5)
+
+#define DAVINCI_I2C_IMR_AAS	BIT(6)
+#define DAVINCI_I2C_IMR_SCD	BIT(5)
+#define DAVINCI_I2C_IMR_XRDY	BIT(4)
+#define DAVINCI_I2C_IMR_RRDY	BIT(3)
+#define DAVINCI_I2C_IMR_ARDY	BIT(2)
+#define DAVINCI_I2C_IMR_NACK	BIT(1)
+#define DAVINCI_I2C_IMR_AL	BIT(0)
 
 struct davinci_i2c_dev {
 	struct device           *dev;
@@ -154,7 +145,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 
 	/* put I2C into reset */
 	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-	MOD_REG_BIT(w, DAVINCI_I2C_MDR_IRS, 0);
+	w &= ~DAVINCI_I2C_MDR_IRS;
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
 
 	/* NOTE: I2C Clock divider programming info
@@ -204,7 +195,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 
 	/* Take the I2C module out of reset: */
 	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-	MOD_REG_BIT(w, DAVINCI_I2C_MDR_IRS, 1);
+	w |= DAVINCI_I2C_MDR_IRS;
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
 
 	/* Enable interrupts */
@@ -284,9 +275,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	/* Enable receive or transmit interrupts */
 	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
 	if (msg->flags & I2C_M_RD)
-		MOD_REG_BIT(w, DAVINCI_I2C_IMR_RRDY, 1);
+		w |= DAVINCI_I2C_IMR_RRDY;
 	else
-		MOD_REG_BIT(w, DAVINCI_I2C_IMR_XRDY, 1);
+		w |= DAVINCI_I2C_IMR_XRDY;
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
 
 	dev->terminate = 0;
@@ -333,7 +324,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 			return msg->len;
 		if (stop) {
 			w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-			MOD_REG_BIT(w, DAVINCI_I2C_MDR_STP, 1);
+			w |= DAVINCI_I2C_MDR_STP;
 			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
 		}
 		return -EREMOTEIO;
@@ -461,7 +452,7 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 
 				w = davinci_i2c_read_reg(dev,
 							 DAVINCI_I2C_IMR_REG);
-				MOD_REG_BIT(w, DAVINCI_I2C_IMR_XRDY, 0);
+				w &= ~DAVINCI_I2C_IMR_XRDY;
 				davinci_i2c_write_reg(dev,
 						      DAVINCI_I2C_IMR_REG,
 						      w);
@@ -540,7 +531,12 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	}
 	clk_enable(dev->clk);
 
-	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
+	dev->base = ioremap(mem->start, resource_size(mem));
+	if (!dev->base) {
+		r = -EBUSY;
+		goto err_mem_ioremap;
+	}
+
 	i2c_davinci_init(dev);
 
 	r = request_irq(dev->irq, i2c_davinci_isr, 0, pdev->name, dev);
@@ -570,6 +566,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 err_free_irq:
 	free_irq(dev->irq, dev);
 err_unuse_clocks:
+	iounmap(dev->base);
+err_mem_ioremap:
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
@@ -598,6 +596,7 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
 	free_irq(IRQ_I2C, dev);
+	iounmap(dev->base);
 	kfree(dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.5.6
