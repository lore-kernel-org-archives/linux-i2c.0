From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: [PATCH] i2c: davinci: Increase module clock frequency
Date: Thu, 19 Nov 2015 13:21:55 +0100
Message-ID: <564DBEE3.4030508@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:54251 "EHLO
	demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbKSMWH (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 07:22:07 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>

I2C controller used in Keystone SoC has an undocumented peculiarity which
results in SDA-SCL margins being dependent on module clock. Driving high
capacity bus near its limits can result in STOP condition sometimes being
understood as REPEATED-START by slaves (or NACK instead of ACK, etc...).
Driving the module with higher clocks increases the margin between SDA and SCL
transitions, making the operations with higher bus rates more robust. Therefore,
target the module clock to 12MHz instead of 7MHz, still staying within
the specification limits.

Before the change STOP timing looked like this on 400kHz:

SDA   ----------+          +----
                 \        /
                  \      /
                   +----+
                       (1)
SCL   --+          +------------
         \        /
          \      /
           +----+
               (2)

While only point (1) signals STOP, point (2) could be incorrectly recognized as
repeated-START (almost no margin between SDA and SCL transitions).

After the change there is at least 600ns margin measured between SCL fall and
SDA fall during STOP generation:

SDA   ------+          +----
             \        /
              \      /
               +----+

SCL   --+          +--------
         \        /
          \      /
           +----+
           ->|    |<- 600ns
                ->|   |<- tSUSTO

So called tSUSTO (setup time for STOP condition) is still slightly higher than
600ns, so no problem here.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/i2c/busses/i2c-davinci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index c5628a4..87c46a4 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -203,7 +203,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	 */
 
 	/* get minimum of 7 MHz clock, but max of 12 MHz */
-	psc = (input_clock / 7000000) - 1;
+	psc = (input_clock / 12000000) - 1;
 	if ((input_clock / (psc + 1)) > 12000000)
 		psc++;	/* better to run under spec than over */
 	d = (psc >= 2) ? 5 : 7 - psc;
