From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v2 0/4] Add I2C support to ST SoCs
Date: Thu, 26 Sep 2013 11:53:33 +0200
Message-ID: <1380189213-5667-1-git-send-email-maxime.coquelin@st.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, srinivas.kandagatla-qxv4g6HH51o@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: stephen.gallimore-qxv4g6HH51o@public.gmane.org, stuart.menefy-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, gabriel.fernandez-qxv4g6HH51o@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The goal of this series is to add I2C support to ST SoCs.
The DT definition is added for STiH415 and STiH416 SoCs on
B2000 and B2020 boards.

The series has been tested working on STiH416-B2020 board.
It applies on top of v3.12-rc1.

Changes since v1:
  - Anti-glitch filtering simplified (Only HW Anti-glitch is kept)
  - Update I2C timings to comply with I2C specification
  - Handle spurious interrupts properly
  - DT binding updates taking into account Stephen's comments
  - Use "clock-names" property to comply with GCF
  - DT cosmetic changes reported by Lee and Gabriel 

Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>

Maxime Coquelin (4):
  i2c: busses: i2c-st: Add ST I2C controller
  ARM: STi: Supply I2C configuration to STiH416 SoC
  ARM: STi: Supply I2C configuration to STiH415 SoC
  ARM: STi: Add I2C config to B2000 and B2020 boards

 Documentation/devicetree/bindings/i2c/i2c-st.txt |   37 ++
 arch/arm/boot/dts/stih415-pinctrl.dtsi           |   36 ++
 arch/arm/boot/dts/stih415.dtsi                   |   65 ++
 arch/arm/boot/dts/stih416-pinctrl.dtsi           |   35 ++
 arch/arm/boot/dts/stih416.dtsi                   |   65 ++
 arch/arm/boot/dts/stih41x-b2000.dtsi             |    7 +
 arch/arm/boot/dts/stih41x-b2020.dtsi             |   20 +
 drivers/i2c/busses/Kconfig                       |   10 +
 drivers/i2c/busses/Makefile                      |    1 +
 drivers/i2c/busses/i2c-st.c                      |  691 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-st.h                      |  208 +++++++
 11 files changed, 1175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-st.txt
 create mode 100644 drivers/i2c/busses/i2c-st.c
 create mode 100644 drivers/i2c/busses/i2c-st.h

-- 
1.7.9.5
