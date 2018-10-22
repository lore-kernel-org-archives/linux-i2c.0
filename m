From: Adrian Bunk <bunk@kernel.org>
Subject: 4.14/4.18: Please add "eeprom: at24: Add support for address-width
 property"
Date: Mon, 22 Oct 2018 11:38:35 +0300
Message-ID: <20181022083835.GA5315@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Alan Chiang <alanx.chiang@intel.com>, Andy Yeh <andy.yeh@intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Please cherry-pick the following commit to 4.14 and 4.18:

    commit a2b3bf4846e5eed62ea6abb096af2c950961033c
    Author: Alan Chiang <alanx.chiang@intel.com>
    Date:   Wed Jul 25 11:20:22 2018 +0800

    eeprom: at24: Add support for address-width property
    
    Provide a flexible way to determine the addressing bits of eeprom.
    Pass the addressing bits to driver through address-width property.

    Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
    Signed-off-by: Andy Yeh <andy.yeh@intel.com>
    Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>


Confirmed to work on 4.14 with the Identification Page
of an ST M24M02-DR (256 bytes but 16 bit addressing).

Cannot be cherry-picked trivially on 4.9.

The corresponding documentation commit 21d04054501fb27b56e995b54ac74e39aee79a46
can be cherry-picked to 4.18, the backport for 4.14 is below.

Thanks
Adrian


>From 2562e333f39b8077ffb06bdf79430f10b74c11f5 Mon Sep 17 00:00:00 2001
From: Alan Chiang <alanx.chiang@intel.com>
Date: Wed, 25 Jul 2018 11:20:21 +0800
Subject: [PATCH] dt-bindings: at24: Add address-width property

Currently the only way to use a variant of a supported model with
a different address width is to define a new compatible string and
the corresponding chip data structure.

Provide a flexible way to specify the size of the address pointer
by defining a new property: address-width.

Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
Signed-off-by: Andy Yeh <andy.yeh@intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
[Bartosz: fixed the commit message]
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
[Adrian Bunk: backported to 4.14]
Signed-off-by: Adrian Bunk <bunk@kernel.org>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index afc04589eadf..44bfffc43bed 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -36,6 +36,8 @@ Optional properties:
 
   - read-only: this parameterless property disables writes to the eeprom
 
+  - address-width: number of address bits (one of 8, 16).
+
 Example:
 
 eeprom@52 {
-- 
2.11.0
