From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date: Wed, 20 Jun 2018 10:51:52 +0200
Message-ID: <20180620085157.30121-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi!

There are a couple of users that could benefit from an unlocked variant
of i2c_smbus_xfer. In response to [1] I dusted off an old series that I
have had in a branch for a while that adds such a beast. It also converts
over some users in the i2c-mux department.

There are a couple of remaining candidates in i2c/busses/i2c-amd756-s4882.c
and i2c/busses/i2c-nforce2-s4985.c, but frankly, those are just too nasty.
Why do they unregister the root adapter and then continue to use it? I
dare not touch that code...

Anyway, this series looks like a nice cleanup to me, and the recent sccb
patch from Akinobu Mita could also benefit, as indicated by Wolfram [1].

Cheers,
Peter

[1] https://patchwork.ozlabs.org/patch/928386/#1936016

Peter Rosin (5):
  i2c: smbus: add unlocked __i2c_smbus_xfer variant
  i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
  i2c: mux: pca9541: make use of __i2c_smbus_xfer
  i2c: mux: pca954x: make use of __i2c_smbus_xfer
  i2c: mux: make use of __i2c_smbus_xfer

 drivers/i2c/i2c-core-smbus.c        | 28 ++++++++++-----
 drivers/i2c/i2c-mux.c               |  4 +--
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 28 +++------------
 drivers/i2c/muxes/i2c-mux-pca9541.c | 69 ++++++-------------------------------
 drivers/i2c/muxes/i2c-mux-pca954x.c | 27 +++------------
 include/linux/i2c.h                 | 11 ++++--
 6 files changed, 49 insertions(+), 118 deletions(-)

-- 
2.11.0
