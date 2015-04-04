From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: Handling Slave monitor mode
Date: Sat, 4 Apr 2015 17:34:47 +0200
Message-ID: <20150404153447.GA3808@katana>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
 <20150327153713.GC27238@katana>
 <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
 <20150402202909.GA3501@katana>
 <9ef3c612-b803-4937-bb21-0fac03969f39@BN1AFFO11FD037.protection.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9ef3c612-b803-4937-bb21-0fac03969f39-reflc3kr++PT8KeBtZ6NpOhlVc3/7hDbVaz/vdPVXQ4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Srikanth Vemula <svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > So, it is kind of flooding the bus until the timeout? That is not a single zero
> > byte message.
> >
> It will not flooding the bus until the timeout. Once it fails to access the bus it will be ideal for 15 clock cycles. Master again retrying to access the
> Slave immediately after the 15 clock cycles (There is a register in the controller to set the retry value min: 0 cycles, max: 16 cycles).This process will repeat until
> The software timeout will happen (1000msec).

Compared to do one access only this is "kind of flooding", no?


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVIASXAAoJEBQN5MwUoCm2IMMQALG+wDkD/n7H3rmFaNVBbCNy
eZJCrkiZBK3XY8hA4zoY2jEa8YC0fbCO/hcfgeTSwNdmzBpyuRD9Lcc3rmJUEEP0
rnYLzCtE3cbphTB71w/n5ZZANKcgZTCW0J4i1kbA1e7ZhFaURBqZYY3OfLHVED84
j4mDIKFxAqY3VUv0njfuB0z8hyZpONHPFjMnIqMmOo4zEF2rVQGTiFwV8Z3CdUmi
G0pMl4PFzcSlzyB1NkYrRIr8day5uy+KHNubjPeDT1LqAGDG7FERAgJfCe9AgV+N
f0jUIlrjAn0R27/7Lk0v/E2+6dFXAsb5WjzTS9vhwFE7cWAwxqBffSYfAU3vATEy
S1XPkgXhg+WLZoB/rjK5nDuzaJCVsLA9PCypD2R6bE9ky78bS2V0Bkt9qbFo8sYx
UW6o5jUlKsNApWIIfikYTBmOeSJLQmm2t9u817AkpDuTcOdDhPgxBeVNVrgqPi6H
MEcvT9CI+5VtxdwkN+zQRzWXAEFNa3xsPelqaWGO+KpVGrfVxFTSADpO/KlcxqIO
/EyX0kRgLrdJQZMt9Cfoe1rWwXUwZ5Ay/px29HbKqSQ1zpVTTwZo3MAV3Od1IQsZ
U5UP10vSwXN+FPqJKwQUVNuE2kQjZcKw2ZLiEimCJRHm65BB0uorga3G3XrLmjax
yrMENvCmXssfM/FDXano
=hJJa
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
