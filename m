From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v7 4/6] i2c: designware: introducing I2C_SLAVE definitions
Date: Mon, 20 Mar 2017 11:10:43 +0000
Message-ID: <55d2ccf235080a77347ad9e3a34263ca9cc8f80d.1490007620.git.lolivei@synopsys.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490007620.git.lolivei@synopsys.com>
In-Reply-To: <cover.1490007620.git.lolivei@synopsys.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- Definitions were added to core library
- A example was added to designware-core.txt Documentation that shows
  how the slave can be setup using DTS

SLAVE related definitions were added to the core of the controller.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v6-v7
- no changes

 .../devicetree/bindings/i2c/i2c-designware.txt     | 16 +++++++++++-
 drivers/i2c/busses/i2c-designware-core.h           | 29 +++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fee26dc3e858..fbb0a6d8b964 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -20,7 +20,7 @@ Optional properties :
  - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
    This value which is by default 300ns is used to compute the tHIGH period.
 
-Example :
+Examples :
 
 	i2c@f0000 {
 		#address-cells = <1>;
@@ -43,3 +43,17 @@ Example :
 		i2c-sda-falling-time-ns = <300>;
 		i2c-scl-falling-time-ns = <300>;
 	};
+
+	i2c@1120000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x2000 0x100>;
+		clock-frequency = <400000>;
+		clocks = <&i2cclk>;
+		interrupts = <0>;
+
+		eeprom@64 {
+			compatible = "linux,slave-24c02";
+			reg = <0x40000064>;
+		};
+	};
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index e04d64166a9a..33087e640f69 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -1,5 +1,5 @@
 /*
- * Synopsys DesignWare I2C adapter driver (master only).
+ * Synopsys DesignWare I2C adapter driver.
  *
  * Based on the TI DAVINCI I2C adapter driver.
  *
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
@@ -123,6 +136,12 @@
 #define TIMEOUT			20 /* ms */
 
 /*
+ * operation modes
+ */
+#define DW_IC_MASTER		0
+#define DW_IC_SLAVE		1
+
+/*
  * hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
  *
  * only expected abort codes are listed here
@@ -139,6 +158,9 @@
 #define ABRT_10B_RD_NORSTRT	10
 #define ABRT_MASTER_DIS		11
 #define ARB_LOST		12
+#define ABRT_SLAVE_FLUSH_TXFIFO	13
+#define ABRT_SLAVE_ARBLOST	14
+#define ABRT_SLAVE_RD_INTX	15
 
 #define DW_IC_TX_ABRT_7B_ADDR_NOACK	(1UL << ABRT_7B_ADDR_NOACK)
 #define DW_IC_TX_ABRT_10ADDR1_NOACK	(1UL << ABRT_10ADDR1_NOACK)
@@ -151,6 +173,9 @@
 #define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL << ABRT_10B_RD_NORSTRT)
 #define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
 #define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
+#define DW_IC_RX_ABRT_SLAVE_RD_INTX	(1UL << ABRT_SLAVE_RD_INTX)
+#define DW_IC_RX_ABRT_SLAVE_ARBLOST	(1UL << ABRT_SLAVE_ARBLOST)
+#define DW_IC_RX_ABRT_SLAVE_FLUSH_TXFIFO	(1UL << ABRT_SLAVE_FLUSH_TXFIFO)
 
 #define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
 					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
@@ -211,6 +236,7 @@ struct dw_i2c_dev {
 	struct completion	cmd_complete;
 	struct clk		*clk;
 	struct reset_control	*rst;
+	struct i2c_client		*slave;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
 	struct dw_pci_controller *controller;
 	int			cmd_err;
@@ -230,6 +256,7 @@ struct dw_i2c_dev {
 	struct i2c_adapter	adapter;
 	u32			functionality;
 	u32			master_cfg;
+	u32			slave_cfg;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 	int			rx_outstanding;
-- 
2.11.0
