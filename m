From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH v2] i2c: axxia: support slave mode
Date: Fri, 9 Aug 2019 09:17:17 +0000
Message-ID: <20190809091709.GA24838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <3C40C622DCA39749B983F4B3D6D238E4@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org

This device contains both master and slave controllers which can be
enabled simultaneously. Both controllers share the same SDA/SCL lines
and interrupt source but has separate control and status registers.
Controllers also works in loopback mode - slave device can communicate
with its own master controller internally. The controller can handle up
to two addresses, both of which may be 10 bit. Most of the logic
(sending (N)ACK, handling repeated start or switching between
write/read) is handled automatically which makes working with this
controller quite easy.

For simplicity, this patch adds basic support, limiting to only one
slave address. Support for the 2nd device may be added in the future.

Note that synchronize_irq() is used to ensure any running slave interrupt
is finished to make sure slave i2c_client structure can be safely used
by i2c_slave_event.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
Changes in v2:
- Reduced the number of dev_dbg messages.

 drivers/i2c/busses/Kconfig     |   1 +
 drivers/i2c/busses/i2c-axxia.c | 155 +++++++++++++++++++++++++++++++--
 2 files changed, 148 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 69f19312a574..b8262301c86d 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -429,6 +429,7 @@ config I2C_AXXIA
 	tristate "Axxia I2C controller"
 	depends on ARCH_AXXIA || COMPILE_TEST
 	default ARCH_AXXIA
+	select I2C_SLAVE
 	help
 	  Say yes if you want to support the I2C bus on Axxia platforms.
=20
diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index ff3142b15cab..5648f554ba49 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -77,6 +77,40 @@
 				 MST_STATUS_IP)
 #define MST_TX_BYTES_XFRD	0x50
 #define MST_RX_BYTES_XFRD	0x54
+#define SLV_ADDR_DEC_CTL	0x58
+#define   SLV_ADDR_DEC_GCE	BIT(0)  /* ACK to General Call Address from own=
 master (loopback) */
+#define   SLV_ADDR_DEC_OGCE	BIT(1)  /* ACK to General Call Address from ex=
ternal masters */
+#define   SLV_ADDR_DEC_SA1E	BIT(2)  /* ACK to addr_1 enabled */
+#define   SLV_ADDR_DEC_SA1M	BIT(3)  /* 10-bit addressing for addr_1 enable=
d */
+#define   SLV_ADDR_DEC_SA2E	BIT(4)  /* ACK to addr_2 enabled */
+#define   SLV_ADDR_DEC_SA2M	BIT(5)  /* 10-bit addressing for addr_2 enable=
d */
+#define SLV_ADDR_1		0x5c
+#define SLV_ADDR_2		0x60
+#define SLV_RX_CTL		0x64
+#define   SLV_RX_ACSA1		BIT(0)  /* Generate ACK for writes to addr_1 */
+#define   SLV_RX_ACSA2		BIT(1)  /* Generate ACK for writes to addr_2 */
+#define   SLV_RX_ACGCA		BIT(2)  /* ACK data phase transfers to General Cal=
l Address */
+#define SLV_DATA		0x68
+#define SLV_RX_FIFO		0x6c
+#define   SLV_FIFO_DV1		BIT(0)  /* Data Valid for addr_1 */
+#define   SLV_FIFO_DV2		BIT(1)  /* Data Valid for addr_2 */
+#define   SLV_FIFO_AS		BIT(2)  /* (N)ACK Sent */
+#define   SLV_FIFO_TNAK		BIT(3)  /* Timeout NACK */
+#define   SLV_FIFO_STRC		BIT(4)  /* First byte after start condition recei=
ved */
+#define   SLV_FIFO_RSC		BIT(5)  /* Repeated Start Condition */
+#define   SLV_FIFO_STPC		BIT(6)  /* Stop Condition */
+#define   SLV_FIFO_DV		(SLV_FIFO_DV1 | SLV_FIFO_DV2)
+#define SLV_INT_ENABLE		0x70
+#define SLV_INT_STATUS		0x74
+#define   SLV_STATUS_RFH	BIT(0)  /* FIFO service */
+#define   SLV_STATUS_WTC	BIT(1)  /* Write transfer complete */
+#define   SLV_STATUS_SRS1	BIT(2)  /* Slave read from addr 1 */
+#define   SLV_STATUS_SRRS1	BIT(3)  /* Repeated start from addr 1 */
+#define   SLV_STATUS_SRND1	BIT(4)  /* Read request not following start con=
dition */
+#define   SLV_STATUS_SRC1	BIT(5)  /* Read canceled */
+#define   SLV_STATUS_SRAT1	BIT(6)  /* Slave Read timed out */
+#define   SLV_STATUS_SRDRE1	BIT(7)  /* Data written after timed out */
+#define SLV_READ_DUMMY		0x78
 #define SCL_HIGH_PERIOD		0x80
 #define SCL_LOW_PERIOD		0x84
 #define SPIKE_FLTR_LEN		0x88
@@ -111,6 +145,8 @@ struct axxia_i2c_dev {
 	struct clk *i2c_clk;
 	u32 bus_clk_rate;
 	bool last;
+	struct i2c_client *slave;
+	int irq;
 };
=20
 static void i2c_int_disable(struct axxia_i2c_dev *idev, u32 mask)
@@ -276,13 +312,68 @@ static int axxia_i2c_fill_tx_fifo(struct axxia_i2c_de=
v *idev)
 	return ret;
 }
=20
+static void axxia_i2c_slv_fifo_event(struct axxia_i2c_dev *idev)
+{
+	u32 fifo_status =3D readl(idev->base + SLV_RX_FIFO);
+	u8 val;
+
+	dev_dbg(idev->dev, "slave irq fifo_status=3D0x%x\n", fifo_status);
+
+	if (fifo_status & SLV_FIFO_DV1) {
+		if (fifo_status & SLV_FIFO_STRC) {
+			i2c_slave_event(idev->slave,
+					I2C_SLAVE_WRITE_REQUESTED, &val);
+		}
+
+		val =3D readl(idev->base + SLV_DATA);
+		i2c_slave_event(idev->slave, I2C_SLAVE_WRITE_RECEIVED, &val);
+	}
+	if (fifo_status & SLV_FIFO_STPC) {
+		readl(idev->base + SLV_DATA); /* dummy read */
+		i2c_slave_event(idev->slave, I2C_SLAVE_STOP, &val);
+	}
+	if (fifo_status & SLV_FIFO_RSC) {
+		readl(idev->base + SLV_DATA); /* dummy read */
+	}
+}
+
+static irqreturn_t axxia_i2c_slv_isr(struct axxia_i2c_dev *idev)
+{
+	u32 status =3D readl(idev->base + SLV_INT_STATUS);
+	u8 val;
+
+	dev_dbg(idev->dev, "slave irq status=3D0x%x\n", status);
+
+	if (status & SLV_STATUS_RFH)
+		axxia_i2c_slv_fifo_event(idev);
+	if (status & SLV_STATUS_SRS1) {
+		i2c_slave_event(idev->slave, I2C_SLAVE_READ_REQUESTED, &val);
+		writel(val, idev->base + SLV_DATA);
+	}
+	if (status & SLV_STATUS_SRND1) {
+		i2c_slave_event(idev->slave, I2C_SLAVE_READ_PROCESSED, &val);
+		writel(val, idev->base + SLV_DATA);
+	}
+	if (status & SLV_STATUS_SRC1) {
+		i2c_slave_event(idev->slave, I2C_SLAVE_STOP, &val);
+	}
+
+	writel(INT_SLV, idev->base + INTERRUPT_STATUS);
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 {
 	struct axxia_i2c_dev *idev =3D _dev;
+	irqreturn_t ret =3D IRQ_NONE;
 	u32 status;
=20
-	if (!(readl(idev->base + INTERRUPT_STATUS) & INT_MST))
-		return IRQ_NONE;
+	status =3D readl(idev->base + INTERRUPT_STATUS);
+
+	if (status & INT_SLV)
+		ret =3D axxia_i2c_slv_isr(idev);
+	if (!(status & INT_MST))
+		return ret;
=20
 	/* Read interrupt status bits */
 	status =3D readl(idev->base + MST_INT_STATUS);
@@ -583,9 +674,58 @@ static u32 axxia_i2c_func(struct i2c_adapter *adap)
 	return caps;
 }
=20
+static int axxia_i2c_reg_slave(struct i2c_client *slave)
+{
+	struct axxia_i2c_dev *idev =3D i2c_get_adapdata(slave->adapter);
+	u32 slv_int_mask =3D SLV_STATUS_RFH;
+	u32 dec_ctl;
+
+	if (idev->slave)
+		return -EBUSY;
+
+	idev->slave =3D slave;
+
+	/* Enable slave mode as well */
+	writel(GLOBAL_MST_EN | GLOBAL_SLV_EN, idev->base + GLOBAL_CONTROL);
+	writel(INT_MST | INT_SLV, idev->base + INTERRUPT_ENABLE);
+
+	/* Set slave address */
+	dec_ctl =3D SLV_ADDR_DEC_SA1E;
+	if (slave->flags & I2C_CLIENT_TEN)
+		dec_ctl |=3D SLV_ADDR_DEC_SA1M;
+
+	writel(SLV_RX_ACSA1, idev->base + SLV_RX_CTL);
+	writel(dec_ctl, idev->base + SLV_ADDR_DEC_CTL);
+	writel(slave->addr, idev->base + SLV_ADDR_1);
+
+	/* Enable interrupts */
+	slv_int_mask |=3D SLV_STATUS_SRS1 | SLV_STATUS_SRRS1 | SLV_STATUS_SRND1;
+	slv_int_mask |=3D SLV_STATUS_SRC1;
+	writel(slv_int_mask, idev->base + SLV_INT_ENABLE);
+
+	return 0;
+}
+
+static int axxia_i2c_unreg_slave(struct i2c_client *slave)
+{
+	struct axxia_i2c_dev *idev =3D i2c_get_adapdata(slave->adapter);
+
+	/* Disable slave mode */
+	writel(GLOBAL_MST_EN, idev->base + GLOBAL_CONTROL);
+	writel(INT_MST, idev->base + INTERRUPT_ENABLE);
+
+	synchronize_irq(idev->irq);
+
+	idev->slave =3D NULL;
+
+	return 0;
+}
+
 static const struct i2c_algorithm axxia_i2c_algo =3D {
 	.master_xfer =3D axxia_i2c_xfer,
 	.functionality =3D axxia_i2c_func,
+	.reg_slave =3D axxia_i2c_reg_slave,
+	.unreg_slave =3D axxia_i2c_unreg_slave,
 };
=20
 static const struct i2c_adapter_quirks axxia_i2c_quirks =3D {
@@ -599,7 +739,6 @@ static int axxia_i2c_probe(struct platform_device *pdev=
)
 	struct axxia_i2c_dev *idev =3D NULL;
 	struct resource *res;
 	void __iomem *base;
-	int irq;
 	int ret =3D 0;
=20
 	idev =3D devm_kzalloc(&pdev->dev, sizeof(*idev), GFP_KERNEL);
@@ -611,10 +750,10 @@ static int axxia_i2c_probe(struct platform_device *pd=
ev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
=20
-	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0) {
+	idev->irq =3D platform_get_irq(pdev, 0);
+	if (idev->irq < 0) {
 		dev_err(&pdev->dev, "missing interrupt resource\n");
-		return irq;
+		return idev->irq;
 	}
=20
 	idev->i2c_clk =3D devm_clk_get(&pdev->dev, "i2c");
@@ -643,10 +782,10 @@ static int axxia_i2c_probe(struct platform_device *pd=
ev)
 		goto error_disable_clk;
 	}
=20
-	ret =3D devm_request_irq(&pdev->dev, irq, axxia_i2c_isr, 0,
+	ret =3D devm_request_irq(&pdev->dev, idev->irq, axxia_i2c_isr, 0,
 			       pdev->name, idev);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to claim IRQ%d\n", irq);
+		dev_err(&pdev->dev, "failed to claim IRQ%d\n", idev->irq);
 		goto error_disable_clk;
 	}
=20
--=20
2.21.0
