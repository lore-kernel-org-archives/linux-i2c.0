From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv6 06/11] i2c: Provide a temporary .probe_new() call-back type
Date: Tue, 25 Oct 2016 17:41:50 +0100
Message-ID: <1477413715-22894-7-git-send-email-kieran@bingham.xyz>
References: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

This will aid the seamless removal of the current probe()'s, more
commonly unused than used second parameter.  Most I2C drivers can
simply switch over to the new interface, others which have DT
support can use its own matching instead and others can call
i2c_match_id() themselves.  This brings I2C's device probe method
into line with other similar interfaces in the kernel and prevents
the requirement to pass an i2c_device_id table.

Suggested-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
[Kieran: fix rebase conflicts and adapt for dev_pm_domain_{attach,detach}]
Tested-by: Kieran Bingham <kieran@bingham.xyz>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
---
Changes since v4 [Kieran]
 - Rename .probe2 to probe_new
 - Checkpatch warnings fixed
---
 drivers/i2c/i2c-core.c | 15 ++++++++++++---
 include/linux/i2c.h    |  8 +++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f20c9b229570..2003334b5246 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -834,8 +834,6 @@ static int i2c_device_probe(struct device *dev)
 	}
 
 	driver = to_i2c_driver(dev->driver);
-	if (!driver->probe)
-		return -EINVAL;
 
 	/*
 	 * An I2C ID table is not mandatory, if and only if, a suitable Device
@@ -877,7 +875,18 @@ static int i2c_device_probe(struct device *dev)
 	if (status == -EPROBE_DEFER)
 		goto err_clear_wakeup_irq;
 
-	status = driver->probe(client, i2c_match_id(driver->id_table, client));
+	/*
+	 * When there are no more users of probe(),
+	 * rename probe_new to probe.
+	 */
+	if (driver->probe_new)
+		status = driver->probe_new(client);
+	else if (driver->probe)
+		status = driver->probe(client,
+				       i2c_match_id(driver->id_table, client));
+	else
+		status = -EINVAL;
+
 	if (status)
 		goto err_detach_pm_domain;
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 39f1131a58d1..d31f37e90d11 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -135,7 +135,8 @@ enum i2c_alert_protocol {
  * struct i2c_driver - represent an I2C device driver
  * @class: What kind of i2c device we instantiate (for detect)
  * @attach_adapter: Callback for bus addition (deprecated)
- * @probe: Callback for device binding
+ * @probe: Callback for device binding - soon to be deprecated
+ * @probe_new: New callback for device binding
  * @remove: Callback for device unbinding
  * @shutdown: Callback for device shutdown
  * @alert: Alert callback, for example for the SMBus alert protocol
@@ -178,6 +179,11 @@ struct i2c_driver {
 	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
 	int (*remove)(struct i2c_client *);
 
+	/* New driver model interface to aid the seamless removal of the
+	 * current probe()'s, more commonly unused than used second parameter.
+	 */
+	int (*probe_new)(struct i2c_client *);
+
 	/* driver model interfaces that don't relate to enumeration  */
 	void (*shutdown)(struct i2c_client *);
 
-- 
2.7.4
