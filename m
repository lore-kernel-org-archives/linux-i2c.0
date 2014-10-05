From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH v2 0/2] i2c: add driver for Amlogic Meson I2C controller
Date: Sun,  5 Oct 2014 22:17:10 +0200
Message-ID: <1412540232-26168-1-git-send-email-b.galvani@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Carlo Caione <carlo@caione.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jerry Cao <jerry.cao@amlogic.com>, Victor Wan <victor.wan@amlogic.com>, Beniamino Galvani <b.galvani@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

this patchset adds a driver for the I2C controller available in
Amlogic Meson SoCs and has been tested on a Tronsmart Vega S89E TV box
to communicate with a Ricoh RN5T618 PMIC.

Changes since v1:
 - factored common code for token list setup

Beniamino Galvani (2):
  i2c: add support for Amlogic Meson I2C controller
  i2c: meson: add device tree bindings documentation

 .../devicetree/bindings/i2c/i2c-meson.txt          |  24 +
 drivers/i2c/busses/Kconfig                         |   7 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-meson.c                     | 492 +++++++++++++++++++++
 4 files changed, 524 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-meson.txt
 create mode 100644 drivers/i2c/busses/i2c-meson.c

-- 
1.9.1
