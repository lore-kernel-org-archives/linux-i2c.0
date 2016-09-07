From: <jim_baxter@mentor.com>
Subject: [PATCH v1 0/2] i2c: Stop i2c modules being unloaded while in use.
Date: Wed, 7 Sep 2016 21:05:27 +0100
Message-ID: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Jim Baxter <jim_baxter@mentor.com>

This patchset adds a new i2c_mux_add_reparented_adapter API to the i2c
that allows owning modules to use module_get/module_put and stop the
i2c bus module being removed whilst in use.

This was tested on an ARM i.MX6 Sabre board with the pca953x gpio module.

Joshua Frkuska (2):
  i2c-mux: add i2c_mux_add_reparented_adapter api
  i2c-mux-gpio: call i2c_add_reparented_mux_adapter

 drivers/i2c/i2c-mux.c            | 14 ++++++++++++--
 drivers/i2c/muxes/i2c-mux-gpio.c |  6 +++++-
 include/linux/i2c-mux.h          | 15 +++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

-- 
1.9.1
