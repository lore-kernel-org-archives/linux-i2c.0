From: Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: [PATCH 1/3] ACPI / APD: Add clock frequency for ThunderX2 I2C controller
Date: Wed, 27 Sep 2017 20:22:21 +0530
Message-ID: <1506523943-8632-2-git-send-email-kamlakant.patel@cavium.com>
References: <1506523943-8632-1-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1506523943-8632-1-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Jayachandran C <jnair@caviumnetworks.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kamlakant Patel <kamlakant.patel@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: Jayachandran C <jnair@caviumnetworks.com>

Add the input frequency of 125MHz for the ThunderX2 I2C controller block.
The ACPI ID used is "CAV9007".

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
---
 drivers/acpi/acpi_apd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 17a1eb1..93acc9b 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -106,6 +106,10 @@ static const struct apd_device_desc vulcan_spi_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
 };
+static const struct apd_device_desc thunderx2_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 125000000,
+};
 #endif
 
 #else
@@ -170,6 +174,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
 	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
 	{ "CAV900D",  APD_ADDR(vulcan_spi_desc) },
+	{ "CAV9007",  APD_ADDR(thunderx2_i2c_desc) },
 #endif
 	{ }
 };
-- 
2.7.4

