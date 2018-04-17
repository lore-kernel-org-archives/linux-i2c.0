From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/4] i2c: mux: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:29 +0200
Message-ID: <20180417143233.25145-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Michael Hennerich <michael.hennerich@analog.com>, Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi!

4 trivial patches that switches the existing i2c-mux drivers
that are also i2c clients over to the new probe style.

Cheers,
Peter

Peter Rosin (4):
  i2c: mux: ltc4306: switch to using .probe_new
  i2c: mux: mlxcpld: switch to using .probe_new
  i2c: mux: pca9541: switch to using .probe_new
  i2c: mux: pca954x: switch to using .probe_new

 drivers/i2c/muxes/i2c-mux-ltc4306.c | 7 +++----
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 5 ++---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 5 ++---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 7 +++----
 4 files changed, 10 insertions(+), 14 deletions(-)

-- 
2.11.0
