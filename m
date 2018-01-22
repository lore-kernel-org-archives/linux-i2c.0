From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 0/2] Use demuxer for i2c1 and i2c5
Date: Mon, 22 Jan 2018 11:29:21 +0000
Message-ID: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>
List-Id: linux-i2c@vger.kernel.org

We have observed that on iWave RZ/G1E boards, randomly HDMI slave device
is holding data line after a soft reboot.

We applied demuxer patch for i2c1 and using an oscilloscope verified that
i2c recovery works on the failure condition.

This patch depends on the below patch set

https://patchwork.ozlabs.org/cover/857505/

it is tested against renesas-devel-20180122-v4.15-rc9

Biju Das (2):
  ARM: dts: iwg22d-sodimm-dbhd-ca: use demuxer for I2C1
  ARM: dts: iwg22d-sodimm: use demuxer for I2C5

 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 96 +++++++++++++---------
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        | 44 +++++++---
 2 files changed, 92 insertions(+), 48 deletions(-)

-- 
2.7.4
