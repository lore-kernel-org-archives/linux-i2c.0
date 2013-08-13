From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] i2c: sirf: fix the typo for setting bitrate to less than 100k
Date: Tue, 13 Aug 2013 17:11:29 +0800
Message-ID: <1376385091-30597-4-git-send-email-Baohua.Song@csr.com>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376385091-30597-1-git-send-email-Baohua.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>

there is a typo before, it makes the final bitrate wrong, this patch fixes
it.

Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 45a8881..746388f 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -357,7 +357,7 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 
 	if (bitrate < 100000)
 		regval =
-			(2 * ctrl_speed) / (2 * bitrate * 11);
+			(2 * ctrl_speed) / (bitrate * 11);
 	else
 		regval = ctrl_speed / (bitrate * 5);
 
-- 
1.8.2.3
