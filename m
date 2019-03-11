From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] mfd: intel-lpss: Add "linux,use-dynamic-adapter-nr" device-prop to i2c-devices
Date: Mon, 11 Mar 2019 12:22:16 +0100
Message-ID: <20190311112216.31391-3-hdegoede@redhat.com>
References: <20190311112216.31391-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311112216.31391-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The i2c-designware-platdrv assumes that if the pdev has an apci-companion
it should use a dynamic adapter-nr and otherwise it will use pdev->id as
adapter-nr.

On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
some of the LPSS i2c-adapters are enumerated through PCI and do not have
an ACPI fwnode. These devices are handled as mfd devices so they end up
using the i2c-designware-platdrv driver.

This results in the i2c-adapter being registered with the mfd generated
pdev->id as adapter-nr, which conflicts with existing adapters, triggering
a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
adapter registration to fail.

To fix this the i2c-designware-platdrv now also supports a
"linux,use-dynamic-adapter-nr" device-property, which tells it to use a
dynamic adapter nr even if there is no ACPI fwnode for the device.

This commit adds this device-property to the properties list for PCI
enumerated LPSS i2c-adapters.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1687065
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel-lpss-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 0e5282fc1467..c7b84a0f090e 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -69,6 +69,7 @@ static const struct intel_lpss_platform_info spt_info = {
 
 static struct property_entry spt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
+	PROPERTY_ENTRY_BOOL("linux,use-dynamic-adapter-nr"),
 	{ },
 };
 
@@ -104,6 +105,7 @@ static struct property_entry bxt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
+	PROPERTY_ENTRY_BOOL("linux,use-dynamic-adapter-nr"),
 	{ },
 };
 
@@ -116,6 +118,7 @@ static struct property_entry apl_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 207),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
+	PROPERTY_ENTRY_BOOL("linux,use-dynamic-adapter-nr"),
 	{ },
 };
 
-- 
2.20.1
