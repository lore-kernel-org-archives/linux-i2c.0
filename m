From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v10] i2c-designware: make SDA hold time configurable
Date: Wed, 3 Jul 2013 13:43:11 +0200
Message-ID: <201307031343.11647.arnd@arndb.de>
References: <20130625163902.GA2973@katana> <1372236906-6933-1-git-send-email-christian.ruppert@abilis.com> <20130626140713.GB3119@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130626140713.GB3119@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 26 June 2013, Wolfram Sang wrote:
>   On Wed, Jun 26, 2013 at 10:55:06AM +0200, Christian Ruppert wrote:
> > This patch makes the SDA hold time configurable through device tree.
> > 
> > Signed-off-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> 
> Applied to for-next, thanks for keeping at it and providing lots of
> useful information. Much appreciated!

Sorry, but I got a regression that I didn't find reported elsewhere
so far, even though it breaks a lot of the ARM defconfig builds:

drivers/built-in.o: In function `dw_i2c_probe':
/git/arm-soc/drivers/i2c/busses/i2c-designware-platdrv.c:125: undefined reference to `__udivdi3'

I suspect you want something like the change below.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index def79b5..57e3a07 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -119,10 +119,13 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		u32 ht = 0;
 		u32 ic_clk = dev->get_clk_rate_khz(dev);
+		u64 hold_time;
 
 		of_property_read_u32(pdev->dev.of_node,
 					"i2c-sda-hold-time-ns", &ht);
-		dev->sda_hold_time = ((u64)ic_clk * ht + 500000) / 1000000;
+		hold_time = (u64)ic_clk * ht + 500000;
+		do_div(hold_time, 1000000);
+		dev->sda_hold_time = hold_time;
 	}
 
 	dev->functionality =
