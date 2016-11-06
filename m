From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Sun,  6 Nov 2016 21:20:18 +0100
Message-ID: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46877 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751873AbcKFUUy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 6 Nov 2016 15:20:54 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

So, here is the newest series for using the I2C demuxer on Gen2 boards.
Initially done by Simon. The intention of this series is to extend use of the
demuxer for I2C on the lager, koelsch, porter, koelsch, alt and silk boards to
cover all I2C IP blocks that are either already used or exposed via an EXIO
connector.

I tested this on a Lager board where I could successfully switch between I2C,
IIC, and GPIO on I2C2.

Simon, can you test with your script on the other boards? If all works, I'll
pick up the i2c patch for 4.9, so the DTS changes should be fine for 4.10.

The branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/ip-switch-rework

Regards,

   Wolfram


Changes between v4 and v3
* rebased to latest renesas-drivers (double checked that the moved i2c clients
  were complete because they changed meanwhile)
* fixed the aliases to be proper phandles
* fixed some typos in comments and commit messages
* added a patch to ensure i2c-gpio works again

Changes between v2 and v3
* Group extra GPIO buses
* Add GPIO fallback for IIC1/I2C1 on Lager
* Add patches for koelsch, porter, alt and silk

Changes between v1 and v2
* Provide GPIO fallback for I2C2,
  this does not seem appropriate for other I2C blocks on the lager board



Simon Horman (13):
  ARM: dts: lager: rename and reindex i2cexio
  ARM: dts: lager: use demuxer for IIC1/I2C1
  ARM: dts: lager: use demuxer for IIC2/I2C2
  ARM: dts: lager: use demuxer for IIC3/I2C3
  ARM: dts: koelsch: use demuxer for I2C1
  ARM: dts: koelsch: use demuxer for I2C2
  ARM: dts: koelsch: use demuxer for I2C4
  ARM: dts: porter: use demuxer for I2C2
  ARM: dts: gose: use demuxer for I2C2
  ARM: dts: gose: use demuxer for I2C4
  ARM: dts: alt: use demuxer for I2C1
  ARM: dts: alt: use demuxer for I2C4
  ARM: dts: silk: use demuxer for I2C1

Wolfram Sang (1):
  i2c: mux: demux-pinctrl: make drivers with no pinctrl work again

 arch/arm/boot/dts/r8a7790-lager.dts   | 329 ++++++++++++++++++++++------------
 arch/arm/boot/dts/r8a7791-koelsch.dts | 263 ++++++++++++++++++---------
 arch/arm/boot/dts/r8a7791-porter.dts  | 129 +++++++------
 arch/arm/boot/dts/r8a7793-gose.dts    | 203 +++++++++++++--------
 arch/arm/boot/dts/r8a7794-alt.dts     |  86 +++++++--
 arch/arm/boot/dts/r8a7794-silk.dts    | 129 +++++++------
 drivers/i2c/muxes/i2c-demux-pinctrl.c |  22 ++-
 7 files changed, 765 insertions(+), 396 deletions(-)

-- 
2.9.3
