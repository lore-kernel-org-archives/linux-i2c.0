From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/11] i2c: pxa: add more error handling for i2c controller
Date: Thu,  8 Nov 2012 22:17:56 +0800
Message-ID: <1352384284-15660-3-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

1 enable debug function to dump more info if there is error of i2c;
2 add i2c controller reset operation if there is "timeout" error;
3 add enable_irq/disable_irq for the i2c irq mode operation to avoid
"spurious irq" caused by CP polling mode;

Change-Id: Ia3c1bf54e71cbfb48edc259d7f46bec524c5c43a
Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 063ba23..cca387b 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -144,6 +144,7 @@ struct pxa_i2c {
 	unsigned int		msg_idx;
 	unsigned int		msg_ptr;
 	unsigned int		slave_addr;
+	unsigned int		req_slave_addr;
 
 	struct i2c_adapter	adap;
 	struct clk		*clk;
@@ -187,6 +188,9 @@ struct pxa_i2c {
  */
 #define I2C_PXA_SLAVE_ADDR      0x1
 
+#define DEBUG 0
+static void i2c_pxa_reset(struct pxa_i2c *i2c);
+
 #ifdef DEBUG
 
 struct bits {
@@ -267,11 +271,13 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
 	unsigned int i;
-	printk(KERN_ERR "i2c: error: %s\n", why);
+	printk(KERN_ERR"i2c: <%s> slave_0x%x error: %s\n", i2c->adap.name,
+		i2c->req_slave_addr >> 1, why);
 	printk(KERN_ERR "i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
 		i2c->msg_num, i2c->msg_idx, i2c->msg_ptr);
-	printk(KERN_ERR "i2c: ICR: %08x ISR: %08x\n",
-	       readl(_ICR(i2c)), readl(_ISR(i2c)));
+	printk(KERN_ERR "i2c: IBMR: %08x IDBR: %08x ICR: %08x ISR: %08x\n",
+		readl(_IBMR(i2c)), readl(_IDBR(i2c)), readl(_ICR(i2c)),
+		readl(_ISR(i2c)));
 	printk(KERN_DEBUG "i2c: log: ");
 	for (i = 0; i < i2c->irqlogidx; i++)
 		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
@@ -802,6 +808,9 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 	}
 
  out:
+	if (ret < 0)
+		i2c_pxa_reset(i2c);
+
 	return ret;
 }
 
@@ -933,6 +942,7 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32 isr)
 		 * Write the next address.
 		 */
 		writel(i2c_pxa_addr_byte(i2c->msg), _IDBR(i2c));
+		i2c->req_slave_addr = i2c_pxa_addr_byte(i2c->msg);
 
 		/*
 		 * And trigger a repeated start, and send the byte.
@@ -1038,6 +1048,7 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	struct pxa_i2c *i2c = adap->algo_data;
 	int ret, i;
 
+	enable_irq(i2c->irq);
 	for (i = adap->retries; i >= 0; i--) {
 		ret = i2c_pxa_do_xfer(i2c, msgs, num);
 		if (ret != I2C_RETRY)
@@ -1051,6 +1062,7 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	ret = -EREMOTEIO;
  out:
 	i2c_pxa_set_slave(i2c, ret);
+	disable_irq(i2c->irq);
 	return ret;
 }
 
-- 
1.7.5.4
