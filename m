From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv7 05/11] i2c: Export i2c_match_id() for direct use by device drivers
Date: Mon,  7 Nov 2016 12:47:40 +0000
Message-ID: <1478522866-29620-6-git-send-email-kieran@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753178AbcKGMsQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 7 Nov 2016 07:48:16 -0500
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com

From: Lee Jones <lee.jones@linaro.org>

When there was no other way to match a I2C device to driver i2c_match_id()
was exclusively used.  However, now there are other types of tables which
are commonly supplied, matching on an i2c_device_id table is used less
frequently.  Instead of _always_ calling i2c_match_id() from within the
framework, we only need to do so from drivers which have no other way of
matching.  This patch makes i2c_match_id() available to the aforementioned
device drivers.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Tested-by: Kieran Bingham <kieran@bingham.xyz>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
---
 drivers/i2c/i2c-core.c | 3 ++-
 include/linux/i2c.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6439174c0ff5..48237d035246 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -676,7 +676,7 @@ static inline int i2c_acpi_install_space_handler(struct i2c_adapter *adapter)
 
 /* ------------------------------------------------------------------------- */
 
-static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
+const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
 	if (!(id && client))
@@ -689,6 +689,7 @@ static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(i2c_match_id);
 
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index c0a4a12815aa..7e00efd6a62f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -243,6 +243,8 @@ struct i2c_client {
 
 extern struct i2c_client *i2c_verify_client(struct device *dev);
 extern struct i2c_adapter *i2c_verify_adapter(struct device *dev);
+extern const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
+					const struct i2c_client *client);
 
 static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
-- 
2.7.4
