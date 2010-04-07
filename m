From: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [patch] i2c: off by one issue
Date: Wed, 7 Apr 2010 12:22:58 +0300
Message-ID: <20100407092258.GD5157@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Jean Delvare <khali-ReZ1+7V3V0tg9hUCZPvPmw@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoph Lameter <cl-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If we don't find the correct rate, we want to end the loop with "i"
pointing to the last element in the array.

Signed-off-by: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
I will be offline for a while, sorry if I delay replying.

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 1f5b38b..495be45 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -498,7 +498,7 @@ static int stu300_set_clk(struct stu300_dev *dev, unsigned long clkrate)
 	int i = 0;
 
 	/* Locate the apropriate clock setting */
-	while (i < ARRAY_SIZE(stu300_clktable) &&
+	while (i < ARRAY_SIZE(stu300_clktable) - 1 &&
 	       stu300_clktable[i].rate < clkrate)
 		i++;
 
