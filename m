From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 1/5] i2c: Allow driver to manage the device's power state during probe
Date: Thu,  9 Jan 2020 17:45:25 +0200
Message-ID: <20200109154529.19484-2-sakari.ailus@linux.intel.com>
References: <20200109154529.19484-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200109154529.19484-1-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rajmohan.mani@intel.com, Tomasz Figa <tfiga@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Enable drivers to tell ACPI that there's no need to power on a device for
probe. Drivers should still perform this by themselves if there's a need
to. In some cases powering on the device during probe is undesirable, and
this change enables a driver to choose what fits best for it.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/i2c/i2c-core-base.c | 15 ++++++++++++---
 include/linux/i2c.h         |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9f8dcd3f83850..7bf1699c9044d 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -303,6 +303,14 @@ static int i2c_smbus_host_notify_to_irq(const struct i2c_client *client)
 	return irq > 0 ? irq : -ENXIO;
 }
 
+static bool probe_low_power(struct device *dev)
+{
+	struct i2c_driver *driver = to_i2c_driver(dev->driver);
+
+	return driver->probe_low_power &&
+		device_property_present(dev, "probe-low-power");
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
@@ -375,7 +383,8 @@ static int i2c_device_probe(struct device *dev)
 	if (status < 0)
 		goto err_clear_wakeup_irq;
 
-	status = dev_pm_domain_attach(&client->dev, true);
+	status = dev_pm_domain_attach(&client->dev,
+				      !probe_low_power(&client->dev));
 	if (status)
 		goto err_clear_wakeup_irq;
 
@@ -397,7 +406,7 @@ static int i2c_device_probe(struct device *dev)
 	return 0;
 
 err_detach_pm_domain:
-	dev_pm_domain_detach(&client->dev, true);
+	dev_pm_domain_detach(&client->dev, !probe_low_power(&client->dev));
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
@@ -419,7 +428,7 @@ static int i2c_device_remove(struct device *dev)
 		status = driver->remove(client);
 	}
 
-	dev_pm_domain_detach(&client->dev, true);
+	dev_pm_domain_detach(&client->dev, !probe_low_power(&client->dev));
 
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 582ef05ec07ed..6d0d6af393c56 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -229,6 +229,8 @@ enum i2c_alert_protocol {
  * @address_list: The I2C addresses to probe (for detect)
  * @clients: List of detected clients we created (for i2c-core use only)
  * @disable_i2c_core_irq_mapping: Tell the i2c-core to not do irq-mapping
+ * @probe_low_power: Let the driver manage the device's power state
+ *		     during probe and remove.
  *
  * The driver.owner field should be set to the module owner of this driver.
  * The driver.name field should be set to the name of this driver.
@@ -289,6 +291,7 @@ struct i2c_driver {
 	struct list_head clients;
 
 	bool disable_i2c_core_irq_mapping;
+	bool probe_low_power;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-- 
2.20.1
