From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 0/2] i2c-mv64xxx: Various fixes
Date: Tue, 18 Jun 2013 17:40:22 +0200
Message-ID: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

This series contains a real fix for the I2C controller of the Armada
XP SoC and a patch closer to a improvement than a fix.

They are independent and are only in the same series because they are
kind of fixes.

I kept the test on the compatible string "armadaxp" because I am not
convinced that we have to introduce a new property in the binding for
this. If latter another SoC got the same issue on this IP then it will
still be time to add a new property. However I don't have a strong
opinion on it, so if you really want it, I can send a new version with
it.

Changelog:
v1->v2:
 - Move the flag for the timing issue from global scope to per device
   scope
 - Assignment is no more done in if condition

Thanks,

Zbigniew Bodek (2):
  i2c-mv64xxx: Fix timing issue on Armada XP (errata FE-8471889)
  i2c-mv64xxx: Abort the mv64xxx_of_config if clock-frequency is not
    provided

 drivers/i2c/busses/i2c-mv64xxx.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
1.8.1.2
