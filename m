From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: qup: use proper type fro clk_freq
Date: Thu,  3 Apr 2014 11:36:14 +0200
Message-ID: <1396517774-8400-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It is used with of_property_read_u32(), so it should be u32.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index ee409803fd94..1b4cf14f1106 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -562,7 +562,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	u32 io_mode, hw_ver, size;
 	int ret, fs_div, hs_div;
 	int src_clk_freq;
-	int clk_freq = 100000;
+	u32 clk_freq = 100000;
 
 	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
 	if (!qup)
-- 
1.9.0
