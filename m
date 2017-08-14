From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v2 1/3] dt-bindings: add eeprom "size" property
Date: Tue, 15 Aug 2017 00:11:57 +0530
Message-ID: <1502736119-32084-2-git-send-email-divagar.mohandass@intel.com>
References: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, Divagar Mohandass <divagar.mohandass@intel.com>
List-Id: linux-i2c@vger.kernel.org

This adds eeprom "size" as optional property for i2c eeproms.

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
