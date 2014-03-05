From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/5] i2c: mv64xxx: Add support for the
 Allwinner A31 I2C driver
Date: Wed, 5 Mar 2014 17:34:30 +0100
Message-ID: <20140305163430.GC9228@katana>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-3-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Return-path: <linux-sunxi+bncBDP47C6LHEIJTJG5TACRUBEDRPNYM-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393950521-4173-3-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2014 at 05:28:38PM +0100, Maxime Ripard wrote:
> The Allwinner A31 I2C controller is almost identical to the one used in t=
he
> other Allwinner SoCs, except for the fact that it needs to clear the inte=
rrupt
> by setting the INT_FLAGS bit in the control register, instead of clearing=
 it.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Applied to for-next, thanks!

Still...

> +	if (of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
> +		drv_data->irq_clear_inverted =3D true;

=2E.. next time an errata is needed, I think it makes sense to refactor all
these checks into one struct which can be used as match->data directly.


--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTF1IWAAoJEBQN5MwUoCm2BE0P/ROppN1iC50iHQsjp8knwcjv
7Ht6YAb3joEDy79k/H84wMcAWubWnmZnGwYA19RQqfar0sqPOh0XxYQhxtZaCakJ
udn04WMHwrLMH0aKQZEdvdYw7Ags+hgphZkD1wlaEjVogxPduWN0speqzDTrjyQ2
8Zt24uXOgmrMql/Tq48qyjWn2Uo8eLw63Q1aBYm571thJ+KR1YBJCofYRyyvrRed
Xctgo6UNWZIaM6hsV5o+HRunCKcFZL0WBEskQsucSkNVRiPmSaskx1tk4ay0WjZN
O+Mtg6mFS+4QZg51xgsX+SNEqcF7yzYxqL8p7RIOR24DbJDtymd2i/p3JwtXZEqe
b97ZrcwA8z3TenE22trmnMj//8uCYVdNyo+34S6Z74qnFVwcl+6cyl2aEwjDsneH
41cJSsv90wh8XNvLBFBTrzlAFIoM4UE1Uoxa6n/eeSt9/VQ3oNLMMMptZtXFmEZ5
ksNEdvkMG5y3W6LzvcrRRe7hEmvoH46ZHHLnv8eCdor+C18UWwY3TjnRFRWd1ryS
/3c6wNsFiskwDZIIAuMTWpIv494LNp840NFAepGluWdpxbh4QrpMaVRKJGnyjMvh
CQj4QiNycG8PzZ9aPCpUFYv228/4ryiIYcqjVVz0E9j7oQtx4ktDDXAux67N0rGV
HpQHzcm+etPx+c8QDcwX
=Xk19
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
