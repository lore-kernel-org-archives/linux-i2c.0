From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] i2c: i2c-designware-platdrv: Allow a dynamic adap. nr without an ACPI fwnode
Date: Mon, 11 Mar 2019 12:22:15 +0100
Message-ID: <20190311112216.31391-2-hdegoede@redhat.com>
References: <20190311112216.31391-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311112216.31391-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Before this commit the i2c-designware-platdrv assumes that if the pdev
has an apci-companion it should use a dynamic adapter-nr and otherwise
it will use pdev->id as adapter-nr.

On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
some of the LPSS i2c-adapters are enumerated through PCI and do not have
an ACPI fwnode. These devices are handled as mfd devices so they end up
using the i2c-designware-platdrv driver.

This results in the i2c-adapter being registered with the mfd generated
pdev->id as adapter-nr, which conflicts with existing adapters, triggering
a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
adapter registration to fail.

This commit adds support for setting a "linux,use-dynamic-adapter-nr"
device property on the device to make i2c-designware-platdrv use dynamic
adapter-nrs on devices without an ACPI fwnode, together with changes to
drivers/mfd/intel-lpss-pci.c to set this, this fixes the WARN.

Before this commit the setting of the adapter.nr was somewhat convoluted,
in the acpi_companion case it was set from dw_i2c_acpi_configure, in the
non acpi_companion case it was set from dw_i2c_set_fifo_size() based on
tx_fifo_depth not being set yet. This commit also cleans this up.

Note the "linux,use-dynamic-adapter-nr" is meant for kernel internal use
only, therefor it is NOT documented under Documents/devicetree/bindings.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1687065
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ead5e7de3e4d..9f28159efdb2 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -86,7 +86,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	struct i2c_timings *t = &dev->timings;
 	u32 ss_ht = 0, fp_ht = 0, hs_ht = 0, fs_ht = 0;
 
-	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
 	dev->rx_fifo_depth = 32;
 
@@ -219,7 +218,7 @@ static void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 	dev->mode = DW_IC_SLAVE;
 }
 
-static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
+static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev)
 {
 	u32 param, tx_fifo_depth, rx_fifo_depth;
 
@@ -233,7 +232,6 @@ static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
 	if (!dev->tx_fifo_depth) {
 		dev->tx_fifo_depth = tx_fifo_depth;
 		dev->rx_fifo_depth = rx_fifo_depth;
-		dev->adapter.nr = id;
 	} else if (tx_fifo_depth >= 2) {
 		dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
 				tx_fifo_depth);
@@ -324,6 +322,13 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (has_acpi_companion(&pdev->dev))
 		dw_i2c_acpi_configure(pdev);
 
+	if (has_acpi_companion(&pdev->dev) ||
+	    device_property_read_bool(&pdev->dev,
+				      "linux,use-dynamic-adapter-nr"))
+		dev->adapter.nr = -1;
+	else
+		dev->adapter.nr = pdev->id;
+
 	/*
 	 * Only standard mode at 100kHz, fast mode at 400kHz,
 	 * fast mode plus at 1MHz and high speed mode at 3.4MHz are supported.
@@ -358,7 +363,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 				div_u64(clk_khz * t->sda_hold_ns + 500000, 1000000);
 	}
 
-	dw_i2c_set_fifo_size(dev, pdev->id);
+	dw_i2c_set_fifo_size(dev);
 
 	adap = &dev->adapter;
 	adap->owner = THIS_MODULE;
-- 
2.20.1
