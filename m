From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 12/13] mfd: intel-lpss: Pass SDA hold time to I2C host controller driver
Date: Tue, 24 Nov 2015 12:22:58 +0200
Message-ID: <1448360579-79260-13-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Intel Skylake the LPSS I2C pad circuit has internal delays that require
programming non-zero SDA hold time for the I2C host controller. If this is
not done communication to slave devices may fail with arbitration lost
errors like the one seen below taken from Lenovo Yoga 900:

  i2c_hid i2c-SYNA2B29:00: Fetching the HID descriptor
  i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=20 00
  i2c_designware i2c_designware.1: i2c_dw_handle_tx_abort: lost arbitration

To fix this we follow what the Windows driver is doing and pass the default
SDA hold time of 230 ns to all Intel Skylake host controllers. This still
allows the platform to override these values by passing special ACPI
methods SSCN and FMCN.

Reported-by: Kevin Fenzi <kevin@scrye.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c | 18 ++++++++++++++++--
 drivers/mfd/intel-lpss-pci.c  | 30 ++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index b6fd904..6c5bbda 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -25,6 +25,20 @@ static const struct intel_lpss_platform_info spt_info = {
 	.clk_rate = 120000000,
 };
 
+static struct property_entry spt_i2c_properties[] = {
+	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
+	{ },
+};
+
+static struct property_set spt_i2c_pset = {
+	.properties = spt_i2c_properties,
+};
+
+static const struct intel_lpss_platform_info spt_i2c_info = {
+	.clk_rate = 120000000,
+	.pset = &spt_i2c_pset,
+};
+
 static const struct intel_lpss_platform_info bxt_info = {
 	.clk_rate = 100000000,
 };
@@ -35,8 +49,8 @@ static const struct intel_lpss_platform_info bxt_i2c_info = {
 
 static const struct acpi_device_id intel_lpss_acpi_ids[] = {
 	/* SPT */
-	{ "INT3446", (kernel_ulong_t)&spt_info },
-	{ "INT3447", (kernel_ulong_t)&spt_info },
+	{ "INT3446", (kernel_ulong_t)&spt_i2c_info },
+	{ "INT3447", (kernel_ulong_t)&spt_i2c_info },
 	/* BXT */
 	{ "80860AAC", (kernel_ulong_t)&bxt_i2c_info },
 	{ "80860ABC", (kernel_ulong_t)&bxt_info },
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 74f0d6d..3c84ceb 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -65,6 +65,20 @@ static const struct intel_lpss_platform_info spt_info = {
 	.clk_rate = 120000000,
 };
 
+static struct property_entry spt_i2c_properties[] = {
+	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
+	{ },
+};
+
+static struct property_set spt_i2c_pset = {
+	.properties = spt_i2c_properties,
+};
+
+static const struct intel_lpss_platform_info spt_i2c_info = {
+	.clk_rate = 120000000,
+	.pset = &spt_i2c_pset,
+};
+
 static struct property_entry uart_properties[] = {
 	PROPERTY_ENTRY_U32("reg-io-width", 4),
 	PROPERTY_ENTRY_U32("reg-shift", 2),
@@ -134,20 +148,20 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9d28), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x9d29), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0x9d2a), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9d60), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9d61), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9d62), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9d63), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9d64), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9d65), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d60), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9d61), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9d62), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9d63), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9d64), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9d65), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9d66), (kernel_ulong_t)&spt_uart_info },
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa129), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0xa12a), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0xa160), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0xa161), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa160), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa161), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa166), (kernel_ulong_t)&spt_uart_info },
 	{ }
 };
-- 
2.6.2
