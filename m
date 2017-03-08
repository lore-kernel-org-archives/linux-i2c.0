From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] i2c: designware: Disable pm for PMIC i2c-bus even if there is no _SEM method
Date: Wed,  8 Mar 2017 09:47:13 +0100
Message-ID: <20170308084713.4815-3-hdegoede@redhat.com>
References: <20170308084713.4815-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751934AbdCHIrV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 8 Mar 2017 03:47:21 -0500
In-Reply-To: <20170308084713.4815-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

Cherrytrail devices use the dw i2c-bus with uid 7 to access their PMIC.
Even if the i2c-bus to the PMIC is not shared with the SoC's P-Unit
and i2c-designware-baytrail.c thus does not set the pm_disabled flag,
we still need to disable pm so that ACPI PMIC opregions can access the
PMIC during late-suspend and early-resume.

This fixes errors like these blocking suspend:

  i2c_designware 808622C1:06: timeout waiting for bus ready
  ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
  acpi 80860F14:02: Failed to change power state to D3hot
  PM: late suspend of devices failed

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 8ed96dd..08d609e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -94,7 +94,10 @@ static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
 static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	const struct acpi_device_id *id;
+	struct acpi_device *adev;
+	const char *uid;
 
 	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
@@ -114,6 +117,18 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	if (id && id->driver_data)
 		dev->flags |= (u32)id->driver_data;
 
+	if (acpi_bus_get_device(handle, &adev))
+		return -ENODEV;
+
+	/*
+	 * Cherrytrail I2C7 gets used for the PMIC which gets accessed
+	 * through ACPI opregions during late suspend / early resume
+	 * disable pm for it.
+	 */
+	uid = adev->pnp.unique_id;
+	if ((dev->flags & MODEL_CHERRYTRAIL) && !strcmp(uid, "7"))
+		dev->pm_disabled = true;
+
 	return 0;
 }
 
-- 
2.9.3
