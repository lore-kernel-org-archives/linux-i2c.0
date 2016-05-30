From: minyard@acm.org
Subject: [PATCH v2 09/10] i2c-i801: Null isr data buffer when done with it
Date: Sun, 29 May 2016 20:09:03 -0500
Message-ID: <1464570544-975-10-git-send-email-minyard@acm.org>
References: <1464570544-975-1-git-send-email-minyard@acm.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464570544-975-1-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, minyard@acm.org
Cc: Corey Minyard <cminyard@mvista.com>
List-Id: linux-i2c@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Don't leave a pointer to some external buffer lying around.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 70da60a..bb15356 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -598,6 +598,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 			dev_warn(&priv->pci_dev->dev,
 				 "Timeout waiting for interrupt!\n");
 		}
+		priv->data = NULL;
 		priv->status = 0;
 		return status;
 	}
-- 
2.7.4
