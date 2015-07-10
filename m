From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v3 02/11] i2c: pxa: No need to set slave addr for i2c
 master mode reset
Date: Fri, 10 Jul 2015 16:14:40 +0200
Message-ID: <20150710141440.GA6594@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150710081148.GB1528@katana>
 <559FBCD3.4050402@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <559FBCD3.4050402-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 06:08:43PM +0530, Vaibhav Hiremath wrote:
>=20
>=20
> On Friday 10 July 2015 01:41 PM, Wolfram Sang wrote:
> >On Tue, Jul 07, 2015 at 12:54:46AM +0530, Vaibhav Hiremath wrote:
> >>Normally i2c controller works as master, so slave addr is not needed, o=
r it
> >>will impact some slave device (eg. ST NFC chip) i2c accesses, because i=
t has
> >>the same i2c address with controller.
> >
> >Just to make sure: Does it? As I read the code, slave interrupts are
> >enabled later only when slave mode is selected? Is that a HW bug? And if
> >so, can't the code just be moved into this #ifdef block later?
> >
>=20
> Yes we could, infact I thought about it;
> but I would break recommended sequence here.

And did you set the "own slave address" to a value which one of your
existing i2c slaves also has (without enabling slave mode)? Did it
disturb communication?


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn9NPAAoJEBQN5MwUoCm2s50P/14d/hdv+zOYstTUqIyZ5Evg
JhpUQlf2Ft/mVNh9U/zvqLsi0h3ryr1AWNku9G/zRFEtW0C1xSJ1jbt5vKPgDCar
UYjT0UHFTfCJsK+k89Xp9lOkcCDoYnt3lbIqhDS82JYSrn4rg/UvNj+Wj/UeFB73
j+VJMwxUwkdUK1ih7haL4zSo6NQ5zkbYaybRUZcIPjYru0FfTcDvc2Nsr3cCSPw5
4wjqsyID+DbpDM+XBpVKvwWHqvo6fPUy2C6xxWGLWsNkROQfxkLLLWPt+x5q0sDe
YVw0aDdmvItS3NpOf7jx44kBLFl/l7CwBJkka46H84Tk70sYwTcA86SBrQSvb7TS
98WRs8smaN2YNtmOO3bDiPgGjcqaZ3QqfYZs0Jgu3EVzTiCPrvA3NcbwlXuTrraR
VPOkuVNozCaFI1uxLL1jlC40SE6YzljAl4Ej5f6oKehht8pyxdLlJspdazpvc1pW
gedXNUZEtf/NIjn5Kktzj6FRz1lb20OZXsC2CEvKCFooitNMeU+4evfty24w1SKi
FM8ZfkrphWstxCVKmv8zF+bU5WoaGJ3WpNrzc+f12J02SwxGdiuw3HizfaAIUfQz
3eUICJuuZQmFtTdfV0DboQrr6Tv1qqFV0PS+LHd9b9oikpsKeqINHOw/YUMMDNSo
/7amZKiH7lOanuyGHuoQ
=M7gJ
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
