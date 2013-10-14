From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/3] Platform: fix module autoloading for ACPI enumerated devices
Date: Mon, 14 Oct 2013 17:10:33 +0800
Message-ID: <1381741834-7334-2-git-send-email-rui.zhang@intel.com>
References: <1381741834-7334-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381741834-7334-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/base/platform.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4f8bef3..80d2250 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -690,6 +690,10 @@ static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (rc != -ENODEV)
 		return rc;
 
+	rc = acpi_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
 	add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
 			pdev->name);
 	return 0;
-- 
1.7.9.5
