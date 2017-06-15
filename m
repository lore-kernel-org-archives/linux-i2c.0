From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/4] i2c: document DMA handling and add helpers for it
Date: Thu, 15 Jun 2017 20:30:35 +0200
Message-ID: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

So, after revisiting old mail threads and taking part in a similar discussion
on the USB list, here is what I cooked up to document and ease DMA handling for
I2C within Linux. Please have a look at the documentation introduced in patch 2
for further details.

The branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/i2c-core-dma

And big kudos to Renesas Electronics for funding this work, thank you very much!

Regards,

   Wolfram

Changes since RFC:

* the helper i2c_check_msg_for_dma() can optionally take a pointer and then it
  will attach a bounce buffer to it in case the message buffer is not DMA safe
* a second helper was added. i2c_release_bounce_buf() will copy data back to
  the message buffer and release the bounce buffer
* the documentation has been extended to match the above
* no ifdeffery around CONFIG_DMA_API_DEBUG anymore. The I2C core behaviour
  should not depend on such symbols.
* the i2c-sh_mobile driver has been updated to use bounce buffers


Wolfram Sang (4):
  i2c: add helpers to ease DMA handling
  i2c: add docs to clarify DMA handling
  i2c: sh_mobile: use helper to decide if DMA is useful
  i2c: rcar: check for DMA-capable buffers

 Documentation/i2c/DMA-considerations | 37 ++++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c        | 18 +++++++---
 drivers/i2c/busses/i2c-sh_mobile.c   |  8 +++--
 include/linux/i2c.h                  | 65 ++++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/i2c/DMA-considerations

-- 
2.11.0
