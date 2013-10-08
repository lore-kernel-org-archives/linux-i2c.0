From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
Date: Tue, 8 Oct 2013 22:53:04 +0200
Message-ID: <20131008205304.GA29121@katana>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
 <20130830054858.GR7656@atomide.com>
 <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
 <20130830082712.GT7656@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130830082712.GT7656-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2013 at 01:27:13AM -0700, Tony Lindgren wrote:
> * zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [130829 23:36]:
> > What about concerns from Wolfram:
> > " Other people might be
> > depending on subsys_initcall to get I2C active before they want to
> > activate, say, PMICs. So, I fear regressions, since deferred probing
> > might not be available in the needed places to avoid these regressions."
>=20
> There should not be any reason to get a PMIC activated
> early on. The system should be booting already at that point,
> and the PMIC related init can be done later on.

Okay, here is a more concrete example:

Consider the amplifier driver 'sound/soc/codecs/max9768.c'. Back then, unaw=
are
of deferred probing, I wrote the following code to get the GPIOs (which are
optional):

	err =3D gpio_request_one(pdata->mute_gpio, GPIOF_INIT_HIGH, "MAX9768 Mute"=
);
	max9768->mute_gpio =3D err ?: pdata->mute_gpio;

And later in the process:

        if (gpio_is_valid(max9768->mute_gpio)) {
                ret =3D snd_soc_add_codec_controls(codec, max9768_mute,
                                ARRAY_SIZE(max9768_mute));
                if (ret)
                        return ret;
        }

So, the mute control will only be added if the gpio_request succeeded. On t=
hat
particular board, the mute GPIO was wired to an I2C GPIO controller. If I n=
ow
change the I2C (or GPIO) driver from subsys_initcall to module_init, then t=
he
gpio_request in the amplifier driver could hit -EPROBE_DEFER and the mute
control will then disappear. Yes, the driver can be fixed easily, yet I fea=
r a
number of regressions like this. Instead of people digging into why things
disappear after a kernel update, I wonder if there is a way to guide users =
if
this happens. I didn't have time for that, though, sadly. Still, it makes me
wonder how easily we could shift from subsys_initcall to module_init, altho=
ugh
I'd really love to get away from subsys_initcall in device drivers.

Regards,

   Wolfram


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSVHCwAAoJEBQN5MwUoCm2X8wP/2UEIkk43YWP4ybdMUb+KKIE
zLlz4XYoYc/W6Wc2pvr8rc5B8Yoimqve9OaivLLGgMuDTGSNqD06/64kqcvCWgVN
OpSNZ9ougjGThdoANJPVxiuy+tlf8vYDbD0mvkyYqso0gCPqQXT1/S4vup8HheyY
YgjSKui1gx1YxFjD/N433Ihhi8t2cdZ06+W+3bYq1N4ltGAxg5vO/shbCyWkb4Ie
Y3tpINlOfQd3q0g6Ug5oFMBIegXOXw+aRQiWHM20iEcrKw1g69PzSFVvEy2O19EK
xhyLIpFj+q87IQkA8Tsv+cJx2tF3Gg8y/NaTVtZrymr8GkECfMHFyy32zOjZa+o4
3NVB9QklGnS6/Ad7GJcGakGry1PqpVJQVenzJ/hG+s6N1OpoQujyoNbuMl4l99Os
OQVo5EIVLDgKPTLngwfniwlpDuu/ZVcHj14PwXRljn/2M6wdGYqmJ1ksAUjyaAz4
Lo9Qh3wFpPdoVZM4GH2aN1CQbrNHTN0CiiecWHsoA8NIs2Mr93ToemWjTLiPNRl3
SEYe3Lwr/RZzsgYk79pEAbZHDCcJuyPSCJ9CPSx2M/AMQ39FQ0X7gWWYcRx8js8n
UqwMlKaPUa6l8tFv5jqcFgCwcTqMgDBzmynVHYND/qkonIG+J5DVJovugvEFCMj5
3TyCTh2YmOm9evmcVaoG
=9UPm
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
