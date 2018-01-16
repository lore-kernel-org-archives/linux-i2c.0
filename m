From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 0/3] i2c: mv64xxx: Fix clock resource for Armada 7K/8K
Date: Tue, 16 Jan 2018 17:35:37 +0100
Message-ID: <20180116163540.1092-1-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57593 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeAPQfz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 11:35:55 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

Hi,

This short series fixes the way the clocks are used for the mv64xxx
controller embedded in the Marvell Armada 7K/8K SoCs. On these SoCs a
second one is needed in order to clock the registers. It was not
noticed until now because we relied on the bootloader and also because
the clock driver was wrong.

Thanks to this fix, it would be possible to fix the clock driver
without introducing a regression.

The first patch is just a small cleanup found when I wrote the main
patch.

The last patch is not related to the series but as Wolfram to have a
maintainer for this driver I added the patch here.

Thanks,

Gregory

Changelog:
v1 -> v2:

 - Really add the binding documentation in the second patch, noticed
   by Thomas Petazzoni.

v2 -> v3:

 - Fix typo in binding documentation reported by Thomas	Petazzoni
 - Use correct name for the axi clock, reported by Thomas Petazzoni

v2 -> v4:

 - Use "reg" instead of "axi" as requested by Maxime Ripard
 - Reformulate the binding documentation, requested by Maxime Ripard
 - Add a maintainer for the i2c-mv64xxx driver, requested by Woflram
   Sang

Gregory CLEMENT (3):
  i2c: mv64xxx: Remove useless test before clk_disable_unprepare
  i2c: mv64xxx: Fix clock resource by adding an optional bus clock
  i2c: mv64xxx: Add myslef as maintainer for this driver

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++++++++
 MAINTAINERS                                          |  6 ++++++
 drivers/i2c/busses/i2c-mv64xxx.c                     | 20 +++++++++++++-------
 3 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.15.1
