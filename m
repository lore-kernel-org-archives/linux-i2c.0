From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 0/5] i2c: meson-axg: add I2C controller driver
Date: Fri, 17 Nov 2017 16:02:31 +0800
Message-ID: <20171117080236.32504-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:57064 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964975AbdKQIDK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 03:03:10 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Yixun Lan <yixun.lan@amlogic.com>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This patch set try to add I2C controller driver for
the Amlogic's Meson-AXG SoC.

Jian Hu (5):
  dt-bindings: i2c: update documentation for the Meson-AXG
  i2c: meson: add configurable divider factors
  ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC
  ARM64: dts: meson-axg: describe pin DT info for I2C controller
  ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker

 .../devicetree/bindings/i2c/i2c-meson.txt          |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   6 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 123 +++++++++++++++++++++
 drivers/i2c/busses/i2c-meson.c                     |  32 +++++-
 4 files changed, 158 insertions(+), 4 deletions(-)

-- 
2.14.1
