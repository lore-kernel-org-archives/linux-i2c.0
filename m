From: Marc Dietrich <Marc.Dietrich-wkdnK3oF/XPYtB+G+YtuwQgYPMzSbZxj@public.gmane.org>
Subject: Re: implementing a slave driver
Date: Thu, 24 Feb 2011 17:09:30 +0100
Message-ID: <201102241709.32607.marc.dietrich@ap.physik.uni-giessen.de>
References: <127CF106CD5B1D4EBD10849ED01511C04A7349@rennsmail06.eu.thmulti.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8KoZNxO0sMw3r1O"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <127CF106CD5B1D4EBD10849ED01511C04A7349-JSBSl2LYuLWxj7G+uSGfQodCfwrvHnrt0E9HWUfgJXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fillod Stephane <stephane.fillod-IW5+RbcfqPSTtA8H5PvdGFaTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--Boundary-00=_8KoZNxO0sMw3r1O
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fillod Stephane wrote:
> Marc Dietrich wrote:
> > the HW I'm using (tegra) can be configured to act as a slave. This
> > function is
> > needed to communicate with an embedded controller (which is the
> > master). I
> > like to know if this slave function can/should be implemented in the
> > i2c/busses/i2c-tegra.c driver or better outside, e.g. in the driver
> > for the
> > embedded controller.
> 
> Do you need to implement a slave for write-only or also read messages?

it's mostly slave -> master communication. If slave wants to send something to 
the master, it triggers gpio line and master requests the data via interrupt.

> > I haven't found any other hw so far which has this function and it
> > seems that
> > the i2c layer does not provide any interface for the communication
> > with master.
> 
> In fact, the Freescale's MPC8xxx I2C controllers are also capable of
> slave
> operation. I've implemented it, and it's working fine.
> 
> Please find attached a patch against 2.6.35.

For tegra it seems not no simple (see attached patch). The question is if the 
driver should be added to the controller source (i2c-tegra) or in the mfd, where 
the data is getting processed and handed to the appropriate drivers (keyboard, 
mouse, ...). The first method needs some software interface, while the latter 
will tear the code for the same hardware.

> The proposal sent last year[1] relies on a generic API extension.
> <<
> The i2c-dev subsystem is extended with a new flag I2C_M_SLAVE.
> Basically, a struct i2c_msg holding flag I2C_M_SLAVE will wait
> in slave mode for a write request on specified target address,
> and will report the received content to the user-land application.
> 
> An example of driver implementation has been done for i2c-mpc.
> There's no support for read request yet, and I'm wondering whether
> it would make sense. The patch has been tested on powerpc MPC8313E.
> Note: the present i2c-mpc implementation is RFC and may be improved,
> esp. regarding current timing issues.
> 
> [...]
> Talking about i2c-dev, does the I2C_M_SLAVE flag is the appropriate
> way of modelling the API extension? Is there any interest for
> this extension to be accepted in the linux kernel?

I wonder if this API will fit into the scenario descriped above.
 
> Until now, I have no good proposal for the read request.
> It should be doable to pass a static array and let the kernel read from
> it,
> but I see no easy way to have a user task respond with
> compute-as-you-go.

well, I don't care about user-space as the mfd driver will only communicate with 
the master (maybe one can add a user-space interface to the mfd later).

I'm thinking of to let the mfd pass a simple pointer with the msg_buf to the 
slave driver, which should be simple to implement. 

Thanks

Marc

--Boundary-00=_8KoZNxO0sMw3r1O
Content-Type: text/x-patch;
  charset="us-ascii";
  name="tegra_slave.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tegra_slave.patch"

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index e950adf..cfd326f 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -25,6 +27,8 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/i2c-tegra.h>
+#include <linux/gpio.h>
+#include <linux/err.h>
 
 #include <asm/unaligned.h>
 
@@ -39,8 +43,19 @@
 #define I2C_CNFG_NEW_MASTER_FSM			(1<<11)
 #define I2C_STATUS				0x01C
 #define I2C_SL_CNFG				0x020
+#define I2C_SL_CNFG_NACK			(1<<1)
 #define I2C_SL_CNFG_NEWSL			(1<<2)
+
+#define I2C_SL_INT_RNW				(1<<1)
+#define I2C_SL_INT_RCVD				(1<<2)
+#define I2C_SL_IRQ				(1<<3)
+#define I2C_SL_INT_END_TRANS			(1<<4)
+
+#define I2C_SL_RCVD				0x024
+#define I2C_SL_STATUS				0x028
 #define I2C_SL_ADDR1				0x02c
+#define I2C_SL_ADDR2				0x030
+#define I2C_SL_DELAY_COUNT			0x03c
 #define I2C_TX_FIFO				0x050
 #define I2C_RX_FIFO				0x054
 #define I2C_PACKET_TRANSFER_STATUS		0x058
@@ -116,6 +131,7 @@ struct tegra_i2c_dev {
 	int irq;
 	bool irq_disabled;
 	int is_dvc;
+	int slave_addr;
 	struct completion msg_complete;
 	int msg_err;
 	u8 *msg_buf;
@@ -298,6 +314,23 @@ static void tegra_dvc_init(struct tegra_i2c_dev *i2c_dev)
 	dvc_writel(i2c_dev, val, DVC_CTRL_REG1);
 }
 
+static int tegra_i2c_slave_init(struct tegra_i2c_dev *i2c_dev)
+{
+	printk(KERN_INFO "init slave at 0x%02x\n", i2c_dev->slave_addr);
+
+	i2c_writel(i2c_dev, i2c_dev->slave_addr, I2C_SL_ADDR1);
+	i2c_writel(i2c_dev, 0, I2C_SL_ADDR2);
+
+	i2c_writel(i2c_dev, 0x1E, I2C_SL_DELAY_COUNT);
+	i2c_writel(i2c_dev, I2C_CNFG_NEW_MASTER_FSM, I2C_CNFG);
+	i2c_writel(i2c_dev, I2C_SL_CNFG_NEWSL, I2C_SL_CNFG);
+
+	gpio_request(0xaa, "nvec gpio");
+	gpio_direction_output(0xaa, 0);
+
+	return 0;
+}
+
 static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 {
 	u32 val;
@@ -320,7 +353,6 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	if (!i2c_dev->is_dvc) {
 		u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
 		i2c_writel(i2c_dev, sl_cfg | I2C_SL_CNFG_NEWSL, I2C_SL_CNFG);
-		printk(KERN_ALERT "slave cfg: %d\n", sl_cfg | I2C_SL_CNFG_NEWSL);
 	}
 
 	val = 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
@@ -340,6 +372,97 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	return 0;
 }
 
+static unsigned char tx_buf[8] = {0x03, 0x05, 0xed, 0x07};
+static unsigned char rx_buf[255];
+static int tx_pos = 0;
+static int rx_pos = 0;
+
+static void enqueue_rx_data(struct work_struct *work)
+{
+#ifdef DEBUG
+	int i;
+	printk(KERN_ALERT "incomming message (%d)\t", rx_pos);
+
+	for(i=0; i<rx_pos; ++i)
+		printk("0x%02x ", rx_buf[i]);
+
+	printk("\n");
+#endif
+}
+
+static DECLARE_WORK(worker, enqueue_rx_data);
+
+static irqreturn_t tegra_i2c_slave_isr(int irq, void *dev_id)
+{
+	u32 status;
+	struct tegra_i2c_dev *i2c_dev = dev_id;
+	unsigned char received;
+
+	status = i2c_readl(i2c_dev, I2C_SL_STATUS);
+
+	if (unlikely(!(status & I2C_SL_IRQ))) {
+		dev_warn(i2c_dev->dev, "irq status 0 %08x %08x %08x\n",
+			 i2c_readl(i2c_dev, I2C_SL_RCVD),
+			 i2c_readl(i2c_dev, I2C_SL_STATUS),
+			 i2c_readl(i2c_dev, I2C_SL_CNFG));
+		i2c_dev->msg_err |= I2C_ERR_UNKNOWN_INTERRUPT;
+
+		if (! i2c_dev->irq_disabled) {
+			disable_irq_nosync(i2c_dev->irq);
+			i2c_dev->irq_disabled = 1;
+		}
+
+		goto err;
+	}
+
+	dev_dbg(i2c_dev->dev, "received int from slave, status: 0x%08x\n", status);
+
+	gpio_direction_output(0xaa, 1);
+
+	if ((status & I2C_SL_INT_END_TRANS) &&
+	   !(status & I2C_SL_INT_RCVD)) {
+		dev_dbg(i2c_dev->dev, "transmission ended here\n");
+		schedule_work(&worker);
+		return IRQ_HANDLED;
+	} else if (status & I2C_SL_INT_RNW) {
+		if (status & I2C_SL_INT_RCVD) {
+			dev_dbg(i2c_dev->dev, "new read comm!\n");
+		} else {
+			dev_dbg(i2c_dev->dev, "read comm continued!\n");
+		}
+		if (tx_pos<sizeof(tx_buf)) {
+			dev_dbg(i2c_dev->dev, "sending 0x%02x\n", tx_buf[tx_pos]);
+			i2c_writel(i2c_dev, tx_buf[tx_pos++], I2C_SL_RCVD);
+		} else {
+			dev_dbg(i2c_dev->dev, "nothing to send\n");
+			i2c_writel(i2c_dev, 0x01, I2C_SL_RCVD);
+		}
+		return IRQ_HANDLED;
+	} else {
+		received = i2c_readl(i2c_dev, I2C_SL_RCVD);
+		i2c_writel(i2c_dev, 0, I2C_SL_RCVD);
+		if (status & I2C_SL_INT_RCVD) {
+			dev_dbg(i2c_dev->dev,
+				"Received new transaction \
+				destined to %02x (we're 0x8a)\n", received);
+			rx_pos = 0;
+			return IRQ_HANDLED;
+		}
+		dev_dbg(i2c_dev->dev, "Got %02x from Master\n", received);
+		rx_buf[rx_pos++] = (unsigned char)received;
+	}
+
+	return IRQ_HANDLED;
+
+err:
+	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
+		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
+		I2C_INT_RX_FIFO_DATA_REQ);
+	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 {
 	u32 status;
@@ -620,22 +743,41 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	rt_mutex_init(&i2c_dev->dev_lock);
 
 	i2c_dev->is_dvc = plat->is_dvc;
+	i2c_dev->slave_addr = plat->slave_addr;
 	init_completion(&i2c_dev->msg_complete);
 
 	platform_set_drvdata(pdev, i2c_dev);
 
-	ret = tegra_i2c_init(i2c_dev);
-	if (ret)
-		goto err_free;
+	if (i2c_dev->slave_addr) {
+		printk(KERN_INFO "%s configured as slave\n", pdev->name);
+		ret = tegra_i2c_slave_init(i2c_dev);
+		if (ret)
+			goto err_free;
 
-	ret = request_irq(i2c_dev->irq, tegra_i2c_isr, IRQF_DISABLED,
-		pdev->name, i2c_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq %i\n", i2c_dev->irq);
-		goto err_free;
-	}
+		ret = request_irq(i2c_dev->irq, tegra_i2c_slave_isr, 0,
+				pdev->name, i2c_dev);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request irq %i\n", i2c_dev->irq);
+			goto err_free;
+		}
 
-	clk_enable(i2c_dev->i2c_clk);
+		clk_enable(clk);
+
+	} else {
+		ret = tegra_i2c_init(i2c_dev);
+		if (ret)
+			goto err_free;
+
+		ret = request_irq(i2c_dev->irq, tegra_i2c_isr, IRQF_DISABLED,
+			pdev->name, i2c_dev);
+
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request irq %i\n", i2c_dev->irq);
+			goto err_free;
+		}
+
+		clk_enable(i2c_dev->i2c_clk);
+	}
 
 	for (i = 0; i < nbus; i++) {
 		struct tegra_i2c_bus *i2c_bus = &i2c_dev->busses[i];
diff --git a/include/linux/i2c-tegra.h b/include/linux/i2c-tegra.h
index 6123502..8b07b01 100644
--- a/include/linux/i2c-tegra.h
+++ b/include/linux/i2c-tegra.h
@@ -29,6 +29,7 @@ struct tegra_i2c_platform_data {
 	int bus_mux_len[TEGRA_I2C_MAX_BUS];
 	unsigned long bus_clk_rate[TEGRA_I2C_MAX_BUS];
 	bool is_dvc;
+	int slave_addr;
 };
 
 #endif /* _LINUX_I2C_TEGRA_H */

--Boundary-00=_8KoZNxO0sMw3r1O--
