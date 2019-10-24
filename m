From: Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v2 0/5] Add i2c bus recovery support for Atmel SoCs
Date: Thu, 24 Oct 2019 22:12:57 +0200
Message-ID: <20191024201302.23376-1-kamel.bouhara@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Kamel Bouhara <kamel.bouhara@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Some Atmel SoCs actually doesn't support the clear command for recovery.
This patch serie merge the two support for both i2c bus recovery
mechanism (clear command and gpio/pinctrl).

Codrin Ciubotariu (1):
  i2c: at91: Send bus clear command if SCL or SDA is down

Kamel Bouhara (4):
  dt-bindings: i2c: at91: document optional bus recovery properties
  i2c: at91: implement i2c bus recovery
  ARM: at91/dt: sama5d3: add i2c gpio pinctrl
  ARM: at91/dt: sama5d4: add i2c gpio pinctrl

 .../devicetree/bindings/i2c/i2c-at91.txt      | 10 +++
 arch/arm/boot/dts/sama5d3.dtsi                | 33 ++++++-
 arch/arm/boot/dts/sama5d4.dtsi                | 33 ++++++-
 drivers/i2c/busses/i2c-at91-core.c            |  8 ++
 drivers/i2c/busses/i2c-at91-master.c          | 86 +++++++++++++++++++
 drivers/i2c/busses/i2c-at91.h                 | 15 +++-
 6 files changed, 178 insertions(+), 7 deletions(-)

--
2.23.0
