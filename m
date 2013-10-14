From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/3] I2C: fix module autoloading for ACPI enumerated devices
Date: Mon, 14 Oct 2013 17:10:34 +0800
Message-ID: <1381741834-7334-3-git-send-email-rui.zhang@intel.com>
References: <1381741834-7334-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381741834-7334-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/i2c/i2c-core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3be58f8..d75b679 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -104,6 +104,11 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
+	int rc;
+
+	rc = acpi_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
 
 	if (add_uevent_var(env, "MODALIAS=%s%s",
 			   I2C_MODULE_PREFIX, client->name))
-- 
1.7.9.5
