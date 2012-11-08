From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 07/11] i2c: pxa: keep i2c irq on in suspend
Date: Thu,  8 Nov 2012 22:18:00 +0800
Message-ID: <1352384284-15660-7-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Raul Xiong <xjian-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

During suspending there may still be some i2c accessing, if don't keep
i2c irq on there may be i2c access timeout if i2c is in irq mode.

Change-Id: I43689ab9ee054d235678de83ea4424c03074ea62
Signed-off-by: Raul Xiong <xjian-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index ad6e69b..f4bbbcc 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1226,8 +1226,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
 		i2c->adap.algo = &i2c_pxa_algorithm;
-		ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
-				  i2c->adap.name, i2c);
+		ret = request_irq(irq, i2c_pxa_handler,
+				IRQF_SHARED | IRQF_NO_SUSPEND,
+				i2c->adap.name, i2c);
 		if (ret)
 			goto ereqirq;
 	}
-- 
1.7.5.4
