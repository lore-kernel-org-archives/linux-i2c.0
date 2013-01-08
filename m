From: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drivers: i2c: muxes: fix sizeof(ptr)
Date: Tue,  8 Jan 2013 14:40:09 +0100
Message-ID: <1357652409-22907-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

sizeof when applied to a pointer typed expression gives the size of
the pointer

The semantic patch that makes this output is available
in scripts/coccinelle/misc/noderef.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pinctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 7fa5b24..f958d0f 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -167,7 +167,7 @@ static int __devinit i2c_mux_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	mux->busses = devm_kzalloc(&pdev->dev,
-				   sizeof(mux->busses) * mux->pdata->bus_count,
+				   sizeof(*mux->busses) * mux->pdata->bus_count,
 				   GFP_KERNEL);
 	if (!mux->busses) {
 		dev_err(&pdev->dev, "Cannot allocate busses\n");
-- 
1.7.10.4
