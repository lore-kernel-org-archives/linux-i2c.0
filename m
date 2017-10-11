From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend v5 1/3] i2c: Allow overriding dev_name through board_info
Date: Wed, 11 Oct 2017 11:41:19 +0200
Message-ID: <20171011094121.6108-2-hdegoede@redhat.com>
References: <20171011094121.6108-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011094121.6108-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

For devices not instantiated through ACPI the i2c-client's device-name
gets set to <busnr>-<addr> by default, e.g. "0-0022" this means that
the device-name is dependent on the order in which the i2c-busses are
enumerated.

In some cases having a predictable constant device-name is desirable,
for example on non device-tree platforms the link between a regulator
and its consumers is specified by the platform code by setting
regulator_init_data.consumers. This array identifies the regulator's
consumers by dev_name and supply(-name). Which requires a constant
dev_name.

This commit adds a dev_name field to i2c_board_info allowing
platform code to set a contstant dev_name so that the device can
be identified by its dev_name in other platform code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-base.c | 10 ++++++++--
 include/linux/i2c.h         |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 45fafcc88b93..5cdf3b947c23 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -672,10 +672,16 @@ static void i2c_adapter_unlock_bus(struct i2c_adapter *adapter,
 }
 
 static void i2c_dev_set_name(struct i2c_adapter *adap,
-			     struct i2c_client *client)
+			     struct i2c_client *client,
+			     struct i2c_board_info const *info)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 
+	if (info && info->dev_name) {
+		dev_set_name(&client->dev, "i2c-%s", info->dev_name);
+		return;
+	}
+
 	if (adev) {
 		dev_set_name(&client->dev, "i2c-%s", acpi_dev_name(adev));
 		return;
@@ -772,7 +778,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	client->dev.fwnode = info->fwnode;
 
-	i2c_dev_set_name(adap, client);
+	i2c_dev_set_name(adap, client, info);
 
 	if (info->properties) {
 		status = device_add_properties(&client->dev, info->properties);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 701ad26fa6b4..d3655cfe9a3e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -310,6 +310,7 @@ static inline bool i2c_detect_slave_mode(struct device *dev) { return false; }
  * @type: chip type, to initialize i2c_client.name
  * @flags: to initialize i2c_client.flags
  * @addr: stored in i2c_client.addr
+ * @dev_name: Overrides the default <busnr>-<addr> dev_name if set
  * @platform_data: stored in i2c_client.dev.platform_data
  * @archdata: copied into i2c_client.dev.archdata
  * @of_node: pointer to OpenFirmware device node
@@ -334,6 +335,7 @@ struct i2c_board_info {
 	char		type[I2C_NAME_SIZE];
 	unsigned short	flags;
 	unsigned short	addr;
+	const char	*dev_name;
 	void		*platform_data;
 	struct dev_archdata	*archdata;
 	struct device_node *of_node;
-- 
2.14.2
