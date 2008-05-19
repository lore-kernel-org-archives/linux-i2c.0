From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] tuner: Do not alter i2c_client.name
Date: Mon, 19 May 2008 20:48:34 +0200
Message-ID: <20080519204834.223ff5d6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>

The tuner driver used to change i2c_client.name for its own needs, but
it really shouldn't, as this field is used by i2c-core to do the
device/driver matching. So, create and use a separate field for the
tuner driver needs.

Signed-off-by: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
This patch will go in 2.6.26.

 drivers/media/video/tuner-core.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

--- linux-2.6.26-rc3.orig/drivers/media/video/tuner-core.c	2008-05-19 09:18:59.000000000 +0200
+++ linux-2.6.26-rc3/drivers/media/video/tuner-core.c	2008-05-19 20:35:13.000000000 +0200
@@ -92,6 +92,7 @@ struct tuner {
 	unsigned int        type; /* chip type id */
 	unsigned int        config;
 	int (*tuner_callback) (void *dev, int command, int arg);
+	const char          *name;
 };
 
 /* standard i2c insmod options */
@@ -330,13 +331,13 @@ static void tuner_i2c_address_check(stru
 	tuner_warn("Support for tuners in i2c address range 0x64 thru 0x6f\n");
 	tuner_warn("will soon be dropped. This message indicates that your\n");
 	tuner_warn("hardware has a %s tuner at i2c address 0x%02x.\n",
-		   t->i2c->name, t->i2c->addr);
+		   t->name, t->i2c->addr);
 	tuner_warn("To ensure continued support for your device, please\n");
 	tuner_warn("send a copy of this message, along with full dmesg\n");
 	tuner_warn("output to v4l-dvb-maintainer-dJidKbW2IEtAfugRpC6u6w@public.gmane.org\n");
 	tuner_warn("Please use subject line: \"obsolete tuner i2c address.\"\n");
 	tuner_warn("driver: %s, addr: 0x%02x, type: %d (%s)\n",
-		   t->i2c->adapter->name, t->i2c->addr, t->type, t->i2c->name);
+		   t->i2c->adapter->name, t->i2c->addr, t->type, t->name);
 	tuner_warn("====================== WARNING! ======================\n");
 }
 
@@ -470,19 +471,17 @@ static void set_type(struct i2c_client *
 	if ((NULL == analog_ops->set_params) &&
 	    (fe_tuner_ops->set_analog_params)) {
 
-		strlcpy(t->i2c->name, fe_tuner_ops->info.name,
-			sizeof(t->i2c->name));
+		t->name = fe_tuner_ops->info.name;
 
 		t->fe.analog_demod_priv = t;
 		memcpy(analog_ops, &tuner_core_ops,
 		       sizeof(struct analog_demod_ops));
 
 	} else {
-		strlcpy(t->i2c->name, analog_ops->info.name,
-			sizeof(t->i2c->name));
+		t->name = analog_ops->info.name;
 	}
 
-	tuner_dbg("type set to %s\n", t->i2c->name);
+	tuner_dbg("type set to %s\n", t->name);
 
 	if (t->mode_mask == T_UNINITIALIZED)
 		t->mode_mask = new_mode_mask;
@@ -1115,6 +1114,7 @@ static int tuner_probe(struct i2c_client
 	if (NULL == t)
 		return -ENOMEM;
 	t->i2c = client;
+	t->name = "(tuner unset)";
 	i2c_set_clientdata(client, t);
 	t->type = UNSET;
 	t->audmode = V4L2_TUNER_MODE_STEREO;
@@ -1272,12 +1272,6 @@ static int tuner_remove(struct i2c_clien
 
 	list_del(&t->list);
 	kfree(t);
-
-	/* The probing code has overwritten the device name, restore it so
-	   that reloading the driver will work. Ideally the device name
-	   should not be overwritten in the first place, but for now that
-	   will do. */
-	strlcpy(client->name, "tuner", I2C_NAME_SIZE);
 	return 0;
 }
 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
