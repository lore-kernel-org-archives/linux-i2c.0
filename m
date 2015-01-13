From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Tue, 13 Jan 2015 23:15:54 +0800
Message-ID: <1421162154.27675.75.camel@mtksdaap41>
References: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
	 <20141124121555.GG3733@katana> <1417096856.12707.59.camel@mtksdaap41>
	 <20141127164536.GC5667@katana> <1418352022.4994.44.camel@mtksdaap41>
	 <20150106133753.GA3754@katana>  <20150113095725.GC1059@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150113095725.GC1059@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo Zhang <Liguo.Zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-01-13 at 10:57 +0100, Wolfram Sang wrote:
> On Tue, Jan 06, 2015 at 02:37:53PM +0100, Wolfram Sang wrote:
> > 
> > > We've started upstream work for MT8173[1].
> > > 
> > > We've fixed these issues for new SoC, and we believe it is fully I2C
> > > compatible now. We'll add mt8173 support to this driver, so this driver
> > > will support both fully I2C compatible SoC and the current one.
> > 
> > From what you tell, I'd rather add the MT8173 support incrementally.
> > Let's get first the limited support properly implemented, then add
> > another controller.
> > 
> > I'll send out my draft for describing the quirks later today.
> 
> What do you think about my two proposals?

I think the quirks can describe our HW limitation without issue.
We are porting our i2c driver base on that. Will let you know the test
result.
Thanks

Joe.C
