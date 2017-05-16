From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC] i2c-stub: make it usable with DT when booting
Date: Tue, 16 May 2017 13:27:58 +0200
Message-ID: <20170516112758.2842-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

This patch makes the stub driver parse the device tree when booting and
create a virtual bus with the desired devices attached. Here is an
example DTS snipplet making use of it. It is for simulating a more
complex camera device which has dependencies which needs to be sorted
out at boot time:

i2c@42 {
	compatible = "i2c-stub";

	#address-cells = <1>;
	#size-cells = <0>;

	des@4c {
		compatible = "maxim,max9268";
		reg = <0x4c>;
	};

	eeprom@57 {
		compatible = "atmel,24c02";
		reg = <0x57>;
	};
};

FIXME: can fw_* calls be used instead of of_*?

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

It was really useful when developing. When using fw_* calls, we probably could
make use of it with ACPI as well. Still, calling for opinions if we want this
upstream or if we want to stay module-only? Also, the binding should really
be marked as "development only". Or is it better to keep it as a separate
patch to keep the binding un-official?

 drivers/i2c/Kconfig    |  2 +-
 drivers/i2c/i2c-stub.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index efc3354d60ae89..6d38b38632f44c 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -99,7 +99,7 @@ source drivers/i2c/busses/Kconfig
 
 config I2C_STUB
 	tristate "I2C/SMBus Test Stub"
-	depends on m
+	depends on m || OF
 	default 'n'
 	help
 	  This module may be useful to developers of SMBus client drivers,
diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index 5627b1df391c7e..ce30bc4ac15a28 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -359,10 +359,44 @@ static void i2c_stub_free(void)
 	kfree(stub_chips);
 }
 
+#ifdef CONFIG_OF
+void i2c_stub_parse_of(void)
+{
+	struct device_node *np, *child;
+	u32 reg, i = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "i2c-stub");
+	if (!np)
+		return;
+
+	for_each_available_child_of_node(np, child) {
+		if (of_property_read_u32(child, "reg", &reg) == 0) {
+			chip_addr[i++] = reg;
+			if (i == MAX_CHIPS) {
+				pr_warn("Maximum number of chips reached!\n");
+				break;
+			}
+		}
+	}
+
+	stub_adapter.dev.of_node = np;
+
+	np = of_find_compatible_node(np, NULL, "i2c-stub");
+	if (np) {
+		pr_warn("Driver can currently do only one stub from DT!\n");
+		of_node_put(np);
+	}
+}
+#else
+void i2c_stub_parse_of(void) { }
+#endif
+
 static int __init i2c_stub_init(void)
 {
 	int i, ret;
 
+	i2c_stub_parse_of();
+
 	if (!chip_addr[0]) {
 		pr_err("Please specify a chip address\n");
 		return -ENODEV;
-- 
2.11.0
