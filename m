From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv7 02/11] i2c: Add the ability to match device to compatible string without an of_node
Date: Mon,  7 Nov 2016 12:47:37 +0000
Message-ID: <1478522866-29620-3-git-send-email-kieran@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

A great deal of I2C devices are currently matched via DT node name, and
as such the compatible naming convention of '<vendor>,<device>' has gone
somewhat awry - some nodes don't supply one, some supply an arbitrary
string and others the correct device name with an arbitrary vendor prefix.

In an effort to correct this problem we have to supply a mechanism to
match a device by compatible string AND by simple device name.  This
function strips off the '<vendor>,' part of a supplied compatible string
and attempts to match without it.

The plan is to remove this function once all of the compatible strings
for each device have been brought into line.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
[Kieran: strnicmp to strncasecmp]
Tested-by: Kieran Bingham <kieran@bingham.xyz>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

---
changes from v6
 - Rename i2c_of_match_device_strip_vendor to i2c_of_match_device_sysfs

 drivers/i2c/i2c-core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 86083e5e5520..dcbda850804f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1769,6 +1769,27 @@ struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
 	return adapter;
 }
 EXPORT_SYMBOL(of_get_i2c_adapter_by_node);
+
+static const struct of_device_id*
+i2c_of_match_device_sysfs(const struct of_device_id *matches,
+				  struct i2c_client *client)
+{
+	const char *name;
+
+	for (; matches->compatible[0]; matches++) {
+		name = strchr(matches->compatible, ',');
+		if (!name)
+			name = matches->compatible;
+		else
+			name++;
+
+		if (!strncasecmp(client->name, name, strlen(client->name)))
+			return matches;
+	}
+
+	return NULL;
+}
+
 #else
 static void of_i2c_register_devices(struct i2c_adapter *adap) { }
 #endif /* CONFIG_OF */
-- 
2.7.4
