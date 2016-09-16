From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Fri, 16 Sep 2016 18:02:41 +0200
Message-ID: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38206 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbcIPQDC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Sep 2016 12:03:02 -0400
Received: by mail-wm0-f44.google.com with SMTP id 1so50078174wmz.1
        for <linux-i2c@vger.kernel.org>; Fri, 16 Sep 2016 09:03:02 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
when there's a second expander using the same device driver on one of
the I2C bus segments, lockdep prints a deadlock warning when trying to
set the direction or the value of the GPIOs provided by the second
expander.

This series exports an already existing function from i2c-core as
public API and reuses it in pca953x to pass a correct lock subclass
to lockdep.

Note: if this series gets merged, I'll prepare follow-up patches for
other expanders for which a similar problem could potentially occur.

Tested with the following setup:

 -------             ---------  Bus segment 1 |         |
|       |           |         |---------------  Devices
|       | SCL/SDA   |         |               |         |
| Linux |-----------| I2C MUX |                - - - - -
|       |    |      |         | Bus segment 2
|       |    |      |         |-------------------
 -------     |       ---------                    |
             |           |                    - - - - -
        ------------     | MUX GPIO          |         |
       |            |    |                     Devices
       |    GPIO    |    |                   |         |
       | Expander 1 |----                     - - - - -
       |            |                             |
        ------------                              | SCL/SDA
                                                  |
                                             ------------
                                            |            |
                                            |    GPIO    |
                                            | Expander 2 |
                                            |            |
                                             ------------

where expander 1 is a pca9534 and expander 2 is a pca9535.

v1 -> v2:
- added patches 1/4, 2/4 & 3/4
- used i2c_adapter_depth() in patch 4/4 in order to detect multiple
  adapter nesting

Bartosz Golaszewski (4):
  i2c: export i2c_adapter_depth()
  lockdep: make MAX_LOCKDEP_SUBCLASSES unconditionally visible
  i2c: add a warning to i2c_adapter_depth()
  gpio: pca953x: fix an incorrect lockdep warning

 drivers/gpio/gpio-pca953x.c |  2 ++
 drivers/i2c/i2c-core.c      | 12 +++++-------
 include/linux/i2c.h         |  1 +
 include/linux/lockdep.h     |  4 ++--
 4 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.7.4
