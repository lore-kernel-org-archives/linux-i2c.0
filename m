From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/4] i2c: document DMA handling and add helper
Date: Tue,  6 Jun 2017 11:20:30 +0200
Message-ID: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa@the-dreams.de>

So, after revisiting old mail threads and taking part in a similar discussion
on the USB list, here is an RFC on what I cooked together regarding DMA and I2C
in the Linux world.

I documented my reasoning with patch 2 which mentions a helper function which
gets added with patch 1. Patch 3 shows a super simple example with the
i2c-sh_mobile driver. And patch 4 shows a super complicated example with the
i2c-rcar driver. But it is nice to have such a corner case already in the
beginning of development.

Please let me know what you think. What I surely plan to add until next time is
to fix two central places in the I2C core where the data buffer for block
transfers is currently put on the stack.

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/i2c-core-dma

And big kudos to Renesas Electronics for funding this work, thank you very much!

Regards,

   Wolfram


Wolfram Sang (4):
  i2c: add helper to determine if DMA is favoured
  i2c: add docs to clarify DMA handling
  i2c: sh_mobile: use helper to decide if DMA is used
  i2c: rcar: check for DMA-capable buffers

 Documentation/i2c/DMA-considerations | 28 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c        | 18 +++++++++++++-----
 drivers/i2c/busses/i2c-sh_mobile.c   |  2 +-
 include/linux/i2c.h                  | 29 +++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/i2c/DMA-considerations

-- 
2.11.0
