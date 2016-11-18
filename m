From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 3/5] i2c: designware: Add slave definitions
Date: Fri, 18 Nov 2016 11:19:32 +0000
Message-ID: <f1bf9ca52e47cdd79b8f0d5e0c159a8727857269.1479410047.git.lolivei@synopsys.com>
References: <cover.1479410047.git.lolivei@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1479410047.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1479410047.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1479410047.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

 - Add slave defintitions to i2c-designware-core
 - Changes in Kconfig to auto-enable I2C_SLAVE when compiling the modules
 - Add compatible string to designware-core.txt explaining the devicetree bindings

Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
Changes V2->V3: (Andy Shevchenko)
- necessary definitions added to i2c-designware-core.h (slave)
- code will be added in the next patch as suggested
- compatible string for slave enabling as suggested

 .../devicetree/bindings/i2c/i2c-designware.txt     |  4 +++-
 drivers/i2c/busses/Kconfig                         |  1 +
 drivers/i2c/busses/i2c-designware-core.h           | 24 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-src.c            |  6 ++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fee26dc..7705434 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -2,7 +2,9 @@
 
 Required properties :
 
- - compatible : should be "snps,designware-i2c"
+ - compatible : should be:
+   - "snps,designware-i2c" to setup the hardware block as I2C master.
+   - "snps,designware-i2c-slave" to setup the hardware block as I2C slave.
  - reg : Offset and length of the register set for the device
  - interrupts : <IRQ> where IRQ is the interrupt number.
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d252276..0de8e30 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -470,6 +470,7 @@ config I2C_DESIGNWARE_CORE
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
 	select I2C_DESIGNWARE_CORE
+	select I2C_SLAVE
 	depends on (ACPI && COMMON_CLK) || !ACPI
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 1d45667..8c33324 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -26,15 +26,20 @@
 #define DW_IC_CON_SPEED_FAST		0x4
 #define DW_IC_CON_SPEED_HIGH		0x6
 #define DW_IC_CON_SPEED_MASK		0x6
+#define DW_IC_CON_10BITADDR_SLAVE		0x8
 #define DW_IC_CON_10BITADDR_MASTER	0x10
 #define DW_IC_CON_RESTART_EN		0x20
 #define DW_IC_CON_SLAVE_DISABLE		0x40
+#define DW_IC_CON_STOP_DET_IFADDRESSED		0x80
+#define DW_IC_CON_TX_EMPTY_CTRL		0x100
+#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL		0x200
 
 /*
  * Registers offset
  */
 #define DW_IC_CON		0x0
 #define DW_IC_TAR		0x4
+#define DW_IC_SAR		0x8
 #define DW_IC_DATA_CMD		0x10
 #define DW_IC_SS_SCL_HCNT	0x14
 #define DW_IC_SS_SCL_LCNT	0x18
@@ -89,9 +94,15 @@
 					 DW_IC_INTR_STOP_DET)
 #define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MASK | \
 					 DW_IC_INTR_TX_EMPTY)
+#define DW_IC_INTR_SLAVE_MASK		(DW_IC_INTR_DEFAULT_MASK | \
+					 DW_IC_INTR_RX_DONE | \
+					 DW_IC_INTR_RX_UNDER | \
+					 DW_IC_INTR_RD_REQ)
+
 #define DW_IC_STATUS_ACTIVITY		0x1
 #define DW_IC_STATUS_TFE		BIT(2)
 #define DW_IC_STATUS_MASTER_ACTIVITY	BIT(5)
+#define DW_IC_STATUS_SLAVE_ACTIVITY	BIT(6)
 
 #define DW_IC_SDA_HOLD_RX_SHIFT		16
 #define DW_IC_SDA_HOLD_RX_MASK		GENMASK(23, DW_IC_SDA_HOLD_RX_SHIFT)
@@ -129,6 +140,9 @@
 #define ABRT_10B_RD_NORSTRT	10
 #define ABRT_MASTER_DIS		11
 #define ARB_LOST		12
+#define ABRT_SLAVE_FLUSH_TXFIFO	13
+#define ABRT_SLAVE_ARBLOST	14
+#define ABRT_SLAVE_RD_INTX	15
 
 #define DW_IC_TX_ABRT_7B_ADDR_NOACK	(1UL << ABRT_7B_ADDR_NOACK)
 #define DW_IC_TX_ABRT_10ADDR1_NOACK	(1UL << ABRT_10ADDR1_NOACK)
@@ -141,6 +155,9 @@
 #define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL << ABRT_10B_RD_NORSTRT)
 #define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
 #define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
+#define DW_IC_RX_ABRT_SLAVE_RD_INTX	(1UL << ABRT_SLAVE_RD_INTX)
+#define DW_IC_RX_ABRT_SLAVE_ARBLOST	(1UL << ABRT_SLAVE_ARBLOST)
+#define DW_IC_RX_ABRT_SLAVE_FLUSH_TXFIFO	(1UL << ABRT_SLAVE_FLUSH_TXFIFO)
 
 #define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
 					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
@@ -195,6 +212,7 @@ struct dw_i2c_dev {
 	void __iomem		*base;
 	struct completion	cmd_complete;
 	struct clk		*clk;
+	struct i2c_client		*slave;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
 	struct dw_pci_controller *controller;
 	int			cmd_err;
@@ -214,6 +232,7 @@ struct dw_i2c_dev {
 	struct i2c_adapter	adapter;
 	u32			functionality;
 	u32			master_cfg;
+	u32			slave_cfg;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 	int			rx_outstanding;
@@ -257,6 +276,11 @@ extern void i2c_dw_disable(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable_int(struct dw_i2c_dev *dev);
 extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe(struct dw_i2c_dev *dev);
+extern int i2c_dw_init_slave(struct dw_i2c_dev *dev);
+extern void i2c_dw_disable_slave(struct dw_i2c_dev *dev);
+extern void i2c_dw_disable_int_slave(struct dw_i2c_dev *dev);
+extern u32 i2c_dw_read_comp_param_slave(struct dw_i2c_dev *dev);
+extern int i2c_dw_probe_slave(struct dw_i2c_dev *dev);
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 extern int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-src.c b/drivers/i2c/busses/i2c-designware-src.c
index 4ec0045..838ef66 100644
--- a/drivers/i2c/busses/i2c-designware-src.c
+++ b/drivers/i2c/busses/i2c-designware-src.c
@@ -55,6 +55,12 @@ static char *abort_sources[] = {
 		"trying to use disabled adapter",
 	[ARB_LOST] =
 		"lost arbitration",
+	[ABRT_SLAVE_FLUSH_TXFIFO] =
+		"read command so flush old data in the TX FIFO",
+	[ABRT_SLAVE_ARBLOST] =
+		"slave lost the bus while transmitting data to a remote master",
+	[ABRT_SLAVE_RD_INTX] =
+		"slave request for data to be transmitted and",
 };
 
 u32 dw_readl(struct dw_i2c_dev *dev, int offset)
-- 
2.10.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
