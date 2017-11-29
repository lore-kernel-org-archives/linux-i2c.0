From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] MAINTAINERS: add DT binding docs for AT24
Date: Wed, 29 Nov 2017 10:04:42 +0100
Message-ID: <20171129090442.2865-3-wsa@the-dreams.de>
References: <20171129090442.2865-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54227 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752963AbdK2JFH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Nov 2017 04:05:07 -0500
In-Reply-To: <20171129090442.2865-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>

The driver gaines DT support recently, so we should add the binding docs
in the MAINTAINERS file.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76d1..c870f329613d04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2262,6 +2262,7 @@ AT24 EEPROM DRIVER
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/eeprom/at24.txt
 F:	drivers/misc/eeprom/at24.c
 F:	include/linux/platform_data/at24.h
 
-- 
2.11.0
