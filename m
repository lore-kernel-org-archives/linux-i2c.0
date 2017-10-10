From: Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: [PATCH v2 1/3] ACPI / APD: Add clock frequency for ThunderX2 I2C controller
Date: Tue, 10 Oct 2017 11:57:54 +0530
Message-ID: <1507616876-17189-2-git-send-email-kamlakant.patel@cavium.com>
References: <1507616876-17189-1-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1507616876-17189-1-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Jayachandran C <jnair@caviumnetworks.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kamlakant Patel <kamlakant.patel@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: Jayachandran C <jnair@caviumnetworks.com>

Add the input frequency of 125MHz for the ThunderX2 I2C controller block.
The ACPI ID used is "CAV9007".

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_apd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index d5999eb..d553b00 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -116,6 +116,10 @@ static const struct apd_device_desc hip08_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 250000000,
 };
+static const struct apd_device_desc thunderx2_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 125000000,
+};
 #endif
 
 #else
@@ -180,6 +184,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
 	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
 	{ "CAV900D",  APD_ADDR(vulcan_spi_desc) },
+	{ "CAV9007",  APD_ADDR(thunderx2_i2c_desc) },
 	{ "HISI02A1", APD_ADDR(hip07_i2c_desc) },
 	{ "HISI02A2", APD_ADDR(hip08_i2c_desc) },
 #endif
-- 
2.7.4

