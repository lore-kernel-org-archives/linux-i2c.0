From: Michele Curti <michele.curti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: mux: fix compiler warning
Date: Sat,  5 Sep 2015 20:05:10 +0200
Message-ID: <1441476310-11162-1-git-send-email-michele.curti@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michele Curti <michele.curti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix compiler warning when CONFIG_OF is not defined by changing
the 'mux' parameter type in the i2c_mux_reg_probe stub.

Signed-off-by: Michele Curti <michele.curti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 86d41d36..cff1519 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -166,7 +166,7 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 	return 0;
 }
 #else
-static int i2c_mux_reg_probe_dt(struct gpiomux *mux,
+static int i2c_mux_reg_probe_dt(struct regmux *mux,
 					struct platform_device *pdev)
 {
 	return 0;
-- 
2.5.1
