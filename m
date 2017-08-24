From: Peter Rosin <peda@axentia.se>
Subject: [PULL REQUEST] i2c-mux for 4.14-rc1
Date: Thu, 24 Aug 2017 09:00:27 +0200
Message-ID: <11adddb0-7484-cd3a-9978-30054741c089@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr30132.outbound.protection.outlook.com ([40.107.3.132]:20788
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751114AbdHXHAf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Aug 2017 03:00:35 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram,

In this cycle, we have the following:
- header-file reshuffle
- pinctrl driver simplification
and a couple of small maintenance changes.

Please pull.

Cheers,
peda

The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e:

  Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux/for-next

for you to fetch changes up to fabf08a0cd63ce39287646ceea10ac34781418f4:

  i2c: mux: i2c-arb-gpio-challenge: allow compiling w/o OF support (2017-08-22 08:37:03 +0200)

----------------------------------------------------------------
Dan Carpenter (1):
      i2c: mux: pinctrl: potential NULL dereference on error

Peter Rosin (4):
      i2c: mux: pinctrl: remove platform_data
      i2c: mux: pinctrl: drop the idle_state member
      i2c: Documentation: i2c-topology: mention recent driver additions
      i2c: mux: i2c-arb-gpio-challenge: allow compiling w/o OF support

Wolfram Sang (3):
      i2c: mux: pca9541: sort include files
      i2c: mux: pca954x: move header file out of I2C realm
      i2c: mux: mlxcpld: move header file out of I2C realm

 Documentation/i2c/i2c-topology                     |   6 +
 drivers/i2c/muxes/Kconfig                          |   3 +-
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                |   2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                |   9 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                | 225 +++++++--------------
 include/linux/i2c-mux-pinctrl.h                    |  41 ----
 include/linux/{i2c => platform_data}/pca954x.h     |   0
 include/linux/{i2c => platform_data/x86}/mlxcpld.h |   0
 9 files changed, 86 insertions(+), 202 deletions(-)
 delete mode 100644 include/linux/i2c-mux-pinctrl.h
 rename include/linux/{i2c => platform_data}/pca954x.h (100%)
 rename include/linux/{i2c => platform_data/x86}/mlxcpld.h (100%)
