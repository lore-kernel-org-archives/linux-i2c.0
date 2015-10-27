From: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
Subject: [PATCH 1/4] i2c: added i2c quirk flag for unsupported clock stretching
Date: Tue, 27 Oct 2015 21:11:55 +0100
Message-ID: <1445976718-7449-1-git-send-email-nicola@corna.info>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added I2C_AQ_NO_CLK_STRETCH, to be used when clock stretching is not
supported.

Signed-off-by: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
---
 include/linux/i2c.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 768063b..9697002 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -493,6 +493,8 @@ struct i2c_adapter_quirks {
 /* convenience macro for typical write-then read case */
 #define I2C_AQ_COMB_WRITE_THEN_READ	(I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | \
 					 I2C_AQ_COMB_READ_SECOND | I2C_AQ_COMB_SAME_ADDR)
+/* clock stretching is not supported */
+#define I2C_AQ_NO_CLK_STRETCH		BIT(4)
 
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
-- 
2.6.1
