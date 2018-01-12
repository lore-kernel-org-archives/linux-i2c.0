From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 0/2] i2c: mv64xxx: Fix clock resource for Armada 7K/8K
Date: Fri, 12 Jan 2018 11:39:54 +0100
Message-ID: <20180112103956.4875-1-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47387 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932986AbeALKkA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 12 Jan 2018 05:40:00 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

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

Thanks,

Gregory

Changelog:
v1 -> v2:

 - Really add the binding documentation in the second patch, noticed
   by Thomas Petazzoni.

v2 -> v3

 - Fix typo in binding documentation reported by Thomas	Petazzoni
 - Use correct name for the axi clock, reported by Thomas Petazzoni

Gregory CLEMENT (2):
  i2c: mv64xxx: Remove useless test before clk_disable_unprepare
  i2c: mv64xxx: Fix clock resource by adding an optional bus clock

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++++++++
 drivers/i2c/busses/i2c-mv64xxx.c                     | 20 +++++++++++++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.15.1
