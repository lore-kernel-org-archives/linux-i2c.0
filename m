From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v5 0/2] updates for rk3399 i2c support
Date: Thu, 17 Mar 2016 00:57:16 +0800
Message-ID: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, david.wu@rock-chips.com
List-Id: linux-i2c@vger.kernel.org

David Wu (2):
  i2c: rk3x: switch to i2c generic dt parsing
  i2c: rk3x: add i2c support for rk3399 soc

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  32 +-
 drivers/i2c/busses/i2c-rk3x.c                      | 524 ++++++++++++++++-----
 2 files changed, 440 insertions(+), 116 deletions(-)

-- 
1.9.1
