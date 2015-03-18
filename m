From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
Date: Wed, 18 Mar 2015 21:31:51 +0100
Message-ID: <20150318203151.GA12072@katana>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417448047-15236-5-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

so, the bus recovery patches look fine to me in general.

It is only this one question left which I always had with bus recovery.
Maybe you guys can join me thinking about it.

> @@ -376,8 +366,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  						      dev->adapter.timeout);
>  	if (r == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
> -		davinci_i2c_recover_bus(dev);
> -		i2c_davinci_init(dev);
> +		i2c_recover_bus(adap);
>  		dev->buf_len = 0;
>  		return -ETIMEDOUT;

The I2C specs say in 3.1.16 that the recovery procedure should be used
when SDA is stuck low. So, I do wonder if we should apply the recovery
after a timeout. Stuck SDA might be one reason for timeout, but there
may be others...

Thanks,

   Wolfram


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCeC2AAoJEBQN5MwUoCm2RAUQAJoY3djE5kdIc4SzhTystpwy
DN9XAGo56Bo5t3fGeB4cyuT8xZsxhq5fq49l62OmIfpL0gZBMpju8gWXWPRpF5Jp
K6crm4Z9qFyo7QMzBanqir3iklYYsTHAh3msQS72nL1QzYkPxc05Viz4WGGKkBob
Fw2YLrjg3IF/rN+2btA/KIiW9Z8Qx38Pp3EbLwcWwmIIEVTi/zDOkX2+yTO1w6r7
KXVdXwyYMNcUvdP0hF6zLRoX0rcjrkJwq7MU/q1XJwPm0fNWr7hPahMuaKrVHqXH
esyOjnqCRrq8UAyChLgkbzcdnZWat/4LppzMG9fI1XZUIUTbjIElvcvbuj8BfUuF
uS4ihPw1jlqfNX37E6TEO4Ufzbm22dMgXuCrV/eFqPpynezziWjkf7k7skGRJpDm
uK5gS9490XOCdPGIZdHVW/Pn523RwVh19dhfW7FHF2wBaDL+7Dd31vhKDT1/TNoQ
KNOil6l6qlwYwDIqguDry0Se8bpCbtI2qK7+QiCIR6RZ/bO++xhgFlBub2bbZmD6
2q1VQpLfgnfGSXp5isSKJr/u3d7P0tGUM2DvtG8kf8QWVUXXx8RxVXf2com2rQ9e
KnymLvGUTdeoSJdtFQo0RTJJv7wkjhEIZnD5iwAcEIKSE38ULMgs3TDQcpzw/XTP
X+m53oZ1P9mGLl3Q6xWe
=ydUi
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
