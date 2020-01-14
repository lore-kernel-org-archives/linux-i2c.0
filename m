From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] i2c: i801: Fix memory corruption in i801_isr_byte_done()
Date: Tue, 14 Jan 2020 10:34:06 +0300
Message-ID: <20200114073406.qaq3hbrhtx76fkes@kili.mountain>
References: <0000000000009586b2059c13c7e1@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0000000000009586b2059c13c7e1@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Daniel Kurtz <djkurtz@chromium.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot <syzbot+ed71512d469895b5b34e@syzkaller.appspotmail.com>
List-Id: linux-i2c@vger.kernel.org

Assigning "priv->data[-1] = priv->len;" obviously doesn't make sense.
What it does is it ends up corrupting the last byte of priv->len so
priv->len becomes a very high number.

Reported-by: syzbot+ed71512d469895b5b34e@syzkaller.appspotmail.com
Fixes: d3ff6ce40031 ("i2c-i801: Enable IRQ for byte_by_byte transactions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Untested.

 drivers/i2c/busses/i2c-i801.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index f5e69fe56532..420d8025901e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -584,7 +584,6 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 					"SMBus block read size is %d\n",
 					priv->len);
 			}
-			priv->data[-1] = priv->len;
 		}
 
 		/* Read next byte */
-- 
2.11.0
