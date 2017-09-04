From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v6 1/3] dt-bindings: add eeprom "size" property
Date: Mon,  4 Sep 2017 15:58:46 +0530
Message-ID: <1504520928-5191-2-git-send-email-divagar.mohandass@intel.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15914 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753344AbdIDK14 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Sep 2017 06:27:56 -0400
In-Reply-To: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, sakari.ailus@iki.fi
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, Divagar Mohandass <divagar.mohandass@intel.com>

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
