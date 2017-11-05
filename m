From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] ARM: pxa: move pxa-i2c.h to platform_data
Date: Sun,  5 Nov 2017 15:12:24 +0100
Message-ID: <20171105141226.13624-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47356 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbdKEOMi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 5 Nov 2017 09:12:38 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Wolfram Sang <wsa@the-dreams.de>

As discussed previously, we move the declarations now to devices.h and the
platform_data to the platform_data directory. Only build tested, but buildbot
is happy.

Wolfram Sang (2):
  ARM: pxa: move declarations to proper place
  ARM: pxa: move header file out of I2C realm

 arch/arm/mach-mmp/mmp2.h                                 |  2 +-
 arch/arm/mach-mmp/pxa168.h                               |  2 +-
 arch/arm/mach-mmp/pxa910.h                               |  2 +-
 arch/arm/mach-pxa/balloon3.c                             |  2 +-
 arch/arm/mach-pxa/cm-x300.c                              |  2 +-
 arch/arm/mach-pxa/colibri-evalboard.c                    |  2 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c                |  2 +-
 arch/arm/mach-pxa/corgi.c                                |  2 +-
 arch/arm/mach-pxa/csb726.c                               |  2 +-
 arch/arm/mach-pxa/devices.c                              |  2 +-
 arch/arm/mach-pxa/devices.h                              |  9 +++++++++
 arch/arm/mach-pxa/em-x270.c                              |  2 +-
 arch/arm/mach-pxa/ezx.c                                  |  2 +-
 arch/arm/mach-pxa/hx4700.c                               |  2 +-
 arch/arm/mach-pxa/littleton.c                            |  2 +-
 arch/arm/mach-pxa/magician.c                             |  2 +-
 arch/arm/mach-pxa/mainstone.c                            |  2 +-
 arch/arm/mach-pxa/mioa701.c                              |  2 +-
 arch/arm/mach-pxa/mxm8x10.c                              |  2 +-
 arch/arm/mach-pxa/palm27x.c                              |  2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c                     |  2 +-
 arch/arm/mach-pxa/poodle.c                               |  2 +-
 arch/arm/mach-pxa/pxa27x.c                               |  2 +-
 arch/arm/mach-pxa/pxa3xx.c                               |  2 +-
 arch/arm/mach-pxa/raumfeld.c                             |  2 +-
 arch/arm/mach-pxa/saar.c                                 |  2 +-
 arch/arm/mach-pxa/spitz.c                                |  2 +-
 arch/arm/mach-pxa/stargate2.c                            |  2 +-
 arch/arm/mach-pxa/tosa.c                                 |  2 +-
 arch/arm/mach-pxa/trizeps4.c                             |  2 +-
 arch/arm/mach-pxa/viper.c                                |  2 +-
 arch/arm/mach-pxa/vpac270.c                              |  2 +-
 arch/arm/mach-pxa/xcep.c                                 |  2 +-
 arch/arm/mach-pxa/z2.c                                   |  2 +-
 arch/arm/mach-pxa/zeus.c                                 |  3 ++-
 arch/arm/mach-pxa/zylonite_pxa300.c                      |  2 +-
 drivers/i2c/busses/i2c-pxa-pci.c                         |  2 +-
 drivers/i2c/busses/i2c-pxa.c                             |  2 +-
 include/linux/{i2c/pxa-i2c.h => platform_data/i2c-pxa.h} | 11 -----------
 39 files changed, 47 insertions(+), 48 deletions(-)
 rename include/linux/{i2c/pxa-i2c.h => platform_data/i2c-pxa.h} (90%)

-- 
2.11.0
