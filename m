From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] don't check number of I2C messages in drivers
Date: Sun, 20 May 2018 08:50:32 +0200
Message-ID: <20180520065035.7920-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

The core does it now, we can simplify drivers.

Wolfram Sang (2):
  i2c: ibm_iic: don't check number of messages in the driver
  i2c: opal: don't check number of messages in the driver

 drivers/i2c/busses/i2c-ibm_iic.c | 3 ---
 drivers/i2c/busses/i2c-opal.c    | 4 ----
 2 files changed, 7 deletions(-)

-- 
2.11.0
