From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c
 driver
Date: Sun, 26 May 2013 15:21:20 +0200
Message-ID: <20130526132120.GJ17847@lukather>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com>
 <51A1E9AA.4000008@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51A1E9AA.4000008-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, May 26, 2013 at 12:53:30PM +0200, Oliver Schinagl wrote:
> 
> Just replying because I want to understand certain choices you make,
> absolutely not questioning your code!
> 
> On 05/26/13 12:20, Maxime Ripard wrote:
> >+ * warranty of any kind, whether express or implied.
> >+ */
> >+
> >+#include <linux/clk.h>
> >+#include <linux/completion.h>
> You forgot to add #include <linux/bitops.h> for BIT()

Ah, yes, thanks

> >+static void sunxi_i2c_write(struct sunxi_i2c_dev *i2c_dev, u16 reg, u8 value)
> >+{
> >+	writel(value, i2c_dev->membase + reg);
> Why writel? and why without (u32)value? I thought iowrite* where the
> preferred calls and in this case, wouldn't we want writeb since
> value is u8?

You're right, value should be a u32 here, thanks for noticing.

For the iowrite* vs write*, there's no consensus, and as such no
preferred way. write* functions are doing an MMIO only access,
while iowrite functions can do MMIO and port I/O accesses.

Note that it doesn't change anything on ARM, since there's no port IO on
ARM.

> >+}
> >+
> >+static u32 sunxi_i2c_read(struct sunxi_i2c_dev *i2c_dev, u16 reg)
> >+{
> >+	return readl(i2c_dev->membase + reg);
> And here, readl does match the return of u32, but aren't we always
> reading 8 bits since the TWI Data Register only uses the first 8
> bits?
> So wouldn't we want to return u8 and readb?

They are meant to be general purpose accessors, so we shouldn't focus
only on the data register.

> 
> >+static int sunxi_i2c_probe(struct platform_device *pdev)
> >+{
> >+	struct sunxi_i2c_dev *i2c_dev;
> >+	struct device_node *np;
> >+	u32 freq, div_m, div_n;
> >+	struct resource res;
> I feel stupid for questioning this, since it only shows my lack of
> knowledge, but
> If you declare all the memory here, isn't all the data lost after
> exiting the _probe function? we pass a pointer to this memory in the
> of_address_to_resource() function so that fills it, right?
> 
> Or does after devm_ioremap_resource it no longer matter, since that
> function got what it needed and useless after?

The struct resource is only there to declare the base address and the
size of memory address. Once we have mapped it, we don't care about it
anymore.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
