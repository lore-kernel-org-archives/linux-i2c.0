From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 09/13] i2c: designware-baytrail: Acquire P-Unit access on bus acquire
Date: Mon, 23 Jan 2017 22:09:54 +0100
Message-ID: <20170123210958.18410-10-hdegoede@redhat.com>
References: <20170123210958.18410-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbdAWVKe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 23 Jan 2017 16:10:34 -0500
In-Reply-To: <20170123210958.18410-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Acquire P-Unit access to stop others from accessing the P-Unit while the
PMIC i2c bus is in use. This is necessary because accessing the P-Unit
from the kernel may result in the P-Unit trying to access the PMIC i2c
bus, which results in a hang when it happens while we own the PMIC i2c
bus semaphore.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: tagorereddy <tagore.chandan@gmail.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
---
Changes in v2:
-Spelling: P-Unit, PMIC
-Adjust for iosf_mbi_punit_lock/_unlock to _acquire/_release rename
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 3effc9a..7eddc3b 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -62,6 +62,8 @@ static void reset_semaphore(struct dw_i2c_dev *dev)
 		dev_err(dev->dev, "iosf failed to reset punit semaphore during write\n");
 
 	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
+
+	iosf_mbi_punit_release();
 }
 
 static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
@@ -79,6 +81,8 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	if (!dev->release_lock)
 		return 0;
 
+	iosf_mbi_punit_acquire();
+
 	/*
 	 * Disallow the CPU to enter C6 or C7 state, entering these states
 	 * requires the punit to talk to the pmic and if this happens while
-- 
2.9.3
