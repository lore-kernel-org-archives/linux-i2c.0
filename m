From: divagar.mohandass@intel.com
Subject: [PATCH 1/3] dt-bindings: add "size" property.
Date: Thu, 27 Jul 2017 22:13:07 +0530
Message-ID: <1501173789-25959-2-git-send-email-divagar.mohandass@intel.com>
References: <1501173789-25959-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6789 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751760AbdG0QnN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 27 Jul 2017 12:43:13 -0400
In-Reply-To: <1501173789-25959-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rajmohan.mani@intel.com, Divagar Mohandass <divagar.mohandass@intel.com>

From: Divagar Mohandass <divagar.mohandass@intel.com>

This adds "size" as optional property for i2c eeproms.

"size" should be mentioned in byte and it should refer
to the eeprom size. This will be read by the driver and
used to calculating the number of bytes in read/write calls.

Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index 5696eb5..1436569 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -32,6 +32,8 @@ Optional properties:
 
   - read-only: this parameterless property disables writes to the eeprom
 
+  - size: total eeprom size in bytes
+
 Example:
 
 eeprom@52 {
-- 
1.9.1
