From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 10/22] i2c-designware: Set Tx/Rx FIFO threshold levels
Date: Fri, 06 Nov 2009 21:48:12 +0900
Message-ID: <4AF41B0C.2080604@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

As a hardware feature, DW I2C core generates a STOP condition whenever
the Tx FIFO becomes empty (strictly speaking, whenever the last byte in
the Tx FIFO is sent out), even if we have more bytes to be written.

In other words, we must never make "Tx FIFO underrun" happen during
a transaction, except for the last byte.  For the safety's sake, we'd
make TX_EMPTY interrupt get triggered every time one byte is processed.

The Rx FIFO threshold needs to be set as well.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 5fce1a0..0eea0dd 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -50,6 +50,8 @@
 #define DW_IC_INTR_STAT		0x2c
 #define DW_IC_INTR_MASK		0x30
 #define DW_IC_RAW_INTR_STAT	0x34
+#define DW_IC_RX_TL		0x38
+#define DW_IC_TX_TL		0x3c
 #define DW_IC_CLR_INTR		0x40
 #define DW_IC_CLR_RX_UNDER	0x44
 #define DW_IC_CLR_RX_OVER	0x48
@@ -295,6 +297,10 @@ static void i2c_dw_init(struct dw_i2c_dev *dev)
 	writel(lcnt, dev->base + DW_IC_FS_SCL_LCNT);
 	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
+	/* Configure Tx/Rx FIFO threshold levels */
+	writel(dev->tx_fifo_depth - 1, dev->base + DW_IC_TX_TL);
+	writel(0, dev->base + DW_IC_RX_TL);
+
 	/* configure the i2c master */
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
-- 
1.6.5.2
