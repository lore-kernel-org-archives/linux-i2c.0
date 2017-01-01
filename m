From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 5/6] i2c: designware-baytrail: Fix race when resetting the semaphore
Date: Sun,  1 Jan 2017 21:15:20 +0100
Message-ID: <20170101201521.12364-5-hdegoede@redhat.com>
References: <20170101201521.12364-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932229AbdAAUPf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Jan 2017 15:15:35 -0500
In-Reply-To: <20170101201521.12364-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

Use iosf_mbi_modify instead of iosf_mbi_read + iosf_mbi_write so that
we keep the iosf_mbi_lock locked during the read-modify-write done to
reset the semaphore.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
-New patch in v5 of this patch-set
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 650a700..8df529c 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -47,15 +47,8 @@ static int get_sem(struct dw_i2c_dev *dev, u32 *sem)
 
 static void reset_semaphore(struct dw_i2c_dev *dev)
 {
-	u32 data;
-
-	if (iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, PUNIT_SEMAPHORE, &data)) {
-		dev_err(dev->dev, "iosf failed to reset punit semaphore during read\n");
-		return;
-	}
-
-	data &= ~PUNIT_SEMAPHORE_BIT;
-	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, PUNIT_SEMAPHORE, data))
+	if (iosf_mbi_modify(BT_MBI_UNIT_PMC, MBI_REG_READ, PUNIT_SEMAPHORE,
+			    0, PUNIT_SEMAPHORE_BIT))
 		dev_err(dev->dev, "iosf failed to reset punit semaphore during write\n");
 
 	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
-- 
2.9.3
