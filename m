From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv4 4/9] i2c: mv64xxx: Add Allwinner sun4i compatible
Date: Wed, 12 Jun 2013 13:27:24 +0200
Message-ID: <20130612112724.GD16699@lukather>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-5-git-send-email-maxime.ripard@free-electrons.com>
 <24053541.0lokJN1hNA@flatron>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBIFW4GGQKGQE6UYM4FI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <24053541.0lokJN1hNA@flatron>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tomasz,

On Wed, Jun 12, 2013 at 10:42:31AM +0200, Tomasz Figa wrote:
> Hi Maxime,
> 
> On Wednesday 12 of June 2013 10:07:13 Maxime Ripard wrote:
> > Add the compatible string for the Allwinner A10 i2c controller and the
> > associated register layout.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  drivers/i2c/busses/Kconfig       |  3 ++-
> >  drivers/i2c/busses/i2c-mv64xxx.c |  1 +
> >  include/linux/mv643xx_i2c.h      | 10 ++++++++++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 631736e..5dc4148 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -507,10 +507,11 @@ config I2C_MPC
> > 
> >  config I2C_MV64XXX
> >  	tristate "Marvell mv64xxx I2C Controller"
> > -	depends on (MV64X60 || PLAT_ORION)
> > +	depends on (MV64X60 || PLAT_ORION || ARCH_SUNXI)
> >  	help
> >  	  If you say yes to this option, support will be included for the
> >  	  built-in I2C interface on the Marvell 64xxx line of host 
> bridges.
> > +	  This driver is also used for Allwinner SoCs I2C controllers.
> > 
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called i2c-mv64xxx.
> > diff --git a/drivers/i2c/busses/i2c-mv64xxx.c
> > b/drivers/i2c/busses/i2c-mv64xxx.c index f9e076e..febf5ba 100644
> > --- a/drivers/i2c/busses/i2c-mv64xxx.c
> > +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> > @@ -490,6 +490,7 @@ static const struct i2c_algorithm mv64xxx_i2c_algo =
> > { */
> >  #ifdef CONFIG_OF
> >  static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
> > +	{ .compatible = "allwinner,sun4i-i2c", .data =
> > &mv64xxx_i2c_regs_sun4i}, { .compatible = "marvell,mv64xxx-i2c", .data
> > = &mv64xxx_i2c_regs_mv64xxx}, {}
> 
> Ah, OK, here you use compatible matching to get variant-specific data, 
> fine. Still I think the same method (based on platform device name) should 
> be used for non-DT variant.

Yes, you're right. I wasn't aware that you could do something similar
with the platform device name, hence why I used the platform data.

I'll fix this in the next iteration.

> >  };
> > diff --git a/include/linux/mv643xx_i2c.h b/include/linux/mv643xx_i2c.h
> > index 9304c94..737108e 100644
> > --- a/include/linux/mv643xx_i2c.h
> > +++ b/include/linux/mv643xx_i2c.h
> > @@ -32,6 +32,16 @@ struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx = {
> >  	.soft_reset	= 0x1c,
> >  };
> > 
> > +struct mv64xxx_i2c_regs mv64xxx_i2c_regs_sun4i = {
> > +	.addr		= 0x00,
> > +	.ext_addr	= 0x04,
> > +	.data		= 0x08,
> > +	.control	= 0x0c,
> > +	.status		= 0x10,
> > +	.clock		= 0x14,
> > +	.soft_reset	= 0x18,
> > +};
> > +
> 
> Hmm, header doesn't look like a correct place for a structure definition, 
> especially when the structure isn't even static.

I put it there because it had to be used by the board files to fill
their plateform_data. Obviously, it will be moved back into the driver.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
