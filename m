From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv4 7/9] ARM: sun5i: dt: Add i2c muxing options
Date: Wed, 12 Jun 2013 13:20:21 +0200
Message-ID: <20130612112021.GC16699@lukather>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-8-git-send-email-maxime.ripard@free-electrons.com>
 <1371025788.4659.20.camel@localhost>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB6VS4GGQKGQEWIIWGXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1371025788.4659.20.camel@localhost>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Henrik =?iso-8859-1?Q?Nordstr=F6m?= <henrik-N0bZODiMPoV/1Aw6q1k8hdHuzzzSOjJt@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Henrik,

On Wed, Jun 12, 2013 at 10:29:48AM +0200, Henrik Nordstr=F6m wrote:
> ons 2013-06-12 klockan 10:07 +0200 skrev Maxime Ripard:
>=20
> > +			i2c0_pins_a: i2c0@0 {
> > +				allwinner,pins =3D "PB0", "PB1";
> > +				allwinner,function =3D "i2c0";
> > +				allwinner,drive =3D <0>;
> > +				allwinner,pull =3D <0>;
>=20
> Is this right? All other use pull =3D 1.

Ah, true.

> I guess it's board dependent depending on if there is external pullups
> or not on the i2c bus. I have seen Allwinner designs both with and
> without external pullups.
>=20
> It will not work well if there is neither internal or external pullup.
> And may stress the i2c components a bit if there is both..

Yes, but it's a default, so by definition, it won't suit everyone. Yet,
it has to be there. And every board is free to override that default in
its own DT anyway, so it's not really a big issue. But like you pointed
at, we have to be consistent.

I'll disable the pull-ups in the next iteration for every node.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
