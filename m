From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] i2c-designware: add Intel BayTrail ACPI ID
Date: Mon, 13 May 2013 13:54:31 +0300
Message-ID: <1368442471-7582-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1368442471-7582-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368442471-7582-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This is the same controller as on Intel Lynxpoint but the ACPI ID is
different (8086F41). Add support for this.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 8ec9133..35b70a1 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -69,6 +69,7 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT33C2", 0 },
 	{ "INT33C3", 0 },
+	{ "80860F41", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
1.7.10.4
