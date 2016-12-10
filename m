From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/5] i2c: designware-baytrail: Only check iosf_mbi_available() for shared hosts
Date: Sat, 10 Dec 2016 23:43:48 +0100
Message-ID: <20161210224350.10290-3-hdegoede@redhat.com>
References: <20161210224350.10290-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752345AbcLJWn7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Dec 2016 17:43:59 -0500
In-Reply-To: <20161210224350.10290-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

If (!shared_host) simply return 0, this avoids delaying the probe if
iosf_mbi_available() returns false when an i2c bus is not using the
punit semaphore.

Also move the if (!iosf_mbi_available()) check to above the
dev_info, so that we do not repeat the dev_info on every probe
until iosf_mbi_available() returns true.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this set
Changes in v3:
-Use if (!shared_host) return 0, to simplify the non-shared_host path
 and to avoid nested ifs
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index a3f581c..cf02222 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -138,15 +138,16 @@ int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev)
 	if (ACPI_FAILURE(status))
 		return 0;
 
-	if (shared_host) {
-		dev_info(dev->dev, "I2C bus managed by PUNIT\n");
-		dev->acquire_lock = baytrail_i2c_acquire;
-		dev->release_lock = baytrail_i2c_release;
-		dev->pm_runtime_disabled = true;
-	}
+	if (!shared_host)
+		return 0;
 
 	if (!iosf_mbi_available())
 		return -EPROBE_DEFER;
 
+	dev_info(dev->dev, "I2C bus managed by PUNIT\n");
+	dev->acquire_lock = baytrail_i2c_acquire;
+	dev->release_lock = baytrail_i2c_release;
+	dev->pm_runtime_disabled = true;
+
 	return 0;
 }
-- 
2.9.3
