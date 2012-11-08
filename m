From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/11] i2c: pxa: bugfix the slave addr in the transaction
Date: Thu,  8 Nov 2012 22:18:01 +0800
Message-ID: <1352384284-15660-8-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

The slave address of i2c device should be got in the start of the
msg tranaction, or it will dump wrong slave addr and make confusion.

Change-Id: I9520c245e6bb0a9a1e478aa275841842b588d4cd
Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f4bbbcc..5893110 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -677,6 +677,7 @@ static inline void i2c_pxa_start_message(struct pxa_i2c *i2c)
 	 * Step 1: target slave address into IDBR
 	 */
 	writel(i2c_pxa_addr_byte(i2c->msg), _IDBR(i2c));
+	i2c->req_slave_addr = i2c_pxa_addr_byte(i2c->msg);
 
 	/*
 	 * Step 2: initiate the write.
-- 
1.7.5.4
