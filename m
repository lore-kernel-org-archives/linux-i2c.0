From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: Handling Slave monitor mode
Date: Thu, 2 Apr 2015 22:29:09 +0200
Message-ID: <20150402202909.GA3501@katana>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
 <20150327153713.GC27238@katana>
 <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> In slave monitor mode, the I2C interface is set up as a master and
> >> continues to attempt a transfer to a particular slave until the
> >> slave device responds with an ACK.
> >>
> >> Added this feature for zero length transfers enable the controller
> >> for slave monitor interrupt and get the status. Disable the slave
> >> monitor mode feature upon successful handling.
> >>
> >> Signed-off-by: Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> >> Acked-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> >
> > I am not sure this is going to work.
> >
> > How often is this access tried when there is no device? It should be
> > tried only once.
>=20
> Once slave monitor is enabled in the host controller, it retries till the=
re's an
> ACK or slave monitor is disabled. The SW wont be involved and need not

So, it is kind of flooding the bus until the timeout? That is not a
single zero byte message.

> be interrupted in this gap. The way this feature works in the controller =
though,
> I'm afraid there's no way to distinguish between no slave/ busy slave.
> The out is the software timeout in that case.
> Please suggest how to use this feature better.

I suggest to not use the feature and accept that this device cannot do
zero byte length messages.

Thanks,

   Wolfram


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHaaVAAoJEBQN5MwUoCm23kEP/2W0f9Rg9DLF+nQo/0PSbO+n
sbzZ4FD5ZrS+ChNR/jLAnw5cSrB/OOy3Nz92AOZExh91k71SDz3YQS3+cfhp/QxD
fnaiwb/u19Z7aJNXWxHatyNzneEUAvfrA8mQsVRIXGXO5Xy1lFD5mdeURq3sMcUo
YIbgahQzRY8tb23XW/yTJQfrbMMQ53nxTeWS52qYes8tysTOFnIESW37ry8Lrlgo
CArRXlVdsRluc0v8TCocsELgWZqHklhp03+xD7C3GQPZ0lt5ZjzRVDCwJMnFg6Ei
cqtmZhPPA7fNi71Xs6XBCr65ijLhtpdWyx20lYc9HB1I5GFRlmCy1/wzWOZ0Dt8e
uTRvq1/rqCZ78eOy7J3hrSvSQtuFDfdEdNBtGoKfeYVcGUR1yh3wee51hKpbdGZX
oeMaz07g3XHMv/65W048A+P+yuq9ZLo3/5vOBYYQeIUdZWTK8MfJ0I/A3J6BT5TV
IvdbPtaRBRJck8vlDmKJTJmpHjdOzmTYTbEgtuIabMeXvwwb4/xrhfd3fmlQPwlf
FoLAwmQke6dWjtYwA0mmNhfWlkiUOE+ftdsvkozrvoV+oP3zw9Ft0omTF8qaNQr/
2s7WWhEfl1W9Wh6TaT7PpaXdpTv8lc1jN0k7C5uid50YEke/LKII+xIyqD8NdVvO
s3q1alrYQDeiYRVqx0yD
=rOzs
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
