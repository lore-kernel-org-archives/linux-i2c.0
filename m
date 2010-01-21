From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] i2c-designware: Allow mixed endianness
Date: Thu, 21 Jan 2010 14:25:33 +0900
Message-ID: <4B57E54D.8020909@necel.com>
References: <20100119140234.689304000@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100119140234.689304000-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean-Hugues Deschenes wrote:
> This is the v2 version of the patch which adds support
> for the i2c Designware controller when its endianness
> differs from that of the cpu.
> 
> ---
> Changelog v1->v2
> - rename i2c_dw_(read|write)l to dw_(read|write)l (Shinya Kuribayashi)
> - rename dw_(read|write)l's addr argument to offset (Shinya Kuribayashi)
> - replace (if constant == x) with (if x == constant) (Ben Dooks)
> ---
> 
> 
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>

All three patches look good, and work for my BE machines.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>

---

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 362dd9e..ce20fc8 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -778,6 +783,12 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 			r = -ENODEV;
 			goto err_iounmap;
 		}
+
+		printk("### comp_type = 0x%08x\n", comp_type);
+		printk("### ___constant_swab32(0x44570140) = 0x%08x\n",
+			___constant_swab32(0x44570140));
+		printk("### swab = %d\n", dev->swab);
+
 	}
 	{
 		u32 param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);

[...]

i2c /dev entries driver
### comp_type = 0x44570140
### ___constant_swab32(0x44570140) = 0x40015744
### swab = 0
### comp_type = 0x44570140
### ___constant_swab32(0x44570140) = 0x40015744
### swab = 0
### comp_type = 0x44570140
### ___constant_swab32(0x44570140) = 0x40015744
### swab = 0

-- 
Shinya Kuribayashi
NEC Electronics
