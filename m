From: Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Sun, 26 May 2013 12:53:30 +0200
Message-ID: <51A1E9AA.4000008@schinagl.nl>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com> <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDDZ7YMYRMGBBK6TQ6GQKGQECYIGMUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1369563642-4390-2-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Just replying because I want to understand certain choices you make, 
absolutely not questioning your code!

On 05/26/13 12:20, Maxime Ripard wrote:
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
You forgot to add #include <linux/bitops.h> for BIT()


> +
> +static void sunxi_i2c_write(struct sunxi_i2c_dev *i2c_dev, u16 reg, u8 value)
> +{
> +	writel(value, i2c_dev->membase + reg);
Why writel? and why without (u32)value? I thought iowrite* where the 
preferred calls and in this case, wouldn't we want writeb since value is u8?

> +}
> +
> +static u32 sunxi_i2c_read(struct sunxi_i2c_dev *i2c_dev, u16 reg)
> +{
> +	return readl(i2c_dev->membase + reg);
And here, readl does match the return of u32, but aren't we always 
reading 8 bits since the TWI Data Register only uses the first 8 bits?
So wouldn't we want to return u8 and readb?

> +static int sunxi_i2c_probe(struct platform_device *pdev)
> +{
> +	struct sunxi_i2c_dev *i2c_dev;
> +	struct device_node *np;
> +	u32 freq, div_m, div_n;
> +	struct resource res;
I feel stupid for questioning this, since it only shows my lack of 
knowledge, but
If you declare all the memory here, isn't all the data lost after 
exiting the _probe function? we pass a pointer to this memory in the 
of_address_to_resource() function so that fills it, right?

Or does after devm_ioremap_resource it no longer matter, since that 
function got what it needed and useless after?

Just asking because of the wdt driver and possibly mine that you told us 
to change.



Sorry for asking (again) maybe very obvious things. Just trying to learn.

Oliver
