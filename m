From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH 15/16] i2c-designware: i2c_dw_xfer_msg: Mark as
 completed on an error
Date: Tue, 13 Oct 2009 17:05:05 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D74B4@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Shinya Kuribayashi
Sent: Monday, October 12, 2009 9:54 PM
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: [PATCH 15/16] i2c-designware: i2c_dw_xfer_msg: Mark as completed on an error

As wait_for_completion_interruptible_timeout() will be invoked after the first call to i2c_dw_xfer_msg() is made whether or not an error is detected in it, we need to mark ->cmd_complete as completed to avoid a needless HZ timeout.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---

 Or we could change the i2c_dw_xfer_msg() prototype from "void" to  "int".  Which is preffered?

 drivers/i2c/busses/i2c-designware.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index f7ea032..6f85e28 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -376,6 +376,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			dev_err(dev->dev,
 				"%s: invalid message length\n", __func__);
 			dev->msg_err = -EINVAL;
+			complete(&dev->cmd_complete);
 			return;
 		}
 
--
1.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
