From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] Documentation: dt: i2c: use correct STMicroelectronics vendor prefix
Date: Sun, 26 Jun 2016 02:34:04 -0700
Message-ID: <20160626093406.26785-1-stefan@agner.ch>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:48775 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbcFZJet (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 26 Jun 2016 05:34:49 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, mark.rutland@arm.com, arnd@arndb.de, shawnguo@kernel.org, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org
Cc: scottwood@freescale.com, dinguyen@opensource.altera.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>

The documentation currently uses the non-standard vendor prefix stm
and st-micro for STMicroelectronics. The drivers do not specify the
vendor prefixes since the I2C Core strips them away from the DT
provided compatible string. Therefor, changing documentation and
existing device trees does not have any impact on device detection.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi,

Mark mentioned that issue already once in the past, see:
http://lkml.iu.edu/hypermail/linux/kernel/1309.0/01686.html

Not sure through which trees this patches should flow, I guess
the first through Wolfram's tree, the ARM changes through Arnd
or Shawns tree (mostly Freescale boards are affected), not sure
about the PowerPC changes...

--
Stefan

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 53987449..8db3384 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -81,10 +81,10 @@ samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
 sgx,vz89x		SGX Sensortech VZ89X Sensors
 sii,s35390a		2-wire CMOS real-time clock
 skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
-st-micro,24c256		i2c serial eeprom  (24cxx)
-stm,m41t00		Serial Access TIMEKEEPER
-stm,m41t62		Serial real-time clock (RTC) with alarm
-stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
+st,24c256		i2c serial eeprom  (24cxx)
+st,m41t00		Serial real-time clock (RTC)
+st,m41t62		Serial real-time clock (RTC) with alarm
+st,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
 taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
 ti,ads7828		8-Channels, 12-bit ADC
 ti,ads7830		8-Channels, 8-bit ADC
-- 
2.8.3
