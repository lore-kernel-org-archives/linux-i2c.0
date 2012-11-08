From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 09/11] i2c: pxa: add qos as constraint for cpu-idle
Date: Thu,  8 Nov 2012 22:18:02 +0800
Message-ID: <1352384284-15660-9-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Add qos as constraint for cpu-idle, which is standard way, then
sysfs could get accurae result.

Change-Id: I4165e01ca2c30f8422b4b4850497c70233d741f8
Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 5893110..f3811d5 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <plat/pm.h>
 
 #include <asm/irq.h>
 
@@ -173,6 +174,7 @@ struct pxa_i2c {
 	unsigned int		fast_mode :1;
 	unsigned int		ilcr;
 	unsigned int		iwcr;
+	struct pm_qos_request	qos_idle;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -729,7 +731,7 @@ static int i2c_pxa_pio_set_master(struct pxa_i2c *i2c)
 static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
 			       struct i2c_msg *msg, int num)
 {
-	unsigned long timeout = 500000; /* 5 seconds */
+	unsigned long timeout = 100000; /* 1 seconds */
 	int ret = 0;
 
 	ret = i2c_pxa_pio_set_master(i2c);
@@ -742,6 +744,8 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
 	i2c->msg_ptr = 0;
 	i2c->irqlogidx = 0;
 
+	pm_qos_update_request(&i2c->qos_idle, PM_QOS_CONSTRAINT);
+
 	i2c_pxa_start_message(i2c);
 
 	while (i2c->msg_num > 0 && --timeout) {
@@ -751,6 +755,7 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
 
 	i2c_pxa_stop_message(i2c);
 
+	pm_qos_update_request(&i2c->qos_idle, PM_QOS_DEFAULT_VALUE);
 	/*
 	 * We place the return code in i2c->msg_idx.
 	 */
@@ -760,6 +765,9 @@ out:
 	if (timeout == 0)
 		i2c_pxa_scream_blue_murder(i2c, "timeout");
 
+	if (ret < 0)
+		i2c_pxa_reset(i2c);
+
 	return ret;
 }
 
@@ -797,6 +805,8 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 	i2c->msg_ptr = 0;
 	i2c->irqlogidx = 0;
 
+	pm_qos_update_request(&i2c->qos_idle, PM_QOS_CONSTRAINT);
+
 	i2c_pxa_start_message(i2c);
 
 	spin_unlock_irq(&i2c->lock);
@@ -804,9 +814,11 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 	/*
 	 * The rest of the processing occurs in the interrupt handler.
 	 */
-	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
+	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 1);
 	i2c_pxa_stop_message(i2c);
 
+	pm_qos_update_request(&i2c->qos_idle, PM_QOS_DEFAULT_VALUE);
+
 	/*
 	 * We place the return code in i2c->msg_idx.
 	 */
@@ -1146,6 +1158,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	struct resource *res = NULL;
 	int ret, irq;
 
+	int pm_qos_class = PM_QOS_CPUIDLE_KEEP_DDR;
+
 	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
 	if (!i2c) {
 		ret = -ENOMEM;
@@ -1171,7 +1185,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	}
 
 	i2c->adap.owner   = THIS_MODULE;
-	i2c->adap.retries = 5;
+	i2c->adap.retries = 3;
+
+	pm_qos_add_request(&i2c->qos_idle, pm_qos_class,
+			PM_QOS_DEFAULT_VALUE);
 
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
@@ -1274,6 +1291,7 @@ eclk:
 	kfree(i2c);
 emalloc:
 	release_mem_region(res->start, resource_size(res));
+	pm_qos_remove_request(&i2c->qos_idle);
 	return ret;
 }
 
@@ -1282,6 +1300,7 @@ static int __exit i2c_pxa_remove(struct platform_device *dev)
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
 	platform_set_drvdata(dev, NULL);
+	pm_qos_remove_request(&i2c->qos_idle);
 
 	i2c_del_adapter(&i2c->adap);
 	if (!i2c->use_pio)
-- 
1.7.5.4
