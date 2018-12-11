From: Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v3 0/4] Add Actions Semi Owl family S700 I2C support
Date: Tue, 11 Dec 2018 09:04:44 +0100
Message-ID: <20181211080448.24007-1-pn@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: manivannan.sadhasivam@linaro.org, afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, Parthiban Nallathambi <pn@denx.de>
List-Id: linux-i2c@vger.kernel.org

This patch series adds support for Actions Semi Owl SoC family S700
I2C controller. S700 provides 4 I2C masters and with cubieboard7
2 (I2C0 and I2C1) are exposed.

Added pinctrl definition for I2C controllers in cubieboard7. This patch
depends on s700 pinctrl driver support (yet to be merged),
https://lkml.org/lkml/2018/11/19/514
https://lore.kernel.org/patchwork/patch/1012859/

Changelog in v3:
- re-ordering I2C and pinctrl nodes alphabetically in board DTS
- re-orderng of patch
- Typo and nitpick corrections 

Changelog in v2:
- Initial version https://lore.kernel.org/patchwork/patch/1011911/ only
added the I2C nodes using s900 compatible property. Now, new s700
compatiable string is added and used for S700
- Device tree bindings added with s700 compatible string
- pinctrl definition for cubieboard7

Parthiban Nallathambi (4):
  dt-bindings: i2c: Add S700 support for Actions Semi Soc's
  arm64: dts: actions: s700: Add I2C controller nodes
  i2c: Add Actions Semiconductor Owl family S700 I2C support
  arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1

 .../devicetree/bindings/i2c/i2c-owl.txt       |  4 +-
 .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
 arch/arm64/boot/dts/actions/s700.dtsi         | 40 ++++++++++++++
 drivers/i2c/busses/i2c-owl.c                  |  1 +
 4 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.17.2
