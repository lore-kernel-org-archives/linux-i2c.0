From: Kieran Bingham <kieranbingham@gmail.com>
Subject: [RESEND PATCH v4 5/8] i2c: Export i2c_match_id() for direct use by device drivers
Date: Fri, 11 Sep 2015 12:56:01 +0100
Message-ID: <1441972564-9621-6-git-send-email-kieranbingham@gmail.com>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, javier@osg.samsung.com, Kieran Bingham <kieranbingham@gmail.com>
List-Id: linux-i2c@vger.kernel.org

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
Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
---
 drivers/i2c/i2c-core.c | 3 ++-
 include/linux/i2c.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2ebc64d..0e40136 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -447,7 +447,7 @@ static inline int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
 
 /* ------------------------------------------------------------------------- */
 
-static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
+const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
 	if (!(id && client))
@@ -460,6 +460,7 @@ static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(i2c_match_id);
 
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 48bbbab..787066b 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -232,6 +232,8 @@ struct i2c_client {
 
 extern struct i2c_client *i2c_verify_client(struct device *dev);
 extern struct i2c_adapter *i2c_verify_adapter(struct device *dev);
+extern const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
+					const struct i2c_client *client);
 
 static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
-- 
2.1.4
