From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH] DT: i2c: Add Freescale MPL3115 to trivial devices list
Date: Wed, 23 Dec 2015 13:59:07 -0500
Message-ID: <1450897147-22370-1-git-send-email-akshay.bhat@timesys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33726 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbbLWS7Q (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Dec 2015 13:59:16 -0500
Received: by mail-qg0-f54.google.com with SMTP id k90so159988479qge.0
        for <linux-i2c@vger.kernel.org>; Wed, 23 Dec 2015 10:59:16 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ktsai@capellamicro.com
Cc: wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, justin.waters@timesys.com, Akshay Bhat <akshay.bhat@timesys.com>

This adds devicetree documentation for the bindings of mpl3115 driver.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index c50cf13..f3f4bc2 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -54,6 +54,7 @@ epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
 fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
 fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
+fsl,mpl3115		MPL3115: Absolute Digital Pressure Sensor
 fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
 fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
-- 
2.6.3
