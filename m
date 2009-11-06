From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 16/22] i2c-designware: i2c_dw_read: Remove redundant target
 address checker
Date: Fri, 06 Nov 2009 21:50:22 +0900
Message-ID: <4AF41B8E.6090702@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I2c_dw_xfer_msg() also has the same target address inconsistency check,
and furthermore it checks across all i2c_msg messages, while
i2c_dw_read() walks through i2c_msg messages only with_ I2C_M_RD flag.
That is, target address check in i2c_dw_read() is redundant and useless.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 5ba7e55..5a3bd74 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -419,7 +419,6 @@ static void
 i2c_dw_read(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	u32 addr = msgs[dev->msg_read_idx].addr;
 	int rx_valid;
 
 	for (; dev->msg_read_idx < dev->msgs_num; dev->msg_read_idx++) {
@@ -429,10 +428,6 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 		if (!(msgs[dev->msg_read_idx].flags & I2C_M_RD))
 			continue;
 
-		/* different i2c client, reprogram the i2c adapter */
-		if (msgs[dev->msg_read_idx].addr != addr)
-			return;
-
 		if (!(dev->status & STATUS_READ_IN_PROGRESS)) {
 			len = msgs[dev->msg_read_idx].len;
 			buf = msgs[dev->msg_read_idx].buf;
-- 
1.6.5.2
