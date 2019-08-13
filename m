From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 01/13] ARM: dts: bcm283x: Enable HDMI at board level
Date: Tue, 13 Aug 2019 18:20:36 +0200
Message-ID: <1565713248-4906-2-git-send-email-wahrenst@gmx.net>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

There might be headless setups of the Compute Module without HDMI,
so better enable HDMI at board level. Btw this allows moving HDMI
into bcm2835-common.dtsi.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts   | 2 ++
 arch/arm/boot/dts/bcm2835-rpi-a.dts        | 2 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts   | 2 ++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts   | 2 ++
 arch/arm/boot/dts/bcm2835-rpi-b.dts        | 2 ++
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts  | 2 ++
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts   | 2 ++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts     | 2 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi         | 5 -----
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 2 ++
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 2 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 2 ++
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts  | 2 ++
 14 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 5b42e9a..6c8ce39 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -104,6 +104,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &pwm {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index b716214..17fdd48 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -99,6 +99,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &pwm {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 3318082..b0355c2 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -106,6 +106,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &pwm {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 97d7eb5..33b3b5c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -99,6 +99,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &pwm {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 37e02a1..2b69957 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -94,6 +94,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &pwm {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts b/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
index 41afea4..a75c882 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
@@ -79,6 +79,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &sdhost {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index f38f388..09a088f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -105,6 +105,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &sdhci {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index 5fd0686..6dd93c6 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -101,6 +101,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &sdhost {
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index f5125b7..6c6a7f6 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -67,11 +67,6 @@
 	power-domains = <&power RPI_POWER_DOMAIN_USB>;
 };

-&hdmi {
-	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
-	status = "okay";
-};
-
 &vec {
 	power-domains = <&power RPI_POWER_DOMAIN_VEC>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 6a89999..0455a68 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -106,6 +106,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &pwm {
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
index 0e29aaa..66ab35e 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
@@ -118,6 +118,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &pwm {
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index a1487ae..74ed6d0 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -125,6 +125,8 @@

 &hdmi {
 	hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &pwm {
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index a36bfdb..054ecaa 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -126,6 +126,8 @@

 &hdmi {
 	hpd-gpios = <&expgpio 4 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 /* uart0 communicates with the BT module */
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
index 433e306..588d941 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
@@ -78,6 +78,8 @@

 &hdmi {
 	hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
 };

 &sdhost {
--
2.7.4
