From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 0/2] 2c: mv64xxx: Fix clock resource for Armada 7K/8K
Date: Wed, 10 Jan 2018 17:51:45 +0100
Message-ID: <20180110165147.26605-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@free-electrons.com>, Omri Itach <omrii@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

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

Gregory CLEMENT (2):
  i2c: mv64xxx: Remove useless test before clk_disable_unprepare
  i2c: mv64xxx: Fix clock resource by adding an optional bus clock

 drivers/i2c/busses/i2c-mv64xxx.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.15.1
