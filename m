From: minyard@acm.org
Subject: [PATCH v2 10/10] i2c-i801: Only write the host control reg when necessary
Date: Sun, 29 May 2016 20:09:04 -0500
Message-ID: <1464570544-975-11-git-send-email-minyard@acm.org>
References: <1464570544-975-1-git-send-email-minyard@acm.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464570544-975-1-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, minyard@acm.org
Cc: Corey Minyard <cminyard@mvista.com>
List-Id: linux-i2c@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

When doing byte-by-byte mode, the code was writing the host
control register on every byte.  However, this is only necessary
on the first byte and for read transactions the last byte.
So only do it those times.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index bb15356..4a96a95 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -606,11 +606,11 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 	for (i = 1; i <= len; i++) {
 		if (i == len && is_read)
 			smbcmd |= SMBHSTCNT_LAST_BYTE;
-		outb_p(smbcmd, SMBHSTCNT(priv));
 
 		if (i == 1)
-			outb_p(inb(SMBHSTCNT(priv)) | SMBHSTCNT_START,
-			       SMBHSTCNT(priv));
+			outb_p(smbcmd | SMBHSTCNT_START, SMBHSTCNT(priv));
+		else if (i == len && is_read)
+			outb_p(smbcmd, SMBHSTCNT(priv));
 
 		status = i801_wait_byte_done(priv);
 		if (status)
-- 
2.7.4
