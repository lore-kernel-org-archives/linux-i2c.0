From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer dereferencing error.
Date: Tue, 12 Aug 2014 10:33:38 +0800
Message-ID: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since we cannot make sure the 'data_len' will always be none zero here,
and then if 'data_len' equals to zero, the kzalloc() will return ZERO_SIZE_PTR,
which equals to ((void *)16).

So this patch fix this with just doing the 'data_len' zero check before calling
kzalloc().

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/i2c-acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-acpi.c b/drivers/i2c/i2c-acpi.c
index e8b6196..e144c00 100644
--- a/drivers/i2c/i2c-acpi.c
+++ b/drivers/i2c/i2c-acpi.c
@@ -134,6 +134,9 @@ static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
 	int ret;
 	u8 *buffer;
 
+	if (!data_len)
+		return -EINVAL;
+
 	buffer = kzalloc(data_len, GFP_KERNEL);
 	if (!buffer)
 		return AE_NO_MEMORY;
-- 
1.8.5
