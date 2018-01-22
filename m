From: Peter Rosin <peda@axentia.se>
Subject: [RFC PATCH 0/2] check I2C device id for pca984x chips
Date: Mon, 22 Jan 2018 12:36:55 +0100
Message-ID: <20180122113657.32094-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Fiergolski <adrian.fiergolski@cern.ch>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi!

This series tries to check the I2C device id, but instead of open
coding the check in the pca954x driver, I have a new function in
the core doing the work.

The code is only compile-tested, hence the RFC, and I would really
like a Tested-by: tag from Adrian who presumably have one of these
chips.

Also, I'm not sure if I should list all manufacturers that I know
about in the header, or if I should settle for the one that is
actually used and leave the others to be added by whomever needs
them...

Cheers,
peda

Peter Rosin (2):
  i2c: add i2c_get_device_id() to get the standard i2c device id
  i2c: mux: pca954x: verify the device id of the pca984x chips

 drivers/i2c/i2c-core-base.c         | 33 ++++++++++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-pca954x.c | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h                 | 30 ++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

-- 
2.11.0
