From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch v0 1/3] i2c-smbus: Add poll interface for smbus alert
Date: Wed, 26 Mar 2014 17:42:10 -0700
Message-ID: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The current i2c smbus alert module depends on smbus alert mechanism
supported by underlying bus drivers. By specifications, these alerts
can be polled if there is no hardware support.
Currently multiple drivers who needs smbus alerts are creating
a new i2c dummy device with address 0x0C (ARA register), by luck
they don't co-exist. Otherwise i2c device creation will fail.
Added a poll interface, so that all these driver can call a common
interface to poll. Even if they polli, all drivers bound to an
adapater will be notified by their alert callback if ARA register
read is successful.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-smbus.c   | 23 +++++++++++++++++++++++
 include/linux/i2c-smbus.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index fc99f0d..e274f20 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -72,6 +72,29 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	return -EBUSY;
 }
 
+int i2c_smbus_ara_poll(const struct i2c_client *client)
+{
+	union i2c_smbus_data data;
+	int status;
+	struct alert_data alert_data;
+
+	status = i2c_smbus_xfer(client->adapter, 0x0C, 0,
+				I2C_SMBUS_READ, 0,
+				I2C_SMBUS_BYTE, &data);
+	if (status < 0)
+		return status;
+
+	alert_data.flag = data.byte & 1;
+	alert_data.addr = data.byte >> 1;
+
+	/* Notify driver for the device which issued the alert */
+	device_for_each_child(&client->adapter->dev, &alert_data,
+				smbus_do_alert);
+
+	return data.byte;
+}
+EXPORT_SYMBOL_GPL(i2c_smbus_ara_poll);
+
 /*
  * The alert IRQ handler needs to hand work off to a task which can issue
  * SMBus calls, because those sleeping calls can't be made in IRQ context.
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 8f1b086..f70755d 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -48,4 +48,7 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 					 struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
+/* Interface to poll smbus alert */
+int i2c_smbus_ara_poll(const struct i2c_client *client);
+
 #endif /* _LINUX_I2C_SMBUS_H */
-- 
1.8.3.2
