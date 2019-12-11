From: Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 0/2] power: supply: add support for CW2015 Fuel Gauge
Date: Wed, 11 Dec 2019 14:39:28 +0100
Message-ID: <20191211133930.7488-1-t.schramm@manjaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org
Cc: anarsoul@gmail.com, sre@kernel.org, pali.rohar@gmail.com, david@lechnology.com, afd@ti.com, Tobias Schramm <t.schramm@manjaro.org>
List-Id: linux-i2c@vger.kernel.org

This patchset adds support for the CW2015 Fuel Gauge.
The CW2015 fuel gauge is used in Pinebook Pro and some Raspberry Pi UPS HATs.

Most of the code has been written by Rockchip. I've added devicetree support
for power supplies as well as the alert level and done some general code
cleanup.
I'm submitting it now as part of an effort to get full mainline Linux support
for the Pinebook Pro.

CCing some maintainers of other fuel gauge drivers here to get feedback on this
patch.

Tobias Schramm (2):
  power: supply: add CW2015 Fuel Gauge driver
  dt-bindings: power: supply: cw2015_battery: add device tree binding
    documentation

 .../bindings/power/supply/cw2015_battery.txt  |  37 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2015_battery.c         | 962 ++++++++++++++++++
 include/linux/power/cw2015_battery.h          | 122 +++
 5 files changed, 1129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.txt
 create mode 100644 drivers/power/supply/cw2015_battery.c
 create mode 100644 include/linux/power/cw2015_battery.h

-- 
2.24.0
