From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v10 0/8] add i2c driver supported for rk3399
Date: Mon, 16 May 2016 21:57:35 +0800
Message-ID: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

There are three points differert from others:
 - new method to caculate i2c timings for rk3399
 - pclk and function clk are separated at rk3399
 - add fast-plus mode supported for rk3399

David Wu (8):
  i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
  i2c: rk3x: use struct "rk3x_i2c_calced_timings"
  i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
  i2c: rk3x: Change SoC data to not use array
  i2c: rk3x: Move spec timing data to "static const" structs
  dt-bindings: i2c: rk3x: add support for rk3399
  i2c: rk3x: add i2c support for rk3399 soc
  i2c: rk3x: support fast-mode plus for rk3399

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  16 +-
 drivers/i2c/busses/i2c-rk3x.c                      | 498 +++++++++++++++++----
 2 files changed, 434 insertions(+), 80 deletions(-)

-- 
1.9.1
