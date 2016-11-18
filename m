From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v3 5/5] i2c: designware: Cleaning and commentary fixes
Date: Fri, 18 Nov 2016 11:19:34 +0000
Message-ID: <cbe8cee5288fc14272a7fdb892c19a76559ae2de.1479410047.git.lolivei@synopsys.com>
References: <cover.1479410047.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1479410047.git.lolivei@synopsys.com>
In-Reply-To: <cover.1479410047.git.lolivei@synopsys.com>
References: <cover.1479410047.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V2->V3: (Andy Shevchenko)
- nothing except style issues

 drivers/i2c/busses/i2c-designware-slave.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 6b0db3b..2417cc8 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -38,7 +38,7 @@ static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
 	dw_writel(dev, 0, DW_IC_TX_TL);
 	dw_writel(dev, 0, DW_IC_RX_TL);
 
-	/* configure the i2c slave */
+	/* configure the I2C slave */
 	dw_writel(dev, dev->slave_cfg, DW_IC_CON);
 	dw_writel(dev, DW_IC_INTR_SLAVE_MASK, DW_IC_INTR_MASK);
 }
@@ -182,7 +182,7 @@ int i2c_dw_reg_slave(struct i2c_client *slave)
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
 		/* set slave address in the IC_SAR register,
-		* the address to which the DW_apb_i2c responds */
+		 * the address to which the DW_apb_i2c responds */
 
 	__i2c_dw_enable(dev, false);
 	dw_writel(dev, slave->addr, DW_IC_SAR);
@@ -266,7 +266,7 @@ static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 }
 
 /*
- * Interrupt service routine. This gets called whenever an I2C interrupt
+ * Interrupt service routine. This gets called whenever an I2C slave interrupt
  * occurs.
  */
 
@@ -300,7 +300,7 @@ static bool i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 				val = dw_readl(dev, DW_IC_DATA_CMD);
 				if (!i2c_slave_event(dev->slave,
 				 I2C_SLAVE_WRITE_RECEIVED, &val)) {
-					dev_dbg(dev->dev, "Byte %X acked! ",
+					dev_dbg(dev->dev, "Byte %X acked!",
 					 val);
 				}
 				dw_readl(dev, DW_IC_CLR_RD_REQ);
@@ -330,7 +330,7 @@ static bool i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 		val = dw_readl(dev, DW_IC_DATA_CMD);
 		if (!i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED,
 		 &val))
-			dev_dbg(dev->dev, "Byte %X acked! ", val);
+			dev_dbg(dev->dev, "Byte %X acked!", val);
 	} else {
 		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
 		stat = i2c_dw_read_clear_intrbits_slave(dev);
-- 
2.10.2
