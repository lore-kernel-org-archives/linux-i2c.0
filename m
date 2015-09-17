From: Luis de Bethencourt <luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 2/4] i2c: meson: Fix module autoload for OF platform driver
Date: Thu, 17 Sep 2015 18:35:37 +0200
Message-ID: <20150917163537.GA26203@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
---
 drivers/i2c/busses/i2c-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 5e176ad..71d3929 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -475,6 +475,7 @@ static const struct of_device_id meson_i2c_match[] = {
 	{ .compatible = "amlogic,meson6-i2c" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, meson_i2c_match);
 
 static struct platform_driver meson_i2c_driver = {
 	.probe   = meson_i2c_probe,
-- 
2.4.6
