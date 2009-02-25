From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Adapter timeout is in jiffies [TEST RESEND]
Date: Wed, 25 Feb 2009 14:48:50 +0100
Message-ID: <20090225144850.6d1249bf@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Adapter timeout is in jiffies

i2c_adapter.timeout is in jiffies. Fix all drivers which thought
otherwise. It didn't really matter as long as the value was only used
inside the driver, but soon i2c-core will use it too so it must have
the proper unit.

Note: for the i2c-mpc driver, this fixes a bug in polling mode.
Timeout would trigger after 1 jiffy, which is most probably not what
the author wanted.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Cc: Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Cc: Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-ibm_iic.c |    6 +++---
 drivers/i2c/busses/i2c-iop3xx.c  |    2 +-
 drivers/i2c/busses/i2c-mpc.c     |    4 ++--
 drivers/i2c/busses/i2c-mv64xxx.c |    7 +++----
 drivers/i2c/busses/i2c-pca-isa.c |    2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

--- linux-2.6.29-rc5.orig/drivers/i2c/busses/i2c-mpc.c	2009-02-22 14:29:17.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/busses/i2c-mpc.c	2009-02-22 14:34:56.000000000 +0100
@@ -116,7 +116,7 @@ static int i2c_wait(struct mpc_i2c *i2c,
 	} else {
 		/* Interrupt mode */
 		result = wait_event_interruptible_timeout(i2c->queue,
-			(i2c->interrupt & CSR_MIF), timeout * HZ);
+			(i2c->interrupt & CSR_MIF), timeout);
 
 		if (unlikely(result < 0)) {
 			pr_debug("I2C: wait interrupted\n");
@@ -311,7 +311,7 @@ static struct i2c_adapter mpc_ops = {
 	.owner = THIS_MODULE,
 	.name = "MPC adapter",
 	.algo = &mpc_algo,
-	.timeout = 1,
+	.timeout = HZ,
 };
 
 static int __devinit fsl_i2c_probe(struct of_device *op, const struct of_device_id *match)
--- linux-2.6.29-rc5.orig/drivers/i2c/busses/i2c-mv64xxx.c	2009-02-22 14:29:17.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/busses/i2c-mv64xxx.c	2009-02-22 14:29:56.000000000 +0100
@@ -358,7 +358,7 @@ mv64xxx_i2c_wait_for_completion(struct m
 	char		abort = 0;
 
 	time_left = wait_event_interruptible_timeout(drv_data->waitq,
-		!drv_data->block, msecs_to_jiffies(drv_data->adapter.timeout));
+		!drv_data->block, drv_data->adapter.timeout);
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 	if (!time_left) { /* Timed out */
@@ -374,8 +374,7 @@ mv64xxx_i2c_wait_for_completion(struct m
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 
 		time_left = wait_event_timeout(drv_data->waitq,
-			!drv_data->block,
-			msecs_to_jiffies(drv_data->adapter.timeout));
+			!drv_data->block, drv_data->adapter.timeout);
 
 		if ((time_left <= 0) && drv_data->block) {
 			drv_data->state = MV64XXX_I2C_STATE_IDLE;
@@ -530,7 +529,7 @@ mv64xxx_i2c_probe(struct platform_device
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
 	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
-	drv_data->adapter.timeout = pdata->timeout;
+	drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
 	drv_data->adapter.nr = pd->id;
 	platform_set_drvdata(pd, drv_data);
 	i2c_set_adapdata(&drv_data->adapter, drv_data);
--- linux-2.6.29-rc5.orig/drivers/i2c/busses/i2c-ibm_iic.c	2009-02-22 14:29:17.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/busses/i2c-ibm_iic.c	2009-02-22 14:43:31.000000000 +0100
@@ -415,7 +415,7 @@ static int iic_wait_for_tc(struct ibm_ii
 	if (dev->irq >= 0){
 		/* Interrupt mode */
 		ret = wait_event_interruptible_timeout(dev->wq,
-			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout * HZ);
+			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout);
 
 		if (unlikely(ret < 0))
 			DBG("%d: wait interrupted\n", dev->idx);
@@ -426,7 +426,7 @@ static int iic_wait_for_tc(struct ibm_ii
 	}
 	else {
 		/* Polling mode */
-		unsigned long x = jiffies + dev->adap.timeout * HZ;
+		unsigned long x = jiffies + dev->adap.timeout;
 
 		while (in_8(&iic->sts) & STS_PT){
 			if (unlikely(time_after(jiffies, x))){
@@ -748,7 +748,7 @@ static int __devinit iic_probe(struct of
 	i2c_set_adapdata(adap, dev);
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo = &iic_algo;
-	adap->timeout = 1;
+	adap->timeout = HZ;
 
 	ret = i2c_add_adapter(adap);
 	if (ret  < 0) {
--- linux-2.6.29-rc5.orig/drivers/i2c/busses/i2c-iop3xx.c	2009-02-22 14:29:17.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/busses/i2c-iop3xx.c	2009-02-22 14:47:58.000000000 +0100
@@ -488,7 +488,7 @@ iop3xx_i2c_probe(struct platform_device
 	/*
 	 * Default values...should these come in from board code?
 	 */
-	new_adapter->timeout = 100;	
+	new_adapter->timeout = HZ;
 	new_adapter->algo = &iop3xx_i2c_algo;
 
 	init_waitqueue_head(&adapter_data->waitq);
--- linux-2.6.29-rc5.orig/drivers/i2c/busses/i2c-pca-isa.c	2009-02-22 14:29:17.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/busses/i2c-pca-isa.c	2009-02-22 14:48:34.000000000 +0100
@@ -103,7 +103,7 @@ static struct i2c_adapter pca_isa_ops =
 	.owner          = THIS_MODULE,
 	.algo_data	= &pca_isa_data,
 	.name		= "PCA9564 ISA Adapter",
-	.timeout	= 100,
+	.timeout	= HZ,
 };
 
 static int __devinit pca_isa_match(struct device *dev, unsigned int id)


-- 
Jean Delvare
