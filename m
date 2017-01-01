From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 2/4] i2c: designware-baytrail: Take punit lock on bus acquire
Date: Sun,  1 Jan 2017 21:14:01 +0100
Message-ID: <20170101201403.12132-3-hdegoede@redhat.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932229AbdAAUOL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Jan 2017 15:14:11 -0500
In-Reply-To: <20170101201403.12132-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

Take the punit lock to stop others from accessing the punit while the
pmic i2c bus is in use. This is necessary because accessing the punit
from the kernel may result in the punit trying to access the pmic i2c
bus, which results in a hang when it happens while we own the pmic i2c
bus semaphore.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 3effc9a..507875d 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -61,6 +61,8 @@ static void reset_semaphore(struct dw_i2c_dev *dev)
 			    0, PUNIT_SEMAPHORE_BIT))
 		dev_err(dev->dev, "iosf failed to reset punit semaphore during write\n");
 
+	iosf_mbi_punit_unlock();
+
 	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
 }
 
@@ -86,6 +88,8 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	 */
 	pm_qos_update_request(&dev->pm_qos, 0);
 
+	iosf_mbi_punit_lock();
+
 	/* host driver writes to side band semaphore register */
 	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, addr, sem);
 	if (ret) {
-- 
2.9.3
