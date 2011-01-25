From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH 3/3] MID I2C runtime PM
Date: Tue, 25 Jan 2011 14:22:20 +0000
Message-ID: <20110125142131.9472.27410.stgit@bob.linux.org.uk>
References: <20110125142040.9472.88734.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110125142040.9472.88734.stgit-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Bin Yang <bin.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

The MID I2C driver does now allow runtime pm by default it goes into
suspend after every access. This is not efficient for continual I2C access.

This patch allows auto suspend by default. It add a delay to the suspend which
keeps I2C active for at least 500ms after every access. If a device driver
accesses I2C frequently, it will not go to suspend and will keep high
performance. After a long time idle, it will go to suspend auto.

Signed-off-by: Bin Yang <bin.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
[Ported to upstream driver version]
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/i2c-intel-mid.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)


diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index 2dba2e3..3975736 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -753,7 +753,7 @@ static int intel_mid_i2c_xfer(struct i2c_adapter *adap,
 	if (num == 0)
 		return 0;
 
-	pm_runtime_get(i2c->dev);
+	pm_runtime_get_sync(i2c->dev);
 
 	mutex_lock(&i2c->lock);
 	dev_dbg(&adap->dev, "intel_mid_i2c_xfer, process %d msg(s)\n", num);
@@ -763,9 +763,8 @@ static int intel_mid_i2c_xfer(struct i2c_adapter *adap,
 	if (i2c->status != STATUS_IDLE) {
 		dev_err(&adap->dev, "Adapter %d in transfer/standby\n",
 								adap->nr);
-		mutex_unlock(&i2c->lock);
-		pm_runtime_put(i2c->dev);
-		return -1;
+		err = -EIO;
+		goto err_1;
 	}
 
 
@@ -773,16 +772,14 @@ static int intel_mid_i2c_xfer(struct i2c_adapter *adap,
 		/* Message address equal? */
 		if (unlikely(intel_mid_i2c_address_neq(&pmsg[0], &pmsg[i]))) {
 			dev_err(&adap->dev, "Invalid address in msg[%d]\n", i);
-			mutex_unlock(&i2c->lock);
-			pm_runtime_put(i2c->dev);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_1;
 		}
 	}
 
 	if (intel_mid_i2c_setup(adap, pmsg)) {
-		mutex_unlock(&i2c->lock);
-		pm_runtime_put(i2c->dev);
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_1;
 	}
 
 	for (i = 0; i < num; i++) {
@@ -808,6 +805,8 @@ static int intel_mid_i2c_xfer(struct i2c_adapter *adap,
 	readl(i2c->base + IC_CLR_INTR);
 
 	i2c->status = STATUS_IDLE;
+
+err_1:
 	mutex_unlock(&i2c->lock);
 	pm_runtime_put(i2c->dev);
 
@@ -865,6 +864,14 @@ static int intel_mid_i2c_runtime_resume(struct device *dev)
 	return err;
 }
 
+static int mrst_i2c_runtime_idle(struct device *dev)
+{
+	int err = pm_schedule_suspend(dev, 500);
+	if(err != 0)
+		return 0;
+	return -EBUSY;
+}
+
 static void i2c_isr_read(struct intel_mid_i2c_private *i2c)
 {
 	struct i2c_msg *msg = i2c->msg;
@@ -957,6 +964,7 @@ static struct i2c_algorithm intel_mid_i2c_algorithm = {
 static const struct dev_pm_ops intel_mid_i2c_pm_ops = {
 	.runtime_suspend = intel_mid_i2c_runtime_suspend,
 	.runtime_resume = intel_mid_i2c_runtime_resume,
+	.runtime_idle = mrst_i2c_runtime_idle,
 };
 
 /**
@@ -1094,7 +1102,10 @@ static int __devinit intel_mid_i2c_probe(struct pci_dev *dev,
 		(mrst->platform == MOORESTOWN) ? "Moorestown" : "Medfield",
 		busnum);
 
+	pm_runtime_set_active(&dev->dev);
 	pm_runtime_enable(&dev->dev);
+	pm_runtime_allow(&dev->dev);
+
 	return 0;
 
 fail3:
@@ -1113,10 +1124,11 @@ exit:
 static void __devexit intel_mid_i2c_remove(struct pci_dev *dev)
 {
 	struct intel_mid_i2c_private *mrst = pci_get_drvdata(dev);
+	pm_runtime_forbid(&dev->dev);
+	pm_runtime_disable(&dev->dev);
 	intel_mid_i2c_disable(&mrst->adap);
 	if (i2c_del_adapter(&mrst->adap))
 		dev_err(&dev->dev, "Failed to delete i2c adapter");
-
 	free_irq(dev->irq, mrst);
 	pci_set_drvdata(dev, NULL);
 	iounmap(mrst->base);
