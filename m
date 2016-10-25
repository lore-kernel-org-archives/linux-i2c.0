From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv6 03/11] i2c: Match using traditional OF methods, then by vendor-less compatible strings
Date: Tue, 25 Oct 2016 17:41:47 +0100
Message-ID: <1477413715-22894-4-git-send-email-kieran@bingham.xyz>
References: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

This function provides a single call for all I2C devices which need to
match firstly using traditional OF means i.e by of_node, then if that
fails we attempt to match using the supplied I2C client name with a
list of supplied compatible strings with the '<vendor>,' string
removed.  The latter is required due to the unruly naming conventions
used currently by I2C devices.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
[Kieran: Fix static inline usage on !CONFIG_OF]
Tested-by: Kieran Bingham <kieran@bingham.xyz>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
---
 drivers/i2c/i2c-core.c | 16 ++++++++++++++++
 include/linux/i2c.h    | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a699ca541702..d5eca0dc32be 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1687,6 +1687,22 @@ i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
 	return NULL;
 }
 
+const struct of_device_id
+*i2c_of_match_device(const struct of_device_id *matches,
+		     struct i2c_client *client)
+{
+	const struct of_device_id *match;
+
+	if (!(client && matches))
+		return NULL;
+
+	match = of_match_device(matches, &client->dev);
+	if (match)
+		return match;
+
+	return i2c_of_match_device_strip_vendor(matches, client);
+}
+EXPORT_SYMBOL_GPL(i2c_of_match_device);
 #else
 static void of_i2c_register_devices(struct i2c_adapter *adap) { }
 #endif /* CONFIG_OF */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fffdc270ca18..2608e731e401 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -748,6 +748,10 @@ extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 /* must call i2c_put_adapter() when done with returned i2c_adapter device */
 struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node);
 
+extern const struct of_device_id
+*i2c_of_match_device(const struct of_device_id *matches,
+		     struct i2c_client *client);
+
 #else
 
 static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
@@ -764,6 +768,14 @@ static inline struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node
 {
 	return NULL;
 }
+
+static inline const struct of_device_id
+*i2c_of_match_device(const struct of_device_id *matches,
+		     struct i2c_client *client)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_I2C_H */
-- 
2.7.4
