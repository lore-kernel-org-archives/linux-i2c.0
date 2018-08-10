From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] i2c: core: ACPI: Properly set status byte to 0 for multi-byte writes
Date: Fri, 10 Aug 2018 14:27:14 +0200
Message-ID: <20180810122714.690-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

acpi_gsb_i2c_write_bytes() returns i2c_transfer()'s return value, which
is the number of transfers executed on success, so 1.

The ACPI code expects us to store 0 in gsb->status for success, not 1.

Specifically this breaks the following code in the Thinkpad 8 DSDT:

            ECWR = I2CW = ECWR /* \_SB_.I2C1.BAT0.ECWR */
            If ((ECST == Zero))
            {
                ECRD = I2CR /* \_SB_.I2C1.I2CR */
            }

Before this commit we set ECST to 1, causing the read to never happen
breaking battery monitoring on the Thinkpad 8. Note the Thinkpad 8 also
has some unrelated issues where i2c transfers are unreliable.

This commit sets status to 0 if it was bigger then 0 (so success),
mirroring the multi-byte read path, fixing this.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 7c3b4740b94b..10ad851bd277 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -595,6 +595,8 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 		} else {
 			status = acpi_gsb_i2c_write_bytes(client, command,
 					gsb->data, info->access_length);
+			if (status > 0)
+				status = 0;
 		}
 		break;
 
-- 
2.18.0
