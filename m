From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [RFC 0/3] Portable Device Tree Connector
Date: Fri,  3 Jun 2016 23:37:50 +0300
Message-ID: <1464986273-12039-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <stephen.boyd@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org

This patchset introduces a portable device tree based connector.
It allows definition of a connector in a portable format so that
hardware expansion boards that utilize it can use the same
DT hardware definitions unchanged for all the boards that
have the same kind of connector.

It completely abstracts away the baseboard implementation details
and allows one to describe the expansion board in it's isolated
domain without having to figure out the per-board specific
hardware configuration.

The first patchset is the implementation while the next two
define a connector for the beaglebone board.

There was a session at ELC2016 with the slides at
http://elinux.org/images/d/d0/Panto.pdf

This patchset is dependent on the previous two patchset I sent out
some time ago.

"of: dynamic: Changesets helpers & fixes"
"gpio: of: Support cascaded GPIO"

Pantelis Antoniou (3):
  of: Portable Device Tree connector
  dts: Beaglebone portable connector definitions
  dts: beaglebone: Portable connector BB_RELAY_4PORT definition

 arch/arm/boot/dts/am335x-bone-common.dtsi | 1678 +++++++++++++++++++++++++++++
 drivers/extcon/Kconfig                    |   20 +
 drivers/extcon/Makefile                   |    3 +
 drivers/extcon/extcon-dt-con-gpio.c       |  337 ++++++
 drivers/extcon/extcon-dt-con-proxy.c      |  480 +++++++++
 drivers/extcon/extcon-dt-con.c            |  491 +++++++++
 drivers/extcon/extcon-dt-con.h            |   93 ++
 7 files changed, 3102 insertions(+)
 create mode 100644 drivers/extcon/extcon-dt-con-gpio.c
 create mode 100644 drivers/extcon/extcon-dt-con-proxy.c
 create mode 100644 drivers/extcon/extcon-dt-con.c
 create mode 100644 drivers/extcon/extcon-dt-con.h

-- 
1.7.12
