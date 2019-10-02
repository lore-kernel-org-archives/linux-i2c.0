From: Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 0/4] i2c bus recovery for Microchip SoCs.
Date: Wed,  2 Oct 2019 16:46:54 +0200
Message-ID: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Kamel Bouhara <kamel.bouhara@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

This patch series introduce the kernel i2c-gpio bus recovery mechanism
for the Microchip SoCs. Updated the corresponding dts to add i2c
gpio pinctrl. The bus recovery is configured for the sama5d3/4 xplained
boards in dts.

Kamel Bouhara (4):
  dt-bindings: i2c: at91: document optional bus recovery properties
  i2c: at91: implement i2c bus recovery
  ARM: at91/dt: sama5d3: add i2c gpio pinctrl
  ARM: at91/dt: sama5d4: add i2c gpio pinctrl

 .../devicetree/bindings/i2c/i2c-at91.txt      | 10 +++
 arch/arm/boot/dts/sama5d3.dtsi                | 33 +++++++++-
 arch/arm/boot/dts/sama5d4.dtsi                | 33 +++++++++-
 drivers/i2c/busses/i2c-at91-master.c          | 63 +++++++++++++++++++
 drivers/i2c/busses/i2c-at91.h                 |  8 +++
 5 files changed, 141 insertions(+), 6 deletions(-)

--
2.23.0
