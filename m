From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH] DT: i2c: Update vendor prefix for 24c00
Date: Wed, 23 Dec 2015 14:18:55 -0500
Message-ID: <1450898335-22814-1-git-send-email-akshay.bhat@timesys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34276 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647AbbLWTTO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Dec 2015 14:19:14 -0500
Received: by mail-qg0-f43.google.com with SMTP id 6so5854959qgy.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Dec 2015 11:19:14 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ktsai@capellamicro.com
Cc: wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, justin.waters@timesys.com, Akshay Bhat <akshay.bhat@timesys.com>

"at" is not a valid vendor prefix, correcting the same to "atmel"

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index c50cf13..c4a01c0 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -20,11 +20,11 @@ adi,adt7476		+/-1C TDM Extended Temp Range I.C
 adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
-at,24c08		i2c serial eeprom  (24cxx)
 atmel,24c00		i2c serial eeprom  (24cxx)
 atmel,24c01		i2c serial eeprom  (24cxx)
 atmel,24c02		i2c serial eeprom  (24cxx)
 atmel,24c04		i2c serial eeprom  (24cxx)
+atmel,24c08		i2c serial eeprom  (24cxx)
 atmel,24c16		i2c serial eeprom  (24cxx)
 atmel,24c32		i2c serial eeprom  (24cxx)
 atmel,24c64		i2c serial eeprom  (24cxx)
-- 
2.6.3
