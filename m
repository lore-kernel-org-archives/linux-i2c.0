From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH v2 0/6] i2c bus recovery for Microchip SoCs
Date: Fri, 3 Jan 2020 09:49:06 +0000
Message-ID: <20200103094821.13185-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kamel.bouhara@bootlin.com, wsa@the-dreams.de, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: linux-i2c@vger.kernel.org

This patch series introduce the i2c bus recovery mechanism
for the Microchip SoCs. Some SoCs have hardware support for
recovery, while for those who don't the i2c-gpio bus recovery
mechanism is used. Updated the corresponding dts to add i2c
gpio pinctrl. The bus recovery is configured for the sama5d2/3/4
xplained and sama5d27 som1 EK boards in dts.

Changes in v2:
 - integrated the HW CLEAR command patch;
 - call i2c_recover_bus() after an error occurs, if SDA is down;
 - added i2c gpio pinctrl in sama5d2 xplained and sama5d27 som1 EK
   boards;


Codrin Ciubotariu (1):
  i2c: at91: Send bus clear command if SCL is down

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
 drivers/i2c/busses/i2c-at91-core.c            |   9 ++
 drivers/i2c/busses/i2c-at91-master.c          | 101 ++++++++++++++++++
 drivers/i2c/busses/i2c-at91.h                 |  15 ++-
 8 files changed, 254 insertions(+), 13 deletions(-)

--=20
2.20.1
