From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/13] i2c: Use devm_*() functions
Date: Tue, 17 Dec 2013 15:45:30 +0900
Message-ID: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Jingoo Han (13):
      i2c: bcm2835: Use devm_request_irq()
      i2c: gpio: Use devm_gpio_request()
      i2c: highlander: Use devm_*() functions
      i2c: isch: Use devm_request_region()
      i2c: mv64xxx: Use devm_request_irq()
      i2c: pmcmsp: Use devm_*() functions
      i2c: pnx: Use devm_*() functions
      i2c: pxa: Use devm_*() functions
      i2c: simtec: Use devm_*() functions
      i2c: sirf: Use devm_clk_get()
      i2c: versatile: Use devm_*() functions
      i2c: viperboard: Use devm_kzalloc() functions
      i2c: xiic: Use devm_*() functions

---
 drivers/i2c/busses/i2c-bcm2835.c    |    7 ++--
 drivers/i2c/busses/i2c-gpio.c       |   25 ++++---------
 drivers/i2c/busses/i2c-highlander.c |   38 ++++++--------------
 drivers/i2c/busses/i2c-isch.c       |    5 ++-
 drivers/i2c/busses/i2c-mv64xxx.c    |    9 ++---
 drivers/i2c/busses/i2c-pmcmsp.c     |   44 ++++-------------------
 drivers/i2c/busses/i2c-pnx.c        |   56 +++++++++--------------------
 drivers/i2c/busses/i2c-pxa.c        |   66 ++++++++++-------------------------
 drivers/i2c/busses/i2c-simtec.c     |   43 ++++-------------------
 drivers/i2c/busses/i2c-sirf.c       |   11 ++----
 drivers/i2c/busses/i2c-versatile.c  |   33 +++++-------------
 drivers/i2c/busses/i2c-viperboard.c |   12 ++-----
 drivers/i2c/busses/i2c-xiic.c       |   59 +++++++++----------------------
 13 files changed, 104 insertions(+), 304 deletions(-)
