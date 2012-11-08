From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 04/11] i2c: pxa: fix irq unbalanced warning
Date: Thu,  8 Nov 2012 22:17:57 +0800
Message-ID: <1352384284-15660-4-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Change-Id: Ic8b247e46950bc6b9bc0b9dfb655a3aabbd15638
Signed-off-by: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index cca387b..833ab4d 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1225,6 +1225,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	i2c_pxa_reset(i2c);
 
+	disable_irq(i2c->irq);
+
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &dev->dev;
 #ifdef CONFIG_OF
-- 
1.7.5.4
