From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH] i2c-i801: Clear only status bits in HST_STS after waiting for INTR
Date: Thu, 28 Jun 2012 16:59:30 +0800
Message-ID: <1340873970-19226-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Seth Heasley <seth.heasley@intel.com>
Cc: Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Writing back the whole status register could clear unwanted bits.
In particular, it could clear the "INUSE_STS" bit, which is a
'hardware semaphore', that might be useful to use some day.
To prepare for this, let's ban writing back the whole status to register
HST_STS, of which this is the only instance.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Reported-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/i2c-i801.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ae2945a..7443990 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -301,7 +301,7 @@ static void i801_wait_hwpec(struct i801_priv *priv)
 	if (timeout > MAX_RETRIES)
 		dev_dbg(&priv->pci_dev->dev, "PEC Timeout!\n");
 
-	outb_p(status, SMBHSTSTS(priv));
+	outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
 }
 
 static int i801_block_transaction_by_block(struct i801_priv *priv,
-- 
1.7.7.3
