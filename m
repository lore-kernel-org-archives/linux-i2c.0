From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] dt-bindings: eeprom: rename to at24.txt
Date: Wed, 29 Nov 2017 10:04:41 +0100
Message-ID: <20171129090442.2865-2-wsa@the-dreams.de>
References: <20171129090442.2865-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54222 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdK2JFH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Nov 2017 04:05:07 -0500
In-Reply-To: <20171129090442.2865-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>

This binding documentation is for the at24 driver, so the filename
should reflect it. This avoids confusion because we also have an
"eeprom" driver in Linux but it doesn't support DT even.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} (100%)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
similarity index 100%
rename from Documentation/devicetree/bindings/eeprom/eeprom.txt
rename to Documentation/devicetree/bindings/eeprom/at24.txt
-- 
2.11.0
