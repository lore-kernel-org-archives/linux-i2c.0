From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [RFC PATCH 0/3]  Fix i2c bus hang on A0 version of the Armada XP SoCs
Date: Tue, 31 Dec 2013 17:44:50 +0100
Message-ID: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

This series is an RFC to fix the i2c bus hang on A0 version of the
Armada XP SoCs. It occured on the the eraly release of the OpenBlocks
AX3-4 bords. Indeed the first variants of Armada XP SoCs (A0 stepping)
have issues related to the i2c controller which prevent to use the
offload mechanism and lead to a kernel hang during boot.

The best solution will be to detect the SoCs version at runtime and
use it in the driver, but I chosed to submit this version in case CPU
version detection feature takes more time than expected (and we
already reached the rc6 kernel).

Thanks,

Gregory


Gregory CLEMENT (3):
  arm: mvebu: add new dts file for old variant of Openblocks AX3-4
  i2c: mv64xxx: Fix bus hang on A0 version of the Armada XP SoCs
  i2c: mv64xxx: Document the newly introduced Armada XP A0 compatible

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |   2 +-
 .../arm/boot/dts/armada-xp-a0-openblocks-ax3-4.dts |  40 +++++
 .../dts/armada-xp-common-openblocks-ax3-4.dtsi     | 177 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   | 164 +------------------
 drivers/i2c/busses/i2c-mv64xxx.c                   |   8 +
 5 files changed, 227 insertions(+), 164 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-xp-a0-openblocks-ax3-4.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-common-openblocks-ax3-4.dtsi

-- 
1.8.1.2
