From: Jian Hu <jian.hu@amlogic.com>
Subject: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c controller
Date: Thu, 29 Nov 2018 18:59:54 +0800
Message-ID: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Jianxin Pan <jianxin.pan@amlogic.com>, Hanjie Lin <hanjie.lin@amlogic.com>, linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

1)Add G12A SoC i2c compatible string in dt-bindings.
2)Add compatible and data for G12A I2C controller driver.

Jian Hu (2):
  dt-bindings: i2c: meson: add Meson G12A SoC i2c compatible string
  i2c: meson: add support for Meson G12A SoC I2C controller

 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
 drivers/i2c/busses/i2c-meson.c                      | 5 +++++
 2 files changed, 6 insertions(+)

-- 
1.9.1
