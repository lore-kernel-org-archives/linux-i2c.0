From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Don't use the block buffer for I2C block writes
Date: Thu, 4 Mar 2010 11:01:09 +0100
Message-ID: <20100304110109.541b846e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleg Ryjkov <oryjkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-i801: Don't use the block buffer for I2C block writes

Experience has shown that the block buffer can only be used for SMBus
(not I2C) block transactions, even though the datasheet doesn't
mention this limitation.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oleg Ryjkov <oryjkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Oleg, can you remember which transaction types you tested when you
added support for the block buffer originally?

Seth, do you have any additional information regarding the use of the
32-byte block buffer with I2C block read and write transactions on
Intel ICH chips? The datasheet doesn't say it won't work, but
experience suggests that this is the case. Which is unfortunate because
it degrades performance quite a bit.

 drivers/i2c/busses/i2c-i801.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.34-rc0.orig/drivers/i2c/busses/i2c-i801.c	2010-03-04 10:54:22.000000000 +0100
+++ linux-2.6.34-rc0/drivers/i2c/busses/i2c-i801.c	2010-03-04 10:54:28.000000000 +0100
@@ -416,9 +416,11 @@ static int i801_block_transaction(union
 		data->block[0] = 32;	/* max for SMBus block reads */
 	}
 
+	/* Experience has shown that the block buffer can only be used for
+	   SMBus (not I2C) block transactions, even though the datasheet
+	   doesn't mention this limitation. */
 	if ((i801_features & FEATURE_BLOCK_BUFFER)
-	 && !(command == I2C_SMBUS_I2C_BLOCK_DATA
-	      && read_write == I2C_SMBUS_READ)
+	 && command != I2C_SMBUS_I2C_BLOCK_DATA
 	 && i801_set_block_buffer_mode() == 0)
 		result = i801_block_transaction_by_block(data, read_write,
 							 hwpec);


-- 
Jean Delvare
