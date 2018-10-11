From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/3] ACPI / PMIC: xpower: Block P-Unit I2C access during read-modify-write
Date: Thu, 11 Oct 2018 16:29:10 +0200
Message-ID: <20181011142911.13750-3-hdegoede@redhat.com>
References: <20181011142911.13750-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011142911.13750-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

intel_xpower_pmic_update_power() does a read-modify-write of the output
control register. The i2c-designware code blocks the P-Unit I2C access
during the read and write by taking the P-Unit's PMIC bus semaphore.
But between the read and the write that semaphore is released and the
P-Unit could make changes to the register which we then end up overwriting.

This commit makes intel_xpower_pmic_update_power() take the semaphore
itself so that it is held over the entire read-modify-write, avoiding this
race.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 316e55174aa9..9e6ddf2a2d4e 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
+#include <asm/iosf_mbi.h>
 #include "intel_pmic.h"
 
 #define XPOWER_GPADC_LOW	0x5b
@@ -180,15 +181,21 @@ static int intel_xpower_pmic_get_power(struct regmap *regmap, int reg,
 static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
 					  int bit, bool on)
 {
-	int data;
+	int data, ret;
 
 	/* GPIO1 LDO regulator needs special handling */
 	if (reg == XPOWER_GPI1_CTRL)
 		return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
 					  on ? GPI1_LDO_ON : GPI1_LDO_OFF);
 
-	if (regmap_read(regmap, reg, &data))
-		return -EIO;
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret)
+		return ret;
+
+	if (regmap_read(regmap, reg, &data)) {
+		ret = -EIO;
+		goto out;
+	}
 
 	if (on)
 		data |= BIT(bit);
@@ -196,9 +203,11 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
 		data &= ~BIT(bit);
 
 	if (regmap_write(regmap, reg, data))
-		return -EIO;
+		ret = -EIO;
+out:
+	iosf_mbi_unblock_punit_i2c_access();
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.19.0
