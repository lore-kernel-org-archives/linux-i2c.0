From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 05/11] i2c: pxa: add bus reset for platform data;
Date: Thu,  8 Nov 2012 22:17:58 +0800
Message-ID: <1352384284-15660-5-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Since there is some problemic i2c slave devices on some platforms such
as dkb sometimes, it will drop down sda and make i2c bus hang, at that
time, it need to config scl/sda into gpio to simulate "stop" sequence to
recover i2c bus, so add this interface in platform data;

Change-Id: I2f7cf98d2f6b7a3a6d3ebac840b8f89f0b31fae6
Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 833ab4d..cab0792 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -271,6 +271,9 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
 	unsigned int i;
+	struct i2c_pxa_platform_data *plat =
+		(i2c->adap.dev.parent)->platform_data;
+
 	printk(KERN_ERR"i2c: <%s> slave_0x%x error: %s\n", i2c->adap.name,
 		i2c->req_slave_addr >> 1, why);
 	printk(KERN_ERR "i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
@@ -282,6 +285,12 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 	for (i = 0; i < i2c->irqlogidx; i++)
 		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
 	printk("\n");
+	if (strcmp(why, "exhausted retries") != 0) {
+		if (plat && plat->i2c_bus_reset)
+			plat->i2c_bus_reset();
+		/* reset i2c contorler when it's fail */
+		i2c_pxa_reset(i2c);
+	}
 }
 
 #else /* ifdef DEBUG */
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index 2a03e91..a247f48 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -72,6 +72,7 @@ struct i2c_pxa_platform_data {
 	void			(*hardware_lock)(void);
 	void			(*hardware_unlock)(void);
 	int			(*hardware_trylock)(void);
+	void			(*i2c_bus_reset) (void);
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-- 
1.7.5.4
