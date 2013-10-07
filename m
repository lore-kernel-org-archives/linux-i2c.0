From: "Tim Kryger" <tim.kryger@linaro.org>
Subject: [PATCH 0/4] Add-Broadcom-Kona-I2C-Support
Date: Mon, 7 Oct 2013 12:14:57 -0700
Message-ID: <1381173301-23830-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Daudt <bcm@fixthebug.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>
Cc: Tim Kryger <tim.kryger@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This series adds support for the Kona I2C bus found on Broadcom mobile
SoCs like the bcm11351 (aka bcm281xx) and enables it on the bcm28155-ap
board.

It depends upon the following commits:
  https://lkml.org/lkml/2013/10/7/481
  http://www.spinics.net/lists/arm-kernel/msg274964.html

Tim Kryger (4):
  i2c: i2c-bcm-kona: Introduce Broadcom I2C Driver
  i2c: i2c-bcm-kona: Add support for high-speed mode
  ARM: dts: bcm281xx: Add i2c busses
  ARM: dts: bcm28155-ap: Enable all the i2c busses

 .../devicetree/bindings/i2c/i2c-bcm-kona.txt       |  30 +
 arch/arm/boot/dts/bcm11351.dtsi                    |  40 +
 arch/arm/boot/dts/bcm28155-ap.dts                  |  20 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-bcm-kona.c                  | 936 +++++++++++++++++++++
 6 files changed, 1037 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-bcm-kona.txt
 create mode 100644 drivers/i2c/busses/i2c-bcm-kona.c

-- 
1.8.0.1
