From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 1/3] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
Date: Fri, 3 Apr 2015 20:21:38 +0200
Message-ID: <20150403182138.GB1298@katana>
References: <1424288043-2995-1-git-send-email-fkan@apm.com>
 <20150323183153.GA1128@katana>
 <CAL85gmD9qsjBdY2Qyv05AjutU_uad7aaRjxORk8om8WeRQM1Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL85gmD9qsjBdY2Qyv05AjutU_uad7aaRjxORk8om8WeRQM1Eg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Cc: patches <patches-qTEPVZfXA3Y@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> +     paddr =3D dma_map_single(ctx->dev, ctx->dma_buffer, readlen,
> >> +                            DMA_FROM_DEVICE);
> >
> > The device should be the device of the dma channel.
>=20
> The device is not visible on linux, DMA is done by the helper processor.
> Perhaps you cah give me some idea how to do this. Thanks

Well, that is a question for the DMA maintainers. But we can fix this
later, I guess.


--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHtoyAAoJEBQN5MwUoCm2x+sP/2dDkCCGyS39Cce1fzc0K190
O12OEmy4eS48N4vR2b/srhz9LsYPVvuNEZLeBY2wE1Ki26K3+rDKiLKaeUPO97sS
s62sEzqt5v6850Yh/SdDsfNMMg8SmRPAwvwbfgNZs74m4Q0lZwkGrnbowQCC0eu4
i4jA+wryp8Bx+fQjjhDCqfyjT8HjjHcoV5d78jTmZ1tXzoIn/3NVMeqTEJsfhSPE
/SD9lY2cti+7dZUl4dgs1W1hXpaceHRbkZygnzsCSQkLgnA+Z+gDZGifrQGYGxxe
Efvlu8k/VqtX5pjyTQ3daIXduhIh+sH11myX6l8zUgkDuR45QF0biy54+8KfWB9w
jEvKhfhlW2WLG/AL/KMXd1tsR7b34hgr0yMcSMMEbDCzUuR83UhLHl4j68CE1yfP
YS05QvNk8Pc5MSaCkJ63lUsnA2kJYwpnGa3gU15IpO/RcimLZ/VZ8jR/FJ1sBwQT
KVkrSfGTC+FYo3uOVSYs9pQgv/iQnuWvmP6mKkf+iyg1PlYgfrcd26UIW9c+aclQ
+3VJPrTIAd+SIcjWrOg9UGmtDnsZeFPU3esPoY+4htP/kkUYscegqjdl6tpZ/m+c
FU9iVlA7f25vheBAgs4ROtPPwWZ2RcWo4vwGg7qQaRoRqoxFqgCkamsh0Y+aYkKv
IALHEPIq2OjCpxClYVoO
=8KAN
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
