From: Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 2/2] dt-bindings: power: supply: cw2015_battery: add device tree binding documentation
Date: Wed, 11 Dec 2019 14:39:30 +0100
Message-ID: <20191211133930.7488-3-t.schramm@manjaro.org>
References: <20191211133930.7488-1-t.schramm@manjaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211133930.7488-1-t.schramm@manjaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org
Cc: anarsoul@gmail.com, sre@kernel.org, pali.rohar@gmail.com, david@lechnology.com, afd@ti.com, Tobias Schramm <t.schramm@manjaro.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds the ds binding document for the cw2015 Fuel Gauge.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 .../bindings/power/supply/cw2015_battery.txt  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt b/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt
new file mode 100644
index 000000000000..e847391268f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt
@@ -0,0 +1,37 @@
+cw2015_battery
+~~~~~~~~~~~~~~~~
+
+The cellwise CW2015 is a shuntless single/multi-cell battery fuel gauge.
+
+Required properties :
+ - compatible : "cellwise,cw2015"
+ - cellwise,bat-config-info : Binary battery info blob
+
+Optional properties :
+ - cellwise,monitor-interval : Measurement interval in seconds
+ - cellwise,voltage-divider : Voltage divider for multi-cell packs,
+   specified as two integer values <high side>, <low side> in ohms.
+ - cellwise,virtual-power : Default to disconnected battery state (gauge in pack mode)
+ - cellwise,design-capacity : Design capacity of the battery cell in milliampere hours
+ - cellwise,alert-level : Low battery alarm level in percent
+
+Example:
+	cw2015@62 {
+		status = "okay";
+		compatible = "cellwise,cw201x";
+		reg = <0x62>;
+		cellwise,bat-config-info = <
+			0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
+			0x77 0x51 0x5C 0x58 0x50 0x4C 0x48 0x36
+			0x15 0x0C 0x0C 0x19 0x5B 0x7D 0x6F 0x69
+			0x69 0x5B 0x0C 0x29 0x20 0x40 0x52 0x59
+			0x57 0x56 0x54 0x4F 0x3B 0x1F 0x7F 0x17
+			0x06 0x1A 0x30 0x5A 0x85 0x93 0x96 0x2D
+			0x48 0x77 0x9C 0xB3 0x80 0x52 0x94 0xCB
+			0x2F 0x00 0x64 0xA5 0xB5 0x11 0xF0 0x11
+		>;
+		cellwise,monitor-interval = <5>;
+		cellwise,virtual-power;
+		cellwise,design-capacity = <9800>;
+		power-supplies = <&mains_charger>, <&usb_charger>;
+	}
-- 
2.24.0
