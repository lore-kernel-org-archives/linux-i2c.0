From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH 0/4] i2c-xlp9xx Add support for SMBAlert and minor fixes
Date: Wed, 16 May 2018 00:00:15 -0700
Message-ID: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, jglauber@cavium.com, kamlakant.patel@cavium.com, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linus.walleij@linaro.org, rdunlap@infradead.org, george.cherian@cavium.com
List-Id: linux-i2c@vger.kernel.org

This series adds the SMBAlert support for i2c-xlp9xx driver and the following
fixes.

Patch 2: Make sure we update the transfer length to a future length.

Patch 3: Restrict the transfer size to I2C_SMBUS_BLOCK_SIZE for transfers
with I2C_M_RECV_LEN is set.

Patch 4: While at that update the MAINATINERS file to reflect the current
maintainers of the driver.

George Cherian (4):
  i2c: xlp9xx: Add support for SMBAlert
  i2c: xlp9xx: Fix issue seen when updating receive length
  i2c: xlp9xx: Make sure the transfer size is not more than
    I2C_SMBUS_BLOCK_SIZE
  i2c: xlp9xx: Add MAINTAINERS entry

 MAINTAINERS                     |  8 ++++
 drivers/i2c/busses/i2c-xlp9xx.c | 89 +++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 21 deletions(-)

-- 
1.8.3.1
