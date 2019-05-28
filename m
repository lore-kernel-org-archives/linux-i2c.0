From: Ruslan Babayev <ruslan@babayev.com>
Subject: [net-next,v3 2/2] net: phy: sfp: enable i2c-bus detection on ACPI based systems
Date: Mon, 27 May 2019 20:22:13 -0700
Message-ID: <20190528032213.19839-3-ruslan@babayev.com>
References: <20190528032213.19839-1-ruslan@babayev.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190528032213.19839-1-ruslan@babayev.com>
Sender: netdev-owner@vger.kernel.org
To: mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

Lookup I2C adapter using the "i2c-bus" device property on ACPI based
systems similar to how it's done with DT.

An example DSD describing an SFP on an ACPI based system:

Device (SFP0)
{
    Name (_HID, "PRP0001")
    Name (_CRS, ResourceTemplate()
    {
        GpioIo(Exclusive, PullDefault, 0, 0, IoRestrictionNone,
               "\\_SB.PCI0.RP01.GPIO", 0, ResourceConsumer)
            { 0, 1, 2, 3, 4 }
    })
    Name (_DSD, Package ()
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package () { "compatible", "sff,sfp" },
            Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
            Package () { "maximum-power-milliwatt", 1000 },
            Package () { "tx-disable-gpios", Package () { ^SFP0, 0, 0, 1} },
            Package () { "reset-gpio",       Package () { ^SFP0, 0, 1, 1} },
            Package () { "mod-def0-gpios",   Package () { ^SFP0, 0, 2, 1} },
            Package () { "tx-fault-gpios",   Package () { ^SFP0, 0, 3, 0} },
            Package () { "los-gpios",        Package () { ^SFP0, 0, 4, 1} },
        },
    })
}

Device (PHY0)
{
    Name (_HID, "PRP0001")
    Name (_DSD, Package ()
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package () { "compatible", "ethernet-phy-ieee802.3-c45" },
            Package () { "sfp", \_SB.PCI0.RP01.SFP0 },
            Package () { "managed", "in-band-status" },
            Package () { "phy-mode", "sgmii" },
        },
    })
}

Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
Cc: xe-linux-external@cisco.com
---
 drivers/net/phy/sfp.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index d4635c2178d1..7a6c8df8899b 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/rtnetlink.h>
@@ -1783,6 +1784,7 @@ static int sfp_probe(struct platform_device *pdev)
 {
 	const struct sff_data *sff;
 	struct sfp *sfp;
+	struct i2c_adapter *i2c = NULL;
 	bool poll = false;
 	int irq, err, i;
 
@@ -1801,7 +1803,6 @@ static int sfp_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		struct device_node *node = pdev->dev.of_node;
 		const struct of_device_id *id;
-		struct i2c_adapter *i2c;
 		struct device_node *np;
 
 		id = of_match_node(sfp_of_match, node);
@@ -1818,14 +1819,30 @@ static int sfp_probe(struct platform_device *pdev)
 
 		i2c = of_find_i2c_adapter_by_node(np);
 		of_node_put(np);
-		if (!i2c)
-			return -EPROBE_DEFER;
-
-		err = sfp_i2c_configure(sfp, i2c);
-		if (err < 0) {
-			i2c_put_adapter(i2c);
-			return err;
+	} else if (ACPI_COMPANION(&pdev->dev)) {
+		struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+		struct fwnode_handle *fw = acpi_fwnode_handle(adev);
+		struct fwnode_reference_args args;
+		struct acpi_handle *acpi_handle;
+		int ret;
+
+		ret = acpi_node_get_property_reference(fw, "i2c-bus", 0, &args);
+		if (ACPI_FAILURE(ret) || !is_acpi_device_node(args.fwnode)) {
+			dev_err(&pdev->dev, "missing 'i2c-bus' property\n");
+			return -ENODEV;
 		}
+
+		acpi_handle = ACPI_HANDLE_FWNODE(args.fwnode);
+		i2c = i2c_acpi_find_adapter_by_handle(acpi_handle);
+	}
+
+	if (!i2c)
+		return -EPROBE_DEFER;
+
+	err = sfp_i2c_configure(sfp, i2c);
+	if (err < 0) {
+		i2c_put_adapter(i2c);
+		return err;
 	}
 
 	for (i = 0; i < GPIO_MAX; i++)
-- 
2.19.2
