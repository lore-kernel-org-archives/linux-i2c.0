From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v6 2/2] dt-bindings: add eeprom "no-read-rollover" property
Date: Thu, 7 Dec 2017 14:26:19 -0500
Message-ID: <1512674779-10349-3-git-send-email-svendev@arcx.com>
References: <1512674779-10349-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.arcx.com ([184.94.50.18]:55211 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbdLGT01 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 14:26:27 -0500
In-Reply-To: <1512674779-10349-1-git-send-email-svendev@arcx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: svendev@arcx.com, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, david@lechnology.com, javier@dowhile0.org, divagar.mohandass@intel.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

Adds an optional property for at24 eeproms.
This parameterless property indicates that the multi-address eeprom
does not automatically roll over reads to the next slave address.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index 27f2bc1..5bfc0ac 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -38,6 +38,11 @@ Optional properties:
 
   - size: total eeprom size in bytes
 
+  - no-read-rollover:
+			This parameterless property indicates that the multi-address
+			eeprom does not automatically roll over reads to the next
+			slave address. Please consult the manual of your device.
+
 Example:
 
 eeprom@52 {
-- 
1.9.1
