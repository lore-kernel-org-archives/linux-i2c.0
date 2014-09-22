From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-rk3x: move setup to the earlier subsys initcall
Date: Mon, 22 Sep 2014 19:13:27 +0200
Message-ID: <20140922171325.GB1404@katana>
References: <1411370675-27866-1-git-send-email-zyw@rock-chips.com>
 <7192455.FveG5nGWsJ@xq-nb>
 <CAD=FV=VUoK8SDng6O4-VVq8UZf88b3bSe-hQMht3R2nmYXqMFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=VUoK8SDng6O4-VVq8UZf88b3bSe-hQMht3R2nmYXqMFQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> In general you are correct.  You can get by with lots of probe
> deferrals.  I don't personally know of any case where things are
> broken with the current code, but it's really nice to avoid the
> deferrals if possible.

Yes, we all want proper dependencies and ordering, yet deferred probing
is the best we have.

> Given that this is a core SoC i2c bus and is used for _a lot_ of
> external connectivity (including for connecting to the primary
> regulator on most boards), bumping up the priority in the init order
> makes a lot of sense to me.
>=20
> This also matches the i2c busses of most other major SoCs.  A selected
> few examples:
>=20
> i2c-gpio.c:subsys_initcall(i2c_gpio_init);
> i2c-omap.c:subsys_initcall(omap_i2c_init_driver);
> i2c-s3c2410.c:subsys_initcall(i2c_adap_s3c_init);
> i2c-tegra.c:subsys_initcall(tegra_i2c_init_driver);

They were "lucky" to be around before deferred probing and using
subsys_initcall was always considered a hack. I am not accepting new
users of this hack unless there is really no other solution.

So, NACK, since it doesn't solve a problem.

Regards,

   Wolfram


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUIFi1AAoJEBQN5MwUoCm2qO8P/30WwuZ8atHElTOyMQEp+st1
CjKiEFQGvM9FL9Ms5iEcwvghyRp2r2tMNXoM/aScVpH+jjrwvIAbroZZSRbLO3u2
YhEC4qSUpoZL85lfqn1/1CDJErWuA/5vZQFzTxGVZNujv4jR101eQ9RkTuQ/SWF/
5Cpsi7G/UxFhXIKqx6Dg8zqEZrtyA9dMCoq3P+vLIoyv39tT0AhGqy52ika3RmUI
NT9YsFlfaljRuSC/GBP0CVUCg1RkC9QMUFO9psD1kiE2FLcay9mR+g8nIOfFvC4t
Yjqtsmc+sJoCIrbXcGem6FJ33pbmc2Teivne0tZfpjUJb56IKqxKpCla0TNMTj1h
HVw6Lq9HiN+c0+kiFVIL8CVnggdWmWKUST0qlfJSRnNuTAusZqx2KcIXpvP4/As/
1V5OtP5cn1t4QvZVHOiec0AMu325ZFUSUuVo3JDo5un+40Oruf88sTcCEk3SNK/Y
Baj2rs051yAXPNj9zu+o8NfIJPev+wl5B1SHoFW/klSpD3OtKFTBC32bSjP0DwYN
dcejTo4ylF8Kf+aNdqMCKkhwx4i8ovwH/pdwP76nmxuC97AfEa58M59UvMfeouKt
+NNv278g863auc72GIdLx9F/4JMXXDtYwnFjF5AN7rzivk5wBsjJ8NpO8VF7KbAN
JKjjgmk4NsCIZtD79u+S
=kkDh
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
