From: alanx.chiang@intel.com
Subject: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width property
Date: Wed, 25 Jul 2018 11:20:21 +0800
Message-ID: <1532488822-5622-2-git-send-email-alanx.chiang@intel.com>
References: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: andy.yeh@intel.com, sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, rpjday@crashcourse.ca, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

Currently the only way to use a variant of a supported model with
a different address with a different address width is to define a
new compatible string and the corresponding chip data structure.

Provide a flexible way to specify the size of the address pointer
by defining a new property: address-width.

Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
Signed-off-by: Andy Yeh <andy.yeh@intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 61d833a..aededdb 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -72,6 +72,8 @@ Optional properties:
 
   - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
 
+  - address-width: number of address bits (one of 8, 16).
+
 Example:
 
 eeprom@52 {
-- 
2.7.4
