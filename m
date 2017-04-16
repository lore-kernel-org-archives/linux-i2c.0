From: Peter Rosin <peda@lysator.liu.se>
Subject: [PULL REQUEST] i2c-mux for v4.12-rc1
Date: Sun, 16 Apr 2017 08:57:29 +0200
Message-ID: <b940923b-4213-949d-3d87-79703c202492@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:36957 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdDPHCm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 16 Apr 2017 03:02:42 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi Wolfram,

Here are a new LTC4306/5 driver, a fix needed by the RT kernel and some
error message cleanup.

Please pull.

Cheers,
peda

The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:

  Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux/for-next

for you to fetch changes up to dbed8a803bd3fb64339a6180adaff2cec46242ce:

  i2c: mux: ltc4306: LTC4306 and LTC4305 I2C multiplexer/switch (2017-04-12 17:10:31 +0200)

----------------------------------------------------------------
Julia Cartwright (1):
      i2c: mux: pca954x: make use of raw_spinlock variants

Michael Hennerich (2):
      dt-bindings: i2c: mux: ltc4306: Add dt-bindings for I2C multiplexer/switch
      i2c: mux: ltc4306: LTC4306 and LTC4305 I2C multiplexer/switch

Peter Rosin (7):
      i2c: mux: provide more info on failure in i2c_mux_add_adapter
      i2c: arb: gpio-challenge: stop double error reporting
      i2c: mux: gpio: stop double error reporting
      i2c: mux: pca9541: stop double error reporting
      i2c: mux: pca954x: stop double error reporting
      i2c: mux: pinctrl: stop double error reporting
      i2c: mux: reg: stop double error reporting

 .../devicetree/bindings/i2c/i2c-mux-ltc4306.txt    |  61 ++++
 MAINTAINERS                                        |   8 +
 drivers/i2c/i2c-mux.c                              |   9 +-
 drivers/i2c/muxes/Kconfig                          |  11 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |   4 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                   |   4 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c                | 322 +++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-pca9541.c                |   4 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  19 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |   4 +-
 drivers/i2c/muxes/i2c-mux-reg.c                    |   4 +-
 12 files changed, 421 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 create mode 100644 drivers/i2c/muxes/i2c-mux-ltc4306.c
