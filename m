From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 5/5] hwmon: (lm90) Add SMBus alert support
Date: Sat, 13 Feb 2010 23:11:16 +0100
Message-ID: <20100213231116.1d3ad806@hyperion.delvare>
References: <20100213230438.31fd0fd7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213230438.31fd0fd7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Tested successfully with an ADM1032 chip on its evaluation board. It
should work fine with all other chips as well.

At this point this is more of a proof-of-concept, we don't do anything
terribly useful on SMBus alert: we simply log the event. But this could
later evolve into libsensors signaling so that user-space applications
can take an appropriate action.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/hwmon/lm90 |   12 ++++++++
 drivers/hwmon/lm90.c     |   63 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

--- linux-2.6.33-rc8.orig/Documentation/hwmon/lm90	2010-02-13 16:24:06.000000000 +0100
+++ linux-2.6.33-rc8/Documentation/hwmon/lm90	2010-02-13 16:24:41.000000000 +0100
@@ -173,6 +173,18 @@ The lm90 driver will not update its valu
 other second; reading them more often will do no harm, but will return
 'old' values.
 
+SMBus Alert Support
+-------------------
+
+This driver has basic support for SMBus alert. When an alert is received,
+the status register is read and the faulty temperature channel is logged.
+
+The Analog Devices chips (ADM1032 and ADT7461) do not implement the SMBus
+alert protocol properly so additional care is needed: the ALERT output is
+disabled when an alert is received, and is re-enabled only when the alarm
+is gone. Otherwise the chip would block alerts from other chips in the bus
+as long as the alarm is active.
+
 PEC Support
 -----------
 
--- linux-2.6.33-rc8.orig/drivers/hwmon/lm90.c	2010-02-13 16:24:17.000000000 +0100
+++ linux-2.6.33-rc8/drivers/hwmon/lm90.c	2010-02-13 15:50:53.000000000 +0100
@@ -152,6 +152,7 @@ static int lm90_detect(struct i2c_client
 static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
 static void lm90_init_client(struct i2c_client *client);
+static void lm90_alert(struct i2c_client *client, unsigned int flag);
 static int lm90_remove(struct i2c_client *client);
 static struct lm90_data *lm90_update_device(struct device *dev);
 
@@ -186,6 +187,7 @@ static struct i2c_driver lm90_driver = {
 	},
 	.probe		= lm90_probe,
 	.remove		= lm90_remove,
+	.alert		= lm90_alert,
 	.id_table	= lm90_id,
 	.detect		= lm90_detect,
 	.address_list	= normal_i2c,
@@ -204,6 +206,7 @@ struct lm90_data {
 	int flags;
 
 	u8 config_orig;		/* Original configuration register value */
+	u8 alert_alarms;	/* Which alarm bits trigger ALERT# */
 
 	/* registers values */
 	s8 temp8[4];	/* 0: local low limit
@@ -806,6 +809,19 @@ static int lm90_probe(struct i2c_client
 			new_client->flags &= ~I2C_CLIENT_PEC;
 	}
 
+	/* Different devices have different alarm bits triggering the
+	 * ALERT# output */
+	switch (data->kind) {
+	case lm90:
+	case lm99:
+	case lm86:
+		data->alert_alarms = 0x7b;
+		break;
+	default:
+		data->alert_alarms = 0x7c;
+		break;
+	}
+
 	/* Initialize the LM90 chip */
 	lm90_init_client(new_client);
 
@@ -895,6 +911,38 @@ static int lm90_remove(struct i2c_client
 	return 0;
 }
 
+static void lm90_alert(struct i2c_client *client, unsigned int flag)
+{
+	struct lm90_data *data = i2c_get_clientdata(client);
+	u8 config, alarms;
+
+	lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
+	if ((alarms & 0x7f) == 0) {
+		dev_info(&client->dev, "Everything OK\n");
+	} else {
+		if (alarms & 0x61)
+			dev_warn(&client->dev,
+				 "temp%d out of range, please check!\n", 1);
+		if (alarms & 0x1a)
+			dev_warn(&client->dev,
+				 "temp%d out of range, please check!\n", 2);
+		if (alarms & 0x04)
+			dev_warn(&client->dev,
+				 "temp%d diode open, please check!\n", 2);
+
+		/* Disable ALERT# output, because these chips don't implement
+		  SMBus alert correctly; they should only hold the alert line
+		  low briefly. */
+		if ((data->kind == adm1032 || data->kind == adt7461)
+		 && (alarms & data->alert_alarms)) {
+			dev_dbg(&client->dev, "Disabling ALERT#\n");
+			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
+			i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
+						  config | 0x80);
+		}
+	}
+}
+
 static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
 {
 	int err;
@@ -982,6 +1030,21 @@ static struct lm90_data *lm90_update_dev
 		}
 		lm90_read_reg(client, LM90_REG_R_STATUS, &data->alarms);
 
+		/* Re-enable ALERT# output if it was originally enabled and
+		 * relevant alarms are all clear */
+		if ((data->config_orig & 0x80) == 0
+		 && (data->alarms & data->alert_alarms) == 0) {
+			u8 config;
+
+			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
+			if (config & 0x80) {
+				dev_dbg(&client->dev, "Re-enabling ALERT#\n");
+				i2c_smbus_write_byte_data(client,
+							  LM90_REG_W_CONFIG1,
+							  config & ~0x80);
+			}
+		}
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}

-- 
Jean Delvare
