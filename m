From: Henrik =?ISO-8859-1?Q?Nordstr=F6m?= <henrik-N0bZODiMPoV/1Aw6q1k8hdHuzzzSOjJt@public.gmane.org>
Subject: Re: [PATCHv4 7/9] ARM: sun5i: dt: Add i2c muxing options
Date: Wed, 12 Jun 2013 10:29:48 +0200
Message-ID: <1371025788.4659.20.camel@localhost>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
	 <1371024438-16631-8-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDOLXAGRVEERBFHD4CGQKGQEP2L7EQQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1371024438-16631-8-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ons 2013-06-12 klockan 10:07 +0200 skrev Maxime Ripard:

> +			i2c0_pins_a: i2c0@0 {
> +				allwinner,pins = "PB0", "PB1";
> +				allwinner,function = "i2c0";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;

Is this right? All other use pull = 1.

I guess it's board dependent depending on if there is external pullups
or not on the i2c bus. I have seen Allwinner designs both with and
without external pullups.

It will not work well if there is neither internal or external pullup.
And may stress the i2c components a bit if there is both..

Regards
Henrik
