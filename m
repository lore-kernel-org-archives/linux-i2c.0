From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/5] i2c: rcar: Device Tree support and clock improvements
Date: Mon,  9 Sep 2013 17:55:15 +0200
Message-ID: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Device Tree support for i2c-rcar isn't too complex, only usual or standard
properties are used. Apart from it several clock handling improvements are
included in this patch series.

Developed on top of -next of 09.09.2013

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (5):
  i2c: rcar: (cosmetic) remove superfluous parenthesis
  i2c: rcar: get clock rate only once and simplify calculation
  i2c: rcar: add Device Tree support
  i2c: rcar: fix clk_get() error handling
  i2c: rcar: use per-device clock

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   22 +++++++++
 drivers/i2c/busses/i2c-rcar.c                      |   50 ++++++++++++++------
 2 files changed, 58 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rcar.txt

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
