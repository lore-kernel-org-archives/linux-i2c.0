From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv4 0/9] Add I2C support for Allwinner SoCs
Date: Wed, 12 Jun 2013 13:38:49 +0200
Message-ID: <20130612113849.GG16699@lukather>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <3315236.ZNXhyxmCRd@wuerfel>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBTN34GGQKGQEQAFF5SI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <3315236.ZNXhyxmCRd@wuerfel>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

On Wed, Jun 12, 2013 at 01:26:56PM +0200, Arnd Bergmann wrote:
> On Wednesday 12 June 2013 10:07:09 Maxime Ripard wrote:
> > 
> > This patchset adds support for the I2C controller found on most of the
> > Allwinner SoCs, especially the already supported A10 and A13, and the
> > yet to come A31.
> > 
> > This driver leverages the Marvel mv64xxx i2c controller driver, that has
> > an almost identical logic, with a slightly different register layout.
> > 
> > It has been tested on a A13-Olinuxino and an A10s-Olinuxino.
> 
> It doesn't really matter, but can someone clarify why this driver can
> be reused? Did marvell and allwinner license the same hardware block
> or is just a really simple driver that does things in an obvious way?

The Marvell and Allwinner controllers share the exact same logic (which
is definitely not trivial), based on a finite state machine that
triggers interrupts at each change of state, each state being a state in
the I2C protocol (like address sent, data received with an ACK, etc.).

The weird thing is that the only difference between the two controllers
is the register offsets, and that's it. The state numbers, bit index,
etc, are exactly the same.

So yes, I think they both licensed the same IP.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
