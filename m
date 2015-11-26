From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 1/9] i2c: document generic DT bindings for timing parameters
Date: Thu, 26 Nov 2015 23:59:09 +0100
Message-ID: <1448578757-12613-2-git-send-email-wsa@the-dreams.de>
References: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36516 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbbKZW7X (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 26 Nov 2015 17:59:23 -0500
In-Reply-To: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Also, sort the properties alphabetically and make indentation
consistent. Wording largely taken from i2c-rk3x.txt, thanks guys!

Only "i2c-scl-internal-delay-ns" is new, the rest is used by two drivers
already and was documented in their driver binding documentation.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 31 ++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index 8a99150ac3a7fd..a00219f5ee0733 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -29,12 +29,33 @@ Optional properties
 These properties may not be supported by all drivers. However, if a driver
 wants to support one of the below features, it should adapt the bindings below.
 
-- clock-frequency	- frequency of bus clock in Hz.
-- wakeup-source		- device can be used as a wakeup source.
+- clock-frequency
+	frequency of bus clock in Hz.
 
-- interrupts		- interrupts used by the device.
-- interrupt-names	- "irq" and "wakeup" names are recognized by I2C core,
-			  other names are left to individual drivers.
+- i2c-scl-falling-time-ns
+	Number of nanoseconds the SCL signal takes to fall; t(f) in the I2C
+	specification.
+
+- i2c-scl-internal-delay-ns
+	Number of nanoseconds the IP core additionally needs to setup SCL.
+
+- i2c-scl-rising-time-ns
+	Number of nanoseconds the SCL signal takes to rise; t(r) in the I2C
+	specification.
+
+- i2c-sda-falling-time-ns
+	Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
+	specification.
+
+- interrupts
+	interrupts used by the device.
+
+- interrupt-names
+	"irq" and "wakeup" names are recognized by I2C core, other names are
+	left to individual drivers.
+
+- wakeup-source
+	device can be used as a wakeup source.
 
 Binding may contain optional "interrupts" property, describing interrupts
 used by the device. I2C core will assign "irq" interrupt (or the very first
-- 
2.1.4
