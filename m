From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Sun, 26 May 2013 16:44:43 +0200
Message-ID: <1781939.MrE9Xthq6W@flatron>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com> <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com> <51A1E9AA.4000008@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A1E9AA.4000008-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Oliver,

On Sunday 26 of May 2013 12:53:30 Oliver Schinagl wrote:
> Just replying because I want to understand certain choices you make,
> absolutely not questioning your code!
> 
> On 05/26/13 12:20, Maxime Ripard wrote:
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> 
> You forgot to add #include <linux/bitops.h> for BIT()
> 
> > +
> > +static void sunxi_i2c_write(struct sunxi_i2c_dev *i2c_dev, u16 reg,
> > u8 value) +{
> > +	writel(value, i2c_dev->membase + reg);
> 
> Why writel? and why without (u32)value? I thought iowrite* where the
> preferred calls and in this case, wouldn't we want writeb since value is
> u8?

Regs in ARM world are usually 32-bit wide and memory mapped, so you use 
writel for them. I believe it is the case here as well.

> > +}
> > +
> > +static u32 sunxi_i2c_read(struct sunxi_i2c_dev *i2c_dev, u16 reg)
> > +{
> > +	return readl(i2c_dev->membase + reg);
> 
> And here, readl does match the return of u32, but aren't we always
> reading 8 bits since the TWI Data Register only uses the first 8 bits?
> So wouldn't we want to return u8 and readb?
> 

Ditto. Even if only least significant 8 bits are used, the register is 32-
bit wide, so 32-bit accessor should be used. (Assuming that my previous 
comment holds true in case of this IP.)

> > +static int sunxi_i2c_probe(struct platform_device *pdev)
> > +{
> > +	struct sunxi_i2c_dev *i2c_dev;
> > +	struct device_node *np;
> > +	u32 freq, div_m, div_n;
> > +	struct resource res;
> 
> I feel stupid for questioning this, since it only shows my lack of
> knowledge, but
> If you declare all the memory here, isn't all the data lost after
> exiting the _probe function? we pass a pointer to this memory in the
> of_address_to_resource() function so that fills it, right?
> 
> Or does after devm_ioremap_resource it no longer matter, since that
> function got what it needed and useless after?
> 
> Just asking because of the wdt driver and possibly mine that you told us
> to change.

In this case struct resource is just used as a container to pass base 
address and size of area to be mapped to devm_ioremap_resource() in. It 
isn't used anymore after the function returns.

> Sorry for asking (again) maybe very obvious things. Just trying to
> learn.

No problem.

I can recommend you a great tool to browse through Linux sources:
http://lxr.free-electrons.com/source/lib/devres.c?a=arm#L107

It really helps looking up in code things that you aren't sure.

Best regards,
Tomasz
