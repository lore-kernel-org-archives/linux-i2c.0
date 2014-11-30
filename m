From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 2/2] i2c: Remove support for legacy PM
Date: Sun, 30 Nov 2014 17:52:32 +0100
Message-ID: <1417366352-22356-2-git-send-email-lars@metafoo.de>
References: <1417366352-22356-1-git-send-email-lars@metafoo.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417366352-22356-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There haven't been any I2C driver that use the legacy suspend/resume
callbacks for a while now and new drivers are supposed to use PM ops. So
remove support for legacy suspend/resume for I2C drivers.

Since there aren't any special bus specific things to do during
suspend/resume and since the PM core will automatically fallback directly to
using the device's PM ops if no bus PM ops are specified there is no need to
have any I2C bus PM ops.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 118 -------------------------------------------------
 include/linux/i2c.h    |   4 --
 2 files changed, 122 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3105bd2..f23c03b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -695,101 +695,6 @@ static void i2c_device_shutdown(struct device *dev)
 		driver->shutdown(client);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int i2c_legacy_suspend(struct device *dev, pm_message_t mesg)
-{
-	struct i2c_client *client = i2c_verify_client(dev);
-	struct i2c_driver *driver;
-
-	if (!client || !dev->driver)
-		return 0;
-	driver = to_i2c_driver(dev->driver);
-	if (!driver->suspend)
-		return 0;
-	return driver->suspend(client, mesg);
-}
-
-static int i2c_legacy_resume(struct device *dev)
-{
-	struct i2c_client *client = i2c_verify_client(dev);
-	struct i2c_driver *driver;
-
-	if (!client || !dev->driver)
-		return 0;
-	driver = to_i2c_driver(dev->driver);
-	if (!driver->resume)
-		return 0;
-	return driver->resume(client);
-}
-
-static int i2c_device_pm_suspend(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_suspend(dev);
-	else
-		return i2c_legacy_suspend(dev, PMSG_SUSPEND);
-}
-
-static int i2c_device_pm_resume(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_resume(dev);
-	else
-		return i2c_legacy_resume(dev);
-}
-
-static int i2c_device_pm_freeze(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_freeze(dev);
-	else
-		return i2c_legacy_suspend(dev, PMSG_FREEZE);
-}
-
-static int i2c_device_pm_thaw(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_thaw(dev);
-	else
-		return i2c_legacy_resume(dev);
-}
-
-static int i2c_device_pm_poweroff(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_poweroff(dev);
-	else
-		return i2c_legacy_suspend(dev, PMSG_HIBERNATE);
-}
-
-static int i2c_device_pm_restore(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_restore(dev);
-	else
-		return i2c_legacy_resume(dev);
-}
-#else /* !CONFIG_PM_SLEEP */
-#define i2c_device_pm_suspend	NULL
-#define i2c_device_pm_resume	NULL
-#define i2c_device_pm_freeze	NULL
-#define i2c_device_pm_thaw	NULL
-#define i2c_device_pm_poweroff	NULL
-#define i2c_device_pm_restore	NULL
-#endif /* !CONFIG_PM_SLEEP */
-
 static void i2c_client_dev_release(struct device *dev)
 {
 	kfree(to_i2c_client(dev));
@@ -834,27 +739,12 @@ static const struct attribute_group *i2c_dev_attr_groups[] = {
 	NULL
 };
 
-static const struct dev_pm_ops i2c_device_pm_ops = {
-	.suspend = i2c_device_pm_suspend,
-	.resume = i2c_device_pm_resume,
-	.freeze = i2c_device_pm_freeze,
-	.thaw = i2c_device_pm_thaw,
-	.poweroff = i2c_device_pm_poweroff,
-	.restore = i2c_device_pm_restore,
-	SET_RUNTIME_PM_OPS(
-		pm_generic_runtime_suspend,
-		pm_generic_runtime_resume,
-		NULL
-	)
-};
-
 struct bus_type i2c_bus_type = {
 	.name		= "i2c",
 	.match		= i2c_device_match,
 	.probe		= i2c_device_probe,
 	.remove		= i2c_device_remove,
 	.shutdown	= i2c_device_shutdown,
-	.pm		= &i2c_device_pm_ops,
 };
 EXPORT_SYMBOL_GPL(i2c_bus_type);
 
@@ -1850,14 +1740,6 @@ int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
 	if (res)
 		return res;
 
-	/* Drivers should switch to dev_pm_ops instead. */
-	if (driver->suspend)
-		pr_warn("i2c-core: driver [%s] using legacy suspend method\n",
-			driver->driver.name);
-	if (driver->resume)
-		pr_warn("i2c-core: driver [%s] using legacy resume method\n",
-			driver->driver.name);
-
 	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);
 
 	INIT_LIST_HEAD(&driver->clients);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b556e0a..d0b66cc 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -128,8 +128,6 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
  * @probe: Callback for device binding
  * @remove: Callback for device unbinding
  * @shutdown: Callback for device shutdown
- * @suspend: Callback for device suspend
- * @resume: Callback for device resume
  * @alert: Alert callback, for example for the SMBus alert protocol
  * @command: Callback for bus-wide signaling (optional)
  * @driver: Device driver model driver
@@ -172,8 +170,6 @@ struct i2c_driver {
 
 	/* driver model interfaces that don't relate to enumeration  */
 	void (*shutdown)(struct i2c_client *);
-	int (*suspend)(struct i2c_client *, pm_message_t mesg);
-	int (*resume)(struct i2c_client *);
 
 	/* Alert callback, for example for the SMBus alert protocol.
 	 * The format and meaning of the data value depends on the protocol.
-- 
1.8.0
