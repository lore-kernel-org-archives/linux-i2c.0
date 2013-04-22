From: "Steven A. Falco" <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c-xiic.c must always write 16-bit words to TX_FIFO
Date: Mon, 22 Apr 2013 15:34:39 -0400
Message-ID: <517590CF.10609@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The TX_FIFO register is 10 bits wide.  The lower 8 bits are the data to be
written, while the upper two bits are flags to indicate stop/start.

The driver apparently attempted to optimize write access, by only writing a
byte in those cases where the stop/start bits are zero.  However, we have
seen cases where the lower byte is duplicated onto the upper byte by the
hardware, which causes inadvertent stop/starts.

This patch changes the write access to the transmit FIFO to always be 16 bits
wide.

Signed off by: Steven A. Falco <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>

---

We had the unfortunate case where we were writing a data byte of 0x02, which
got duplicated onto the upper byte.  Thus, the actual data written was 0x202,
which set the stop bit, and corrupted the transaction.  By always writing the
full 16 bits, this is avoided.

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 332c720..3d0f052 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -312,10 +312,8 @@ static void xiic_fill_tx_fifo(struct xiic_i2c *i2c)
 			/* last message in transfer -> STOP */
 			data |= XIIC_TX_DYN_STOP_MASK;
 			dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
-
-			xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
-		} else
-			xiic_setreg8(i2c, XIIC_DTR_REG_OFFSET, data);
+		}
+		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
 	}
 }
 
