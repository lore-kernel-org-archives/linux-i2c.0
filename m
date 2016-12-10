From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/5] i2c: designware-baytrail: Only check iosf_mbi_available() for shared hosts
Date: Sat, 10 Dec 2016 15:19:06 +0100
Message-ID: <20161210141908.16470-3-hdegoede@redhat.com>
References: <20161210141908.16470-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752323AbcLJOTP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Dec 2016 09:19:15 -0500
In-Reply-To: <20161210141908.16470-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

There is no need to delay the probe if iosf_mbi_available() returns
false when an i2c bus is not using the punit semaphore.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index a3f581c..a419777 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -139,14 +139,14 @@ int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev)
 		return 0;
 
 	if (shared_host) {
+		if (!iosf_mbi_available())
+			return -EPROBE_DEFER;
+
 		dev_info(dev->dev, "I2C bus managed by PUNIT\n");
 		dev->acquire_lock = baytrail_i2c_acquire;
 		dev->release_lock = baytrail_i2c_release;
 		dev->pm_runtime_disabled = true;
 	}
 
-	if (!iosf_mbi_available())
-		return -EPROBE_DEFER;
-
 	return 0;
 }
-- 
2.9.3
