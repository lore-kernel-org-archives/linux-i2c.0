From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v3 0/6] i2c bus recovery for Microchip SoCs
Date: Wed, 15 Jan 2020 13:54:16 +0200
Message-ID: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kamel.bouhara@bootlin.com, wsa@the-dreams.de, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org, peda@axentia.se, linux@armlinux.org.uk, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: linux-i2c@vger.kernel.org

This patch series introduce the i2c bus recovery mechanism
for the Microchip SoCs. Some SoCs have hardware support for
recovery, while for those who don't the i2c-gpio bus recovery
mechanism is used. Updated the corresponding dts to add i2c
gpio pinctrl. The bus recovery is configured for the sama5d2/3/4
xplained and sama5d27 som1 EK boards in dts.

Changes in v3:
 - addressed list comments:
  - removed pull-ups from gpios;
  - removed unused headers from i2c-at91.h;
  - fixed commit message and subject on patch 3/6;
  - added received tags;
 - rebased on top of i2c/for-next;

Changes in v2:
 - integrated the HW CLEAR command patch;
 - call i2c_recover_bus() after an error occurs, if SDA is down;
 - added i2c gpio pinctrl in sama5d2 xplained and sama5d27 som1 EK
   boards;

Codrin Ciubotariu (1):
  i2c: at91: Send bus clear command if SDA is down

Kamel Bouhara (5):
  dt-bindings: i2c: at91: document optional bus recovery properties
  i2c: at91: implement i2c bus recovery
  ARM: at91/dt: sama5d3: add i2c gpio pinctrl
  ARM: at91/dt: sama5d4: add i2c gpio pinctrl
  ARM: at91/dt: sama5d2: add i2c gpio pinctrl

 .../devicetree/bindings/i2c/i2c-at91.txt      |  10 ++
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |  33 +++++-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |  33 +++++-
 arch/arm/boot/dts/sama5d3.dtsi                |  33 +++++-
 arch/arm/boot/dts/sama5d4.dtsi                |  33 +++++-
 drivers/i2c/busses/i2c-at91-core.c            |   2 +
 drivers/i2c/busses/i2c-at91-master.c          | 100 ++++++++++++++++++
 drivers/i2c/busses/i2c-at91.h                 |  11 +-
 8 files changed, 242 insertions(+), 13 deletions(-)

-- 
2.20.1
