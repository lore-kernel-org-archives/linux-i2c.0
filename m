From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/2] i2c: i2c-mv64xxx: fix offload support
Date: Thu, 11 Dec 2014 17:33:44 +0100
Message-ID: <1418315626-9552-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

Please consider this set of two patches (one cleanup and one fix) that
aim at making the i2c-mv64xxx offload support work properly for SMBus
type transfers and make sure it only gets used for transactions where
it can really be used (in order to comply with the expectations of the
I2C subsystem in terms of repeated start usage between messages of the
same xfer).

Without this patch, a platform like the Armada XP WRT1900AC doesn't
even boot completely, because an I2C LED controller driver triggers
some SMBus transfers that are do not work with the current i2c-mv64xxx
driver.

They apply on top of 3.18.

Thanks,

Thomas

Thomas Petazzoni (2):
  i2c: i2c-mv64xxx: use BIT() macro for register value definitions
  i2c: i2c-mv64xxx: rework offload support to fix several problems

 drivers/i2c/busses/i2c-mv64xxx.c | 325 +++++++++++++++++++++++----------------
 1 file changed, 194 insertions(+), 131 deletions(-)

-- 
2.1.0
