From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 9/8] i2c-omap: fix I2C timeouts due to
	recursive	omap_i2c_{un, }idle()
Date: Fri, 17 Oct 2008 08:47:08 -0700
Message-ID: <20081017154708.GO15820@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com>
	<1222329234-31473-2-git-send-email-tony@atomide.com>
	<1222329234-31473-3-git-send-email-tony@atomide.com>
	<1222329234-31473-4-git-send-email-tony@atomide.com>
	<1222329234-31473-5-git-send-email-tony@atomide.com>
	<1222329234-31473-6-git-send-email-tony@atomide.com>
	<1222329234-31473-7-git-send-email-tony@atomide.com>
	<1222329234-31473-8-git-send-email-tony@atomide.com>
	<1222329234-31473-9-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TC23+W66xmFESAX"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1222329234-31473-9-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6TC23+W66xmFESAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's one more new patch to fix a nasty I2C timeout bug that
showed up at least on omap34xx.

Tony

--6TC23+W66xmFESAX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline;
	filename="0009-i2c-omap-fix-I2C-timeouts-due-to-recursive-omap_i2c.patch"

>From b3016ed8b0105a3c4447cc93434d988fd0ad29d6 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Date: Fri, 17 Oct 2008 08:42:54 -0700
Subject: [PATCH] i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()

omap_i2c_unidle() and omap_i2c_idle() are called recursively during
omap_i2c_probe().  This is evidently unexpected and will wipe
out the I2C interrupt enable register the second time that
omap_i2c_idle() is called consecutively.  Any I2C transactions
following a probe of a bus with at least one device on it will then
time out.

Fix by moving omap_i2c_idle() further up in omap_i2c_probe().  Ensure
the I2C controller is marked as idle before the probe starts.  Also
attempt to catch future reappearances of this bug early in development
by warning in omap_i2c_{un,}idle() when they are called recursively.

Problem reported by David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>.

Tested on 3430SDP and 2430SDP.

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
Acked-by; Steve Sakoman <steve-4Uf0gMDude1BDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 17166a2..363335e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -191,6 +191,8 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
+	WARN_ON(!dev->idle);
+
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
@@ -203,6 +205,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
 	u16 iv;
 
+	WARN_ON(dev->idle);
+
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1)
@@ -743,6 +747,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		*speed = 100; /* Defualt speed */
 
 	dev->speed = *speed;
+	dev->idle = 1;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->base = ioremap(mem->start, mem->end - mem->start + 1);
@@ -791,6 +796,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
 		 pdev->id, r >> 4, r & 0xf, dev->speed);
 
+	omap_i2c_idle(dev);
+
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -807,8 +814,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
-	omap_i2c_idle(dev);
-
 	return 0;
 
 err_free_irq:
-- 
1.5.6.rc3.21.g8c6b5


--6TC23+W66xmFESAX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--6TC23+W66xmFESAX--
