From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/2] check I2C device id for pca984x chips
Date: Mon,  5 Mar 2018 21:58:20 +0100
Message-ID: <20180305205822.951-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi!

This series tries to check the I2C device id, but instead of open
coding the check in the pca954x driver, I have a new function in
the core doing the work.

Changes since v1:
- Added Tested-by tag from Adrian
- Added Reviewed-by tag from Wolfram
- Replaced client->flags with a zero in the i2c_smbus_xfer call

Wolfram: I'll send a pull with the first patch in a few days, to
allow for a second round of feedback now that the RFC marker is gone.

Cheers,
peda

Peter Rosin (2):
  i2c: add i2c_get_device_id() to get the standard i2c device id
  i2c: mux: pca954x: verify the device id of the pca984x chips

 drivers/i2c/i2c-core-base.c         | 33 ++++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-pca954x.c | 55 +++++++++++++++++++++++++++++++++----
 include/linux/i2c.h                 | 30 ++++++++++++++++++++
 3 files changed, 112 insertions(+), 6 deletions(-)

-- 
2.11.0
