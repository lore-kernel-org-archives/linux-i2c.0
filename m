From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 0/4] eeprom: at24: device tree support fixes
Date: Thu, 28 Dec 2017 11:49:09 +0100
Message-ID: <20171228104913.29873-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33787 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbdL1KtS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Dec 2017 05:49:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id g130so1420159wme.0
        for <linux-i2c@vger.kernel.org>; Thu, 28 Dec 2017 02:49:17 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

The first three patches fix certain issues with the DT binding
document.

The last two extend the device tree support in the driver with more
at24 EEPROM variants.

v1 -> v2:
- remove any implementation details from patch 1/5

v2 -> v3:
- reword patch 1/5: allow any "<manufacturer>,<vendor>" pair as long
  as a supported fallback is used

v3 -> v4:
- another shot at correct wording of the compatible property description
- squashed patches 1/5 and 2/5

Bartosz Golaszewski (4):
  dt-bindings: at24: consistently document the compatible property
  dt-bindings: at24: fix formatting and style
  dt-bindings: at24: extend the list of supported chips
  eeprom: at24: extend the list of chips supported in DT

 Documentation/devicetree/bindings/eeprom/at24.txt | 91 ++++++++++++++---------
 drivers/misc/eeprom/at24.c                        |  9 +++
 2 files changed, 66 insertions(+), 34 deletions(-)

-- 
2.15.1
