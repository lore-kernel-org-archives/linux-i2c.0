From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 2/8 v3] i2c: i801: optimize waiting for HWPEC to finish
Date: Wed, 27 Jun 2012 21:54:09 +0800
Message-ID: <1340805255-8041-3-git-send-email-djkurtz@chromium.org>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Seth Heasley <seth.heasley@intel.com>
Cc: Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-i2c@vger.kernel.org

When a transaction has finished (including the PEC), the SMBus controller
sets the INTR bit.
Slightly optimize the polling loop by reading status before the first
sleep.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/i2c/busses/i2c-i801.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 51e11eb..8b74e1e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -291,11 +291,11 @@ static void i801_wait_hwpec(struct i801_priv *priv)
 	int timeout = 0;
 	int status;
 
-	do {
+	status = inb_p(SMBHSTSTS(priv));
+	while ((!(status & SMBHSTSTS_INTR)) && (timeout++ < MAX_RETRIES)) {
 		usleep_range(250, 500);
 		status = inb_p(SMBHSTSTS(priv));
-	} while ((!(status & SMBHSTSTS_INTR))
-		 && (timeout++ < MAX_RETRIES));
+	}
 
 	if (timeout > MAX_RETRIES)
 		dev_dbg(&priv->pci_dev->dev, "PEC Timeout!\n");
-- 
1.7.7.3
