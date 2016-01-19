From: minyard@acm.org
Subject: [PATCH 3/3] i2c-smbus: Allow parms to be passed in from sysfs
 new_device
Date: Tue, 19 Jan 2016 11:14:14 -0600
Message-ID: <1453223654-20724-4-git-send-email-minyard@acm.org>
References: <1453223654-20724-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173023pub.verizon.net ([206.46.173.23]:42166 "EHLO
	vms173023pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652AbcASROb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 12:14:31 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173023.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O1700FOMMJS0170@vms173023.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:14:17 -0600 (CST)
In-reply-to: <1453223654-20724-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

This allows "irq=<num>" and "edge" to be passed in to the i2c new_device
after the name and i2c address.  This way the alert can be configured
without having to have platform data.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/i2c-smbus.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index cecd423..a3b7781 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
 #include <linux/slab.h>
+#include <linux/ctype.h>
 
 struct i2c_smbus_alert {
 	unsigned int		alert_edge_triggered:1;
@@ -123,15 +124,86 @@ static irqreturn_t smbalert_irq(int irq, void *d)
 	return IRQ_HANDLED;
 }
 
+static struct i2c_smbus_alert_setup *smbalert_parse_parms(struct device *dev,
+		const char *parms,
+		struct i2c_smbus_alert_setup *data)
+{
+	int rv;
+	char end;
+
+	if (!parms)
+		return NULL;
+
+	data->alert_edge_triggered = false;
+	while (*parms) {
+		const char *next = parms;
+		const char *val;
+		int parmlen;
+
+		while (*next && !isspace(*next) && *next != '=')
+			next++;
+
+		parmlen = next - parms;
+
+		if (*next == '=') {
+			next++;
+			val = next;
+			while (*next && !isspace(*next))
+				next++;
+		} else {
+			val = NULL;
+		}
+
+		if (strncmp(parms, "irq", parmlen) == 0) {
+			if (!val) {
+				dev_err(dev, "no irq parm value given\n");
+				return NULL;
+			}
+			rv = sscanf(val, "%d%c", &data->irq, &end);
+			if ((rv < 1) || ((rv > 1) && !isspace(end))) {
+				dev_err(dev, "Invalid irq parm: %s\n", val);
+				return NULL;
+			}
+		} else if (strncmp(parms, "edge", parmlen) == 0) {
+			if (val) {
+				dev_err(dev, "Value given with edge parm: %s\n",
+					val);
+				return NULL;
+			}
+			data->alert_edge_triggered = true;
+		} else {
+			dev_err(dev, "Invalid parameter: %s\n", parms);
+			return NULL;
+		}
+
+		while (*next && isspace(*next))
+			next++;
+		parms = next;
+	}
+
+	return data;
+}
+
 /* Setup SMBALERT# infrastructure */
 static int smbalert_probe(struct i2c_client *ara,
 			  const struct i2c_device_id *id)
 {
 	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
+	struct i2c_smbus_alert_setup dummy_setup;
 	struct i2c_smbus_alert *alert;
 	struct i2c_adapter *adapter = ara->adapter;
 	int res;
 
+	if (ara->parms)
+		/* Came in through sysfs. */
+		setup = smbalert_parse_parms(&ara->dev, ara->parms,
+					     &dummy_setup);
+
+	if (!setup) {
+		dev_err(&ara->dev, "SMBus alert without setup\n");
+		return -ENODEV;
+	}
+
 	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
 			     GFP_KERNEL);
 	if (!alert)
-- 
2.5.0
