From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 0/2] i2c: prevent id collisions in the DT case
Date: Thu, 12 Mar 2015 17:17:57 +0100
Message-ID: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This series tries to fix the issue reported here[1]. In short: A DT entry wants
a fixed id but its probe was deferred. When it was probed again, its id was
taken by a dynamically assigned muxed bus. So, the probe failed.

Let's start all dynamically assigned ids after the highest fixed one. We do
this for legacy platform devices already.

Please let me know what you think. If you can accept the new of-helper
function, I'd like an ack so I can take the patches via my i2c tree.

Thanks,

   Wolfram


[1] http://thread.gmane.org/gmane.linux.drivers.i2c/22166

Wolfram Sang (2):
  of: base: add function to get highest id of an alias stem
  i2c: busses with dynamic ids should start after fixed ids for DT

 drivers/i2c/i2c-core.c |  8 ++++++++
 drivers/of/base.c      | 26 ++++++++++++++++++++++++++
 include/linux/of.h     |  6 ++++++
 3 files changed, 40 insertions(+)

-- 
2.1.4
