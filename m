From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v5 1/3] dt-bindings: add eeprom "size" property
Date: Mon,  4 Sep 2017 12:10:43 +0530
Message-ID: <1504507245-12902-2-git-send-email-divagar.mohandass@intel.com>
References: <1504507245-12902-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504507245-12902-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, sakari.ailus@iki.fi
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, Divagar Mohandass <divagar.mohandass@intel.com>
List-Id: linux-i2c@vger.kernel.org

This adds eeprom "size" as optional property for i2c eeproms.
The "size" property allows explicitly specifying the size of the
EEPROM chip in bytes.

Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
Acked-by: Rob Herring <robh@kernel.org>
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
