From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [PATCH 00/10] Introduce Juniper PTXPMB CPLD driver
Date: Fri,  7 Oct 2016 18:17:21 +0300
Message-ID: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Debjit Ghosh <dghosh@juniper.net>, Georgi Vlaev <gvlaev@juniper.net>, Rajat Jain <rajatjain@juniper.net>, Guenter Roeck <groeck@juniper.net>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

Add Juniper's PTXPMB FPGA CPLD driver. Those FPGAs
are present in Juniper's PTX series of routers.

The MFD driver provices watchdog/i2c/gpio/mtd devices.

There are full device tree binding documents for the
master mfd driver and for all slave drivers.

This patchset is against mainline as of today: v4.8-9431-g3477d16
and is dependent on the "Juniper prerequisites" and
"Juniper infrastructure" patchsets sent earlier.

Georgi Vlaev (5):
  mfd: ptxpmb-cpld: Add documentation for PTXPMB CPLD
  watchdog: ptxpmb-wdt: Add ptxpmb-wdt device tree bindings
  i2c: i2c-mux-ptxpmb-cpld: Add device tree bindings
  gpio: ptxpmb-cpld: Document bindings of PTXPMB's CPLD GPIO
  mtd: ngpmb_nvram: Add bindings for Juniper's ngpmb NVRAM

Guenter Roeck (4):
  mfd: Juniper PTXPMB CPLD Multi-function core driver
  watchdog: Add support for PTXPMB CPLD watchdog
  i2c/muxes: Juniper's PTXPMB CPLD I2C multiplexer
  gpio: ptxpmb-cpld: Add support for PTXPMB CPLD's GPIO

JawaharBalaji Thirumalaisamy (1):
  mtd: devices: Add driver for memory mapped NVRAM on FPC

 .../bindings/gpio/jnx,gpio-ptxpmb-cpld.txt         |  30 ++
 .../bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt       |  50 +++
 .../devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt    |  76 ++++
 .../devicetree/bindings/mtd/ngpmb-nvram.txt        |  22 ++
 .../bindings/watchdog/jnx-ptxpmb-wdt.txt           |  17 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-ptxpmb-cpld.c                    | 177 +++++++++
 drivers/i2c/muxes/Kconfig                          |  11 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-mux-ptxpmb.c                 | 299 +++++++++++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/ptxpmb-cpld-core.c                     | 406 +++++++++++++++++++++
 drivers/mtd/devices/Kconfig                        |  11 +
 drivers/mtd/devices/Makefile                       |   1 +
 drivers/mtd/devices/jnx_pmb_nvram.c                | 191 ++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ptxpmb_wdt.c                      | 283 ++++++++++++++
 include/linux/mfd/ptxpmb_cpld.h                    | 140 +++++++
 21 files changed, 1756 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/jnx,gpio-ptxpmb-cpld.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ngpmb-nvram.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt
 create mode 100644 drivers/gpio/gpio-ptxpmb-cpld.c
 create mode 100644 drivers/i2c/muxes/i2c-mux-ptxpmb.c
 create mode 100644 drivers/mfd/ptxpmb-cpld-core.c
 create mode 100644 drivers/mtd/devices/jnx_pmb_nvram.c
 create mode 100644 drivers/watchdog/ptxpmb_wdt.c
 create mode 100644 include/linux/mfd/ptxpmb_cpld.h

-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
