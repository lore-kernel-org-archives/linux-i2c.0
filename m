From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/3] i2c: add a protocol parameter to the alert callback
Date: Thu,  9 Jul 2015 13:30:50 -0400
Message-ID: <1436463052-6944-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1436463052-6944-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436463052-6944-1-git-send-email-benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

.alert() is meant to be generic, but there is currently no way
for the device driver to know which protocol generated the alert.
Add a parameter in .alert() to help the device driver to understand
what is given in data.

This patch is required to have the support of SMBus Host Notify protocol
through .alert().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

New in v2

 drivers/char/ipmi/ipmi_ssif.c | 6 +++++-
 drivers/i2c/i2c-smbus.c       | 3 ++-
 include/linux/i2c.h           | 7 ++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 207689c..1d4cece 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -567,12 +567,16 @@ static void retry_timeout(unsigned long data)
 }
 
 
-static void ssif_alert(struct i2c_client *client, unsigned int data)
+static void ssif_alert(struct i2c_client *client,
+		       enum i2c_alert_protocol protocol, unsigned int data)
 {
 	struct ssif_info *ssif_info = i2c_get_clientdata(client);
 	unsigned long oflags, *flags;
 	bool do_get = false;
 
+	if (protocol != I2C_PROTOCOL_SMBUS_ALERT)
+		return;
+
 	ssif_inc_stat(ssif_info, alerts);
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 94765a8..abad351 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -56,7 +56,8 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	if (client->dev.driver) {
 		driver = to_i2c_driver(client->dev.driver);
 		if (driver->alert)
-			driver->alert(client, data->flag);
+			driver->alert(client, I2C_PROTOCOL_SMBUS_ALERT,
+				      data->flag);
 		else
 			dev_warn(&client->dev, "no driver alert()!\n");
 	} else
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e83a738..6764734 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -123,6 +123,10 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 					  const u8 *values);
 #endif /* I2C */
 
+enum i2c_alert_protocol {
+	I2C_PROTOCOL_SMBUS_ALERT,
+};
+
 /**
  * struct i2c_driver - represent an I2C device driver
  * @class: What kind of i2c device we instantiate (for detect)
@@ -178,7 +182,8 @@ struct i2c_driver {
 	 * For the SMBus alert protocol, there is a single bit of data passed
 	 * as the alert response's low bit ("event flag").
 	 */
-	void (*alert)(struct i2c_client *, unsigned int data);
+	void (*alert)(struct i2c_client *, enum i2c_alert_protocol protocol,
+		      unsigned int data);
 
 	/* a ioctl like command that can be used to perform specific functions
 	 * with the device.
-- 
2.4.3
