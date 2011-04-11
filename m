From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [REPOST PATCH] i2c: pxa2xx: remove ifdef CONFIG_OF
Date: Mon, 11 Apr 2011 10:34:47 +0200
Message-ID: <20110411083447.GB4018@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since commit c9e358d ("driver-core: remove conditionals around
devicetree pointers") there is no need for CONFIG_OF around of_node and
of_match_table. Grant removed this ifdefs from all driver which were in
tree at the time, this one was merged later.

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f59224a..91c4c15 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1138,9 +1138,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &dev->dev;
-#ifdef CONFIG_OF
 	i2c->adap.dev.of_node = dev->dev.of_node;
-#endif
 
 	if (i2c_type == REGS_CE4100)
 		ret = i2c_add_adapter(&i2c->adap);
-- 
1.7.4
