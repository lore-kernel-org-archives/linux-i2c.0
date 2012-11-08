From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 10/11] i2c: pxa: modify the parameters of i2c_bus_reset()
Date: Thu,  8 Nov 2012 22:18:03 +0800
Message-ID: <1352384284-15660-10-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

there may be more than one i2c bus needs to be reset,
add i2c bus number as parameter

Change-Id: I74456743bf640efe2fbf0664e8212be161cef424
Signed-off-by: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f3811d5..3346fef 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -289,7 +289,7 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 	printk("\n");
 	if (strcmp(why, "exhausted retries") != 0) {
 		if (plat && plat->i2c_bus_reset)
-			plat->i2c_bus_reset();
+			plat->i2c_bus_reset(i2c->adap.nr);
 		/* reset i2c contorler when it's fail */
 		i2c_pxa_reset(i2c);
 	}
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index a247f48..04406ba 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -72,7 +72,7 @@ struct i2c_pxa_platform_data {
 	void			(*hardware_lock)(void);
 	void			(*hardware_unlock)(void);
 	int			(*hardware_trylock)(void);
-	void			(*i2c_bus_reset) (void);
+	void			(*i2c_bus_reset)(int i2c_bus_num);
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-- 
1.7.5.4
