From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH RESEND V2 2/4] i2c/au1550: remove unused ack_timeout
Date: Sat, 22 Oct 2011 13:34:37 +0200
Message-ID: <1319283279-2296-3-git-send-email-manuel.lauss@googlemail.com>
References: <1319283279-2296-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319283279-2296-1-git-send-email-manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The ack_timeout context member is unused, get rid of it.

Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
V2: no changes

 drivers/i2c/busses/i2c-au1550.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 70b027c..98ee11a 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -52,7 +52,6 @@
 struct i2c_au1550_data {
 	void __iomem *psc_base;
 	int	xfer_timeout;
-	int	ack_timeout;
 	struct i2c_adapter adap;
 	struct resource *ioarea;
 };
@@ -346,7 +345,6 @@ i2c_au1550_probe(struct platform_device *pdev)
 		goto out_map;
 	}
 	priv->xfer_timeout = 200;
-	priv->ack_timeout = 200;
 
 	priv->adap.nr = pdev->id;
 	priv->adap.algo = &au1550_algo;
-- 
1.7.6.1
