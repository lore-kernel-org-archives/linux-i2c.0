From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/9] PM / ACPI: Split code validating need for runtime resume in ->prepare()
Date: Wed, 21 Jun 2017 21:21:23 +0200
Message-ID: <1498072888-14782-5-git-send-email-ulf.hansson@linaro.org>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34453 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdFUTVy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Jun 2017 15:21:54 -0400
Received: by mail-lf0-f49.google.com with SMTP id l13so43022289lfl.1
        for <linux-i2c@vger.kernel.org>; Wed, 21 Jun 2017 12:21:53 -0700 (PDT)
In-Reply-To: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Move the code dealing with validation of whether runtime resuming the
device is needed during system suspend.

In this way it becomes more clear for what circumstances ACPI is prevented
from trying the direct_complete path.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/device_pm.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d38acbc..ee51e75 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -933,6 +933,27 @@ int acpi_dev_resume_early(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resume_early);
 
+static bool acpi_dev_needs_resume(struct device *dev, struct acpi_device *adev)
+{
+	u32 sys_target = acpi_target_system_state();
+	int ret, state;
+
+	if (device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
+		return true;
+
+	if (sys_target == ACPI_STATE_S0)
+		return false;
+
+	if (adev->power.flags.dsw_present)
+		return true;
+
+	ret = acpi_dev_pm_get_state(dev, adev, sys_target, NULL, &state);
+	if (ret)
+		return true;
+
+	return !(state == adev->power.state);
+}
+
 /**
  * acpi_subsys_prepare - Prepare device for system transition to a sleep state.
  * @dev: Device to prepare.
@@ -940,26 +961,16 @@ EXPORT_SYMBOL_GPL(acpi_dev_resume_early);
 int acpi_subsys_prepare(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	u32 sys_target;
-	int ret, state;
+	int ret;
 
 	ret = pm_generic_prepare(dev);
 	if (ret < 0)
 		return ret;
 
-	if (!adev || !pm_runtime_suspended(dev)
-	    || device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
-		return 0;
-
-	sys_target = acpi_target_system_state();
-	if (sys_target == ACPI_STATE_S0)
-		return 1;
-
-	if (adev->power.flags.dsw_present)
+	if (!adev || !pm_runtime_suspended(dev))
 		return 0;
 
-	ret = acpi_dev_pm_get_state(dev, adev, sys_target, NULL, &state);
-	return !ret && state == adev->power.state;
+	return !acpi_dev_needs_resume(dev, adev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
 
-- 
2.7.4
