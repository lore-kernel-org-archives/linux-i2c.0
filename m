From: alanx.chiang@intel.com
Subject: [PATCH v3 1/2] dt-bindings: at24: Add address-width property
Date: Wed, 27 Jun 2018 13:46:24 +0800
Message-ID: <1530078385-1546-2-git-send-email-alanx.chiang@intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: andy.yeh@intel.com, sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

The AT24 series chips use 8-bit address by default. If some
chips would like to support more than 8 bits, the at24 driver
should be added the compatible field for specfic chips.

Provide a flexible way to determine the addressing bits through
address-width in this patch.

Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
Signed-off-by: Andy Yeh <andy.yeh@intel.com>

---
since v1:
-- Remove the address-width field in the example.
since v2:
-- Remove redundant space.

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
