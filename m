From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] eeprom: at24: rename binding docs
Date: Wed, 29 Nov 2017 10:04:40 +0100
Message-ID: <20171129090442.2865-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54217 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbdK2JFH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Nov 2017 04:05:07 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>

As discussed previously (and pre-acked by Bartosz), here is a small series to
rename the binding docs for at24 properly and add the new name to MAINTAINERS
file. Hope I didn't miss something.

Kind regards,

   Wolfram

Wolfram Sang (2):
  dt-bindings: eeprom: rename to at24.txt
  MAINTAINERS: add DT binding docs for AT24

 Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} | 0
 MAINTAINERS                                                       | 1 +
 2 files changed, 1 insertion(+)
 rename Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} (100%)

-- 
2.11.0
