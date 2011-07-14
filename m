From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 3/4] i2c/au1550: increase timeout limit
Date: Thu, 14 Jul 2011 10:56:54 +0200
Message-ID: <1310633815-18817-4-git-send-email-manuel.lauss@googlemail.com>
References: <1310633815-18817-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310633815-18817-1-git-send-email-manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The timeout waiting for various events to occur is tailored for
a module clock of 50MHz.  On the DB1300 board only 48MHz can be
supplied to the i2c module, which results in the timeout aborting
complex transfers to slaves slightly too early if they employ
for example clock stretching.

With this change the WM8731 codec on the DB1300 board is correctly
detected and initialized.

Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/i2c/busses/i2c-au1550.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 98ee11a..36d1b29 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -344,7 +344,7 @@ i2c_au1550_probe(struct platform_device *pdev)
 		ret = -EIO;
 		goto out_map;
 	}
-	priv->xfer_timeout = 200;
+	priv->xfer_timeout = 400;
 
 	priv->adap.nr = pdev->id;
 	priv->adap.algo = &au1550_algo;
-- 
1.7.6
