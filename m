From: Bhushan Shah <bshah@kde.org>
Subject: [PATCH v3 0/2] Enable the I2C nodes for Allwinner H6 CPU
Date: Fri, 16 Aug 2019 14:13:07 +0530
Message-ID: <20190816084309.27440-1-bshah@kde.org>
References: <20190816064710.18280-1-bshah@kde.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816064710.18280-1-bshah@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Bhushan Shah <bshah@kde.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This patch series adds device-tree nodes for i2c nodes in the H6 dtsi,
and enables it for the Pine H64.

Changes in v2:
  - Add the SoC specific compatible string instead of re-using a31 one.
  - Don't enable the i2c0 node in PineH64 by default

Changes in v3:
  - Fix compatible for i2c in sun50i-h6.dtsi
  - drop changes in the PineH64 dts completely

Bhushan Shah (2):
  dt-bindings: i2c: mv64xxx: Add compatible for the H6 i2c node.
  arm64: allwinner: h6: add I2C nodes

 .../bindings/i2c/marvell,mv64xxx-i2c.yaml     |  3 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 60 ++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

-- 
2.17.1
