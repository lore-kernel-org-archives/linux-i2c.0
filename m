From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCHv4 0/9] Add I2C support for Allwinner SoCs
Date: Wed, 12 Jun 2013 14:38:12 +0200
Message-ID: <201306121438.12549.arnd@arndb.de>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com> <3315236.ZNXhyxmCRd@wuerfel> <20130612113849.GG16699@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDEKVJM7XAHRBRGX4GGQKGQEMC53GOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20130612113849.GG16699@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 12 June 2013, Maxime Ripard wrote:
> The Marvell and Allwinner controllers share the exact same logic (which
> is definitely not trivial), based on a finite state machine that
> triggers interrupts at each change of state, each state being a state in
> the I2C protocol (like address sent, data received with an ACK, etc.).
> 
> The weird thing is that the only difference between the two controllers
> is the register offsets, and that's it. The state numbers, bit index,
> etc, are exactly the same.

Ok, cool. Great someone noticed!

> So yes, I think they both licensed the same IP.

I wonder if it's the Mentor Graphics Inventra mi2c block, which
would make sense given that Allwinner also uses musb.

	Arnd
