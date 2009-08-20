From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCHv2 0/3] Adding TI TPS PMICs support in the regulator framework
Date: Thu, 20 Aug 2009 19:20:11 +0530
Message-ID: <1250776211-27797-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: broonie@sirena.org.uk, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, tony@atomide.com, linux-i2c@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>
List-Id: linux-i2c@vger.kernel.org

This patch set adds support for TI TPS65023 and TPS6507x PMICs in the voltage
regulator framework. The patches also take care of the comments received
earlier.

Anuj Aggarwal (3):
  Regulator: Add TPS65023 regulator driver
  Regulator: Add TPS6507x regulator driver
  Regulator: Adding TPS65023 and TPS6507x in Kconfig and Makefile

 drivers/regulator/Kconfig              |   16 +
 drivers/regulator/Makefile             |    3 +
 drivers/regulator/tps65023-regulator.c |  631 ++++++++++++++++++++++++++++
 drivers/regulator/tps6507x-regulator.c |  713 ++++++++++++++++++++++++++++++++
 4 files changed, 1363 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/tps65023-regulator.c
 create mode 100644 drivers/regulator/tps6507x-regulator.c

