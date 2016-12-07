From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v4 3/5] i2c: designware: Add slave definitions
Date: Wed,  7 Dec 2016 17:55:50 +0000
Message-ID: <5173a9456c423025d8f15baafa2499440cbe1b51.1481131072.git.lolivei@synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481131072.git.lolivei@synopsys.com>
In-Reply-To: <cover.1481131072.git.lolivei@synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- Add slave definitions to i2c-designware-core
- Changes in Kconfig to auto-enable I2C_SLAVE when compiling the modules
- Add mode property to designware-core.txt that enable the "slave" selection:
  - "mode" is an optional property that could be "slave" or "master"
  - if "mode" is not set the block is considered master by default

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V3->V4: (Andy Shevchenko)
- created a common property for modes 
- placed the generic dependency first

 .../devicetree/bindings/i2c/i2c-designware.txt     |  4 ++++
 drivers/i2c/busses/Kconfig                         |  1 +
 drivers/i2c/busses/i2c-designware-common.c         |  6 +++++
 drivers/i2c/busses/i2c-designware-core.h           | 26 ++++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fee26dc3e858..8ed2b532cd54 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -20,6 +20,9 @@ Optional properties :
  - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
    This value which is by default 300ns is used to compute the tHIGH period.
 
+ - mode : should be either:
+           - "master" to setup the hardware block as a I2C master
+           - "slave" to setup the hardware block as a I2C slave
 Example :
 
 	i2c@f0000 {
@@ -42,4 +45,5 @@ Example :
 		i2c-sda-hold-time-ns = <300>;
 		i2c-sda-falling-time-ns = <300>;
 		i2c-scl-falling-time-ns = <300>;
+		mode = "slave";
 	};
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8e43914023df..0c917b1a4778 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -469,6 +469,7 @@ config I2C_DESIGNWARE_CORE
 
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
+	select I2C_SLAVE
 	select I2C_DESIGNWARE_CORE
 	depends on (ACPI && COMMON_CLK) || !ACPI
 	help
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 6afd2ff5d73f..41b38d8b8732 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
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
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 8bba7a37c3ce..b7dcd134e208 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -36,15 +36,20 @@
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
@@ -75,6 +80,7 @@
 #define DW_IC_SDA_HOLD		0x7c
 #define DW_IC_TX_ABRT_SOURCE	0x80
 #define DW_IC_ENABLE_STATUS	0x9c
+#define DW_IC_CLR_RESTART_DET	0xa8
 #define DW_IC_COMP_PARAM_1	0xf4
 #define DW_IC_COMP_VERSION	0xf8
 #define DW_IC_SDA_HOLD_MIN_VERS	0x3131312A
@@ -93,15 +99,22 @@
 #define DW_IC_INTR_STOP_DET	0x200
 #define DW_IC_INTR_START_DET	0x400
 #define DW_IC_INTR_GEN_CALL	0x800
+#define DW_IC_INTR_RESTART_DET	0x1000
 
 #define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
 					 DW_IC_INTR_TX_ABRT | \
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
@@ -139,6 +152,9 @@
 #define ABRT_10B_RD_NORSTRT	10
 #define ABRT_MASTER_DIS		11
 #define ARB_LOST		12
+#define ABRT_SLAVE_FLUSH_TXFIFO	13
+#define ABRT_SLAVE_ARBLOST	14
+#define ABRT_SLAVE_RD_INTX	15
 
 #define DW_IC_TX_ABRT_7B_ADDR_NOACK	(1UL << ABRT_7B_ADDR_NOACK)
 #define DW_IC_TX_ABRT_10ADDR1_NOACK	(1UL << ABRT_10ADDR1_NOACK)
@@ -151,6 +167,9 @@
 #define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL << ABRT_10B_RD_NORSTRT)
 #define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
 #define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
+#define DW_IC_RX_ABRT_SLAVE_RD_INTX	(1UL << ABRT_SLAVE_RD_INTX)
+#define DW_IC_RX_ABRT_SLAVE_ARBLOST	(1UL << ABRT_SLAVE_ARBLOST)
+#define DW_IC_RX_ABRT_SLAVE_FLUSH_TXFIFO	(1UL << ABRT_SLAVE_FLUSH_TXFIFO)
 
 #define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
 					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
@@ -206,6 +225,7 @@ struct dw_i2c_dev {
 	void __iomem		*base;
 	struct completion	cmd_complete;
 	struct clk		*clk;
+	struct i2c_client		*slave;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
 	struct dw_pci_controller *controller;
 	int			cmd_err;
@@ -225,6 +245,7 @@ struct dw_i2c_dev {
 	struct i2c_adapter	adapter;
 	u32			functionality;
 	u32			master_cfg;
+	u32			slave_cfg;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 	int			rx_outstanding;
@@ -268,6 +289,11 @@ extern void i2c_dw_disable(struct dw_i2c_dev *dev);
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
-- 
2.11.0
