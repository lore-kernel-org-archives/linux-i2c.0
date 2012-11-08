From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/11] i2c: pxa: support hardware lock
Date: Thu,  8 Nov 2012 22:17:54 +0800
Message-ID: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Append hardware lock support since it's required by Marvell PXA910

Change-Id: I8cd9cdf76785ecf4b6c6fa433d577cb7e3d9956b
Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 1034d93..73a1404 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1160,6 +1160,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->slave = plat->slave;
 #endif
 		i2c->adap.class = plat->class;
+		i2c->adap.hardware_lock = plat->hardware_lock;
+		i2c->adap.hardware_unlock = plat->hardware_unlock;
+		i2c->adap.hardware_trylock = plat->hardware_trylock;
 	}
 
 	clk_enable(i2c->clk);
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index 1a9f65e..eec9954 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -67,6 +67,9 @@ struct i2c_pxa_platform_data {
 	unsigned int		class;
 	unsigned int		use_pio :1;
 	unsigned int		fast_mode :1;
+	void			(*hardware_lock)(void);
+	void			(*hardware_unlock)(void);
+	int			(*hardware_trylock)(void);
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-- 
1.7.5.4
