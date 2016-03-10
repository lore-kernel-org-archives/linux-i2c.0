From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH] i2c: designware: Add device HID for future AMD I2C controller
Date: Thu, 10 Mar 2016 19:34:52 +0800
Message-ID: <1457609692-25903-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0088.outbound.protection.outlook.com ([207.46.100.88]:60742
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964918AbcCJHJ5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 10 Mar 2016 02:09:57 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>

Add device HID AMDI0010 to match the AMD ACPI Vendor ID (AMDI) that
was registered in http://www.uefi.org/acpi_id_list, and the I2C
controller on future AMD paltform will use the HID instead of AMD0010.

Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/acpi/acpi_apd.c                     | 1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index d507cf6..d0aad06 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -143,6 +143,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	/* Generic apd devices */
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
 	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
+	{ "AMDI0010", APD_ADDR(cz_i2c_desc) },
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
 #endif
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 438f1b4..d656657 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -123,6 +123,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
 	{ "AMD0010", ACCESS_INTR_MASK },
+	{ "AMDI0010", ACCESS_INTR_MASK },
 	{ "AMDI0510", 0 },
 	{ "APMC0D0F", 0 },
 	{ }
-- 
1.9.1
