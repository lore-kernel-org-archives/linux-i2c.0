From: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: fix RX FIFO overrun
Date: Mon, 22 Apr 2013 15:08:59 +0100 (IST)
Message-ID: <alpine.DEB.2.02.1304221508050.31571@localhost>
References: <alpine.DEB.2.02.1304191859570.17829@localhost> <20130422071943.GK1283@intel.com> <53398.163.33.213.79.1366630241.squirrel@linux.intel.com> <20130422122808.GO1283@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130422122808.GO1283-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>From a969728248c3b439dc97a69e7dac133b5efa34e7 Mon Sep 17 00:00:00 2001
From: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Fri, 19 Apr 2013 17:28:10 +0100
Subject: [PATCH] i2c-designware: fix RX FIFO overrun

i2c_dw_xfer_msg() pushes a number of bytes to transmit/receive
to/from the bus into the TX FIFO.
For master-rx transactions, the maximum amount of data that can be
received is calculated depending solely on TX and RX FIFO load.

This is racy - TX FIFO may contain master-rx data yet to be
processed, which will eventually land into the RX FIFO. This
data is not taken into account and the function may request more
data than the controller is actually capable of storing.

This patch ensures the driver takes into account the outstanding
master-rx data in TX FIFO to prevent RX FIFO overrun.

Signed-off-by: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
  drivers/i2c/busses/i2c-designware-core.c |   11 ++++++++++-
  drivers/i2c/busses/i2c-designware-core.h |    2 ++
  2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 94fd818..8dbeef1 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -426,8 +426,14 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
  				cmd |= BIT(9);

  			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
+
+				/* avoid rx buffer overrun */
+				if (rx_limit - dev->rx_outstanding <= 0)
+					break;
+
  				dw_writel(dev, cmd | 0x100, DW_IC_DATA_CMD);
  				rx_limit--;
+				dev->rx_outstanding++;
  			} else
  				dw_writel(dev, cmd | *buf++, DW_IC_DATA_CMD);
  			tx_limit--; buf_len--;
@@ -480,8 +486,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)

  		rx_valid = dw_readl(dev, DW_IC_RXFLR);

-		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
+		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
  			*buf++ = dw_readl(dev, DW_IC_DATA_CMD);
+			dev->rx_outstanding--;
+		}

  		if (len > 0) {
  			dev->status |= STATUS_READ_IN_PROGRESS;
@@ -539,6 +547,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
  	dev->msg_err = 0;
  	dev->status = STATUS_IDLE;
  	dev->abort_source = 0;
+	dev->rx_outstanding = 0;

  	ret = i2c_dw_wait_bus_not_busy(dev);
  	if (ret < 0)
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9c1840e..e761ad1 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -60,6 +60,7 @@
   * @adapter: i2c subsystem adapter node
   * @tx_fifo_depth: depth of the hardware tx fifo
   * @rx_fifo_depth: depth of the hardware rx fifo
+ * @rx_outstanding: current master-rx elements in tx fifo
   */
  struct dw_i2c_dev {
  	struct device		*dev;
@@ -88,6 +89,7 @@ struct dw_i2c_dev {
  	u32			master_cfg;
  	unsigned int		tx_fifo_depth;
  	unsigned int		rx_fifo_depth;
+	int			rx_outstanding;
  };

  #define ACCESS_SWAP		0x00000001
-- 
1.7.0.7
