From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv4 4/9] i2c: mv64xxx: Add Allwinner sun4i compatible
Date: Wed, 12 Jun 2013 13:31:18 +0200
Message-ID: <20130612113118.GF16699@lukather>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-5-git-send-email-maxime.ripard@free-electrons.com>
 <20130612105613.GT16502@lunn.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBCVY4GGQKGQEUTVSXJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20130612105613.GT16502-g2DYL2Zd6BY@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 12, 2013 at 12:56:13PM +0200, Andrew Lunn wrote:
> On Wed, Jun 12, 2013 at 10:07:13AM +0200, Maxime Ripard wrote:
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
> 
> Hi Maxime.
> 
> What about MV64X60? It also needs to pass the registers in its
> platform data.

I grep'ed for the users mv64xxx_i2c_pdata in arch/arm, and the
plat-orion/common.c was the only user. Obviously, I forgot to think
about the PPC architecture.

Anyway, this patch will be dropped.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
