From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH] DT: i2c: Add Epson RX8010 to list of trivial devices
Date: Wed, 23 Dec 2015 13:38:58 -0500
Message-ID: <1450895938-21631-1-git-send-email-akshay.bhat@timesys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35108 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934005AbbLWSjc (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Dec 2015 13:39:32 -0500
Received: by mail-qk0-f179.google.com with SMTP id n135so43361068qka.2
        for <linux-i2c@vger.kernel.org>; Wed, 23 Dec 2015 10:39:31 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ktsai@capellamicro.com
Cc: wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, justin.waters@timesys.com, Akshay Bhat <akshay.bhat@timesys.com>

This adds devicetree documentation for the bindings of rtc-rx8010
driver.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index c50cf13..0f9c1de 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -49,6 +49,7 @@ dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
 dallas,ds75		Digital Thermometer and Thermostat
 dlg,da9053		DA9053: flexible system level PMIC with multicore support
 dlg,da9063		DA9063: system PMIC for quad-core application processors
+epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 epson,rx8025		High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK MODULE
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
-- 
2.6.3
