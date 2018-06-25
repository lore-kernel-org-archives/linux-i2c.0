From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH 1/3] i2c:ocores: stop transfer on timeout
Date: Mon, 25 Jun 2018 18:13:01 +0200
Message-ID: <20180625161303.7991-2-federico.vaga@cern.ch>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625161303.7991-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>
Cc: federico.vaga@cern.ch
List-Id: linux-i2c@vger.kernel.org

Detecting a timeout is ok, but we also need to assert a STOP command on
the bus in order to prevent it from generating interrupts when there are
no on going transfers.

Example: very long transmission.

1. ocores_xfer: START a transfer
2. ocores_isr : handle byte by byte the transfer
3. ocores_xfer: goes in timeout [[bugfix here]]
4. ocores_xfer: return to I2C subsystem and to the I2C driver
5. I2C driver : it may clean up the i2c_msg memory
6. ocores_isr : receives another interrupt (pending bytes to be
                transferred) but the i2c_msg memory is invalid now

So, since the transfer was too long, we have to detect the timeout and
STOP the transfer.

Another point is that we have a critical region here. When handling the
timeout condition we may have a running IRQ handler. For this reason I
introduce a spinlock. In the IRQ handler we can just use trylock because
if the lock is taken is because we are in timeout, so there is no need to
process the IRQ.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 88444ef74943..98c0ef74882b 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/log2.h>
+#include <linux/spinlock.h>
 
 struct ocores_i2c {
 	void __iomem *base;
@@ -36,6 +37,7 @@ struct ocores_i2c {
 	int pos;
 	int nmsgs;
 	int state; /* see STATE_ */
+	spinlock_t xfer_lock;
 	struct clk *clk;
 	int ip_clock_khz;
 	int bus_clock_khz;
@@ -207,15 +209,30 @@ static void ocores_process(struct ocores_i2c *i2c)
 static irqreturn_t ocores_isr(int irq, void *dev_id)
 {
 	struct ocores_i2c *i2c = dev_id;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * We need to protect i2c against a timeout event (see ocores_xfer())
+	 * If we cannot take this lock, it means that we are already in
+	 * timeout, so it's pointless to handle this interrupt because we
+	 * are going to abort the current transfer.
+	 */
+	ret = spin_trylock_irqsave(&i2c->xfer_lock, flags);
+	if (!ret)
+		return IRQ_HANDLED;
 
 	ocores_process(i2c);
 
+	spin_unlock_irqrestore(&i2c->xfer_lock, flags);
+
 	return IRQ_HANDLED;
 }
 
 static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
+	unsigned long flags;
 
 	i2c->msg = msgs;
 	i2c->pos = 0;
@@ -226,10 +243,15 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
 	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
-			       (i2c->state == STATE_DONE), HZ))
+			       (i2c->state == STATE_DONE), HZ)) {
 		return (i2c->state == STATE_DONE) ? num : -EIO;
-	else
+	} else {
+		spin_lock_irqsave(&i2c->xfer_lock, flags);
+		i2c->state = STATE_ERROR;
+		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
+		spin_unlock_irqrestore(&i2c->xfer_lock, flags);
 		return -ETIMEDOUT;
+	}
 }
 
 static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
@@ -422,6 +444,8 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
+	spin_lock_init(&i2c->xfer_lock);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(i2c->base))
-- 
2.15.0
