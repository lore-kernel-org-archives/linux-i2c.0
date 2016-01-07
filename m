From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] dt-bindings: refactor i2c eeprom bindings, step 1
Date: Thu,  7 Jan 2016 21:50:58 +0100
Message-ID: <1452199860-3601-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

A first step to clean up the bindings for i2c eeproms. Please see the patch
descriptions for further details.

I suggest I take these via my i2c tree. D'accord?

Thanks,

   Wolfram


Wolfram Sang (2):
  dt-bindings: move I2C eeprom descriptions to the proper file
  dt-bindings: i2c: eeprom: add another EEPROM device

 Documentation/devicetree/bindings/eeprom/eeprom.txt | 21 ++++++++++++++++-----
 .../devicetree/bindings/i2c/trivial-devices.txt     | 13 -------------
 2 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.1.4
