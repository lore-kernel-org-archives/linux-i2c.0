From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
Date: Fri, 14 Jun 2013 17:12:52 +0200
Message-ID: <20130614151252.GR16699@lukather>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130614140719.GC2929@katana>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB5XF5SGQKGQETVEJD7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20130614140719.GC2929@katana>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, Jun 14, 2013 at 04:07:20PM +0200, Wolfram Sang wrote:
> On Wed, Jun 12, 2013 at 06:53:29PM +0200, Maxime Ripard wrote:
> > Hi,
> > 
> > This patchset adds support for the I2C controller found on most of the
> > Allwinner SoCs, especially the already supported A10 and A13, and the
> > yet to come A31.
> > 
> > This driver leverages the Marvel mv64xxx i2c controller driver, that has
> > an almost identical logic, with a slightly different register layout.
> 
> \o/ Yay, that's more like it. Thanks for the rework!
> 
> > It has been tested on a A13-Olinuxino and an A10s-Olinuxino.
> 
> I'd love to get some Tested-by or other tags for Marvell hardware. Any
> volunteers?

Yes, I'd be more comfortable with Tested-by from Marvell users. I'll
probably be able to get my hands on a Marvell board on monday, if no one
tested it yet.

> > Changes from v4:
> >   * Don't expose the reg offset structure through the platform data
> 
> Commit message 2/9 still speaks about pdata, but I will fix this locally
> if all goes well with this series.
> 
> I will wait a bit more for tags and then pick up patches 1-3. I assume
> the rest goes via arm-soc, let me know if I should take them.

Yes, I'll take it in my tree and push it to arm-soc afterwards.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
