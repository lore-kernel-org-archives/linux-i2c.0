From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Forcing an adapter onto a bus
Date: Thu, 3 Jan 2008 12:09:27 -0500
Message-ID: <9e4733910801030909v70ddc068xfb658bf15c5f8924@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If adapter->dev.parent is NULL the current i2c code forces the adapter
onto the platform bus.  But this may not be what you want on the
powerpc since it mainly uses of_platform_bus.  What about changing
this to an error condition and fixing the drivers that don't set it
right?

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fce06fd..d0bb1e1 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -346,6 +346,11 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	struct list_head   *item;
 	struct i2c_driver  *driver;

+	if (adap->dev.parent == NULL) {
+		printk(KERN_ERR "I2C adapter driver [%s] forgot to specify "
+			 "physical device\n", adap->name);
+		return -ENODEV;
+	}
 	mutex_init(&adap->bus_lock);
 	mutex_init(&adap->clist_lock);
 	INIT_LIST_HEAD(&adap->clients);
@@ -357,11 +362,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	 * If the parent pointer is not set up,
 	 * we add this adapter to the host bus.
 	 */
-	if (adap->dev.parent == NULL) {
-		adap->dev.parent = &platform_bus;
-		pr_debug("I2C adapter driver [%s] forgot to specify "
-			 "physical device\n", adap->name);
-	}
 	sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
 	adap->dev.release = &i2c_adapter_dev_release;
 	adap->dev.class = &i2c_adapter_class;

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
