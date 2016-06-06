From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC 2/2] i2c: Pass i2c_device_id to probe func when using DT ids through ACPI
Date: Mon,  6 Jun 2016 23:03:28 +0300
Message-ID: <3d3faf7ace51bb7dcf27c328e82653aa28298936.1465242308.git.leonard.crestez@intel.com>
References: <cover.1465242308.git.leonard.crestez@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1465242308.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1465242308.git.leonard.crestez@intel.com>
References: <cover.1465242308.git.leonard.crestez@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-i2c@vger.kernel.org

When devices are instatiated through devicetree the i2c_client->name is
set to the compatible string with company name stripped out. This is
then matched to the i2c_device_id table to pass the device_id to the
probe function. This id parameter is used by some device drivers to
differentiate between model numbers.

When using ACPI this id parameter is NULL and the driver usually needs
to do ACPI-specific differentiation.

This patch attempts to find a valid i2c_device_id when using ACPI with
DT-like compatible strings.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/i2c/i2c-core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3ffeb6c..c899108 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -581,17 +581,23 @@ static inline int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
 
 /* ------------------------------------------------------------------------- */
 
-static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
-						const struct i2c_client *client)
+static const struct i2c_device_id *i2c_match_id_name(const struct i2c_device_id *id,
+						     const char *id_name)
 {
 	while (id->name[0]) {
-		if (strcmp(client->name, id->name) == 0)
+		if (strcmp(id_name, id->name) == 0)
 			return id;
 		id++;
 	}
 	return NULL;
 }
 
+static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
+						const struct i2c_client *client)
+{
+	return i2c_match_id_name(id, client->name);
+}
+
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
@@ -767,6 +773,7 @@ static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
 	struct i2c_driver	*driver;
+	const struct i2c_device_id *i2c_device_id;
 	int status;
 
 	if (!client)
@@ -826,6 +833,19 @@ static int i2c_device_probe(struct device *dev)
 	if (status == -EPROBE_DEFER)
 		goto err_clear_wakeup_irq;
 
+	i2c_device_id = i2c_match_id(driver->id_table, client);
+#ifdef CONFIG_ACPI
+	if (!i2c_device_id) {
+		const char *id_name;
+		const struct of_device_id *ofid;
+
+		ofid = acpi_of_match_device(ACPI_COMPANION(&client->dev),
+					    driver->driver.of_match_table);
+		id_name = strchr(ofid->name, ',');
+		id_name = id_name ? id_name + 1 : ofid->name;
+		i2c_device_id = i2c_match_id_name(driver->id_table, id_name);
+	}
+#endif
 	status = driver->probe(client, i2c_match_id(driver->id_table, client));
 	if (status)
 		goto err_detach_pm_domain;
-- 
2.5.5
