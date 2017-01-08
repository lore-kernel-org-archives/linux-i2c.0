From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/7] i2c: designware-baytrail: Take punit lock on bus acquire
Date: Sun,  8 Jan 2017 14:44:23 +0100
Message-ID: <20170108134427.8392-4-hdegoede@redhat.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756210AbdAHNok (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 8 Jan 2017 08:44:40 -0500
In-Reply-To: <20170108134427.8392-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Take the punit lock to stop others from accessing the punit while the
pmic i2c bus is in use. This is necessary because accessing the punit
from the kernel may result in the punit trying to access the pmic i2c
bus, which results in a hang when it happens while we own the pmic i2c
bus semaphore.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: tagorereddy <tagore.chandan@gmail.com>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 3effc9a..cf7a2a0 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -62,6 +62,8 @@ static void reset_semaphore(struct dw_i2c_dev *dev)
 		dev_err(dev->dev, "iosf failed to reset punit semaphore during write\n");
 
 	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
+
+	iosf_mbi_punit_unlock();
 }
 
 static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
@@ -79,6 +81,8 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	if (!dev->release_lock)
 		return 0;
 
+	iosf_mbi_punit_lock();
+
 	/*
 	 * Disallow the CPU to enter C6 or C7 state, entering these states
 	 * requires the punit to talk to the pmic and if this happens while
-- 
2.9.3
