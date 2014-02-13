From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 0/5] mv64xxx updates
Date: Thu, 13 Feb 2014 21:36:28 +0100
Message-ID: <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140213094117.GA3934@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

So, this is a series I came up with trying to fix the issue found by Kevin.
Patches 1+2 are hopefully fixing the bug (in theory, I don't have the HW).
Patches 3-5 are RFC, and if patch 3 actually works (see the CHECKME), then 4+5
are further cleanup possibilities. And there is still more potential, I mainly
wanted to give some inspiration and awareness that the driver could need some
more love. Please test at least 1+2, comments to 3-5 very welcome.

Sorry for the delay, I got distracted by an NMI.

Wolfram Sang (5):
  i2c: mv64xxx: put offload check into offload prepare function
  i2c: mv64xxx: refactor message start to ensure proper initialization
  i2c: mv64xxx: refactor send_start
  i2c: mv64xxx: directly call send_start when initializing transfer
  i2c: mv64xxx: refactor initialization for new msgs

 drivers/i2c/busses/i2c-mv64xxx.c | 67 ++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

-- 
1.8.5.1
