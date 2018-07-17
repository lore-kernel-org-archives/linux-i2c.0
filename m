From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/5] mips: dts: mscc: enable i2c on ocelot_pcb123
Date: Tue, 17 Jul 2018 13:48:37 +0200
Message-ID: <20180717114837.21839-6-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Enable the i2c controller on ocelot PCB123. While there are no i2c devices
on the board itself, it can be used to control the SFP transceivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
index 4ccd65379059..d933f1cd8a60 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -26,6 +26,11 @@
 	status = "okay";
 };
 
+&i2c {
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &mdio0 {
 	status = "okay";
 };
-- 
2.18.0
