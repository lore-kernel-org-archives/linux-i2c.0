From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix circular dependencies warning and
 compilation breakage
Date: Fri, 7 Mar 2014 15:24:05 +0100
Message-ID: <20140307142405.GB28943@katana>
References: <20140307111858.GB12274@katana>
 <1394199795-5516-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394199795-5516-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


New patch -> new thread, please.

> This patch fixes the circular dependency introduced by commit 370136bc67c3
> ("i2c: mv64xxx: Add reset deassert call"):
>=20
> drivers/video/Kconfig:42:error: recursive dependency detected!

Please base it on i2c-next. I already applied my patch.
Your patch fixes the build error discovered by it.

> Since the reset framework doesn't define dummy stubs whenever
> CONFIG_RESET_CONTROLLER is not defined, it's the only sane way to have a =
driver
> that compiles in any cases.

Paragraph needs reformat. And please drop "sane". #ifdefs are not sane.
Fixing the reset framework would be sane.

> @@ -900,7 +902,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  exit_free_irq:
>  	free_irq(drv_data->irq, drv_data);
>  exit_reset:
> -	if (pd->dev.of_node && !IS_ERR(drv_data->rstc))
> +	if (pd->dev.of_node && IS_ENABLED(CONFIG_RESET_CONTROLLER) &&
> +	    !IS_ERR(drv_data->rstc))

Why don't you simply set rstc to some ERR_PTR above if not
RESET_CONTROLLER?


--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGdaFAAoJEBQN5MwUoCm2IWkP/0Br+9EdpPTwXb6yBDl8Zt7g
qcbGp2cw7D9+n2FN0vKfCw89TZFYRDp2YrUAtRE4i/Fa9mAGbc45jyhjSekHmUOY
D6hcSNxN2wvuwUo1JkJdoqcEMBoH1gDCvtxUFdmKuyoCnb+TnO7B9q4EHqfs2SqV
Fxpq41tyPdH26zvpcfPp9OazBTT/etNWTffefURHb+szUmtIw9ZVownP6n0weGr8
CixgDhELp8Ka4A2rZIJI3EDZb9TtMGf21uEIcqZq8paMiFKYEC4RLfV9OU0IEKAM
YRmOi+6Nex1tSGcICaqGGmRR9gZNrc7Tkw4W+39J9eUQWSq6DR8S+0LV+3HjO2Yh
7Vsot+Tf8+Bn/uwe+dv5slY5t5Ab/sUcJIED6WXG6zbfurGUQRQX8GfQjJsmDWrY
RqKMUQ66jrWjm8St1mejZMX8XrIFfTALaPKFNan2CAhehpx45/ntoqE2gAJcPi7N
iP/wty1Vhd1emLxRHvFIkAz6VGbe+F0HWWXdBCORhzp+3QT/ljjZDdvdPJWg8gBf
IAjW1WMeHRjusPqkE3Hsk1QtTg1uyOpL9mttaZY9geesxHNlyCMtUuVVOGBcTxu7
hoRBuW7h3SqzMdjCNXCsp+EPHUWIclcS/HlbuZSkmOvhyPNBGTUuAKD/DpnB8LCn
vIC9865B1zjQ94Uk3ztJ
=h30J
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
