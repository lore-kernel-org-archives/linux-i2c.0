From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/9] i2c: xiic: Do not continue in case of errors in Rx
Date: Wed, 17 Jun 2015 14:44:24 +0200
Message-ID: <20150617124423.GE13393@katana>
References: <1434381480-3042-1-git-send-email-shubhraj@xilinx.com>
 <20150617114159.GA4604@schokonusskuchen.bad>
 <4EED9C67BE3EF440A606099F8E34C52862BB72@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4EED9C67BE3EF440A606099F8E34C52862BB72-4lKfpRxZ5enZMOc0yg5rMog+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Your patch descriptions need improvement. They describe what you do, but
> > this can be seen in the patch as well. What you need to describe is WHY=
 you
> > need this change.
>=20
> In case  the slave nacks the transaction in the middle of the transfer Th=
e driver continues.
>=20
> > What was wrong before,
>=20
> The usual expectation is that in case of error / nack the transaction is =
halted.

Yeah, this is going into the right direction. Please note, that I meant
that all 9 patch descriptions need rework. I know this is extra work,
but really needed to keep drivers maintainable. Please resend the series
when you are done.

> > Because this driver is long in use, we must be very careful about regre=
ssions
> > and every change needs a good reason.
>=20
> I agree.

Great! :)


--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgWunAAoJEBQN5MwUoCm2utEP/34Tu35p+Vq5nqN22YOW49BU
LBpE2gfNwFNip47eawxh7Z6NTrEvk/bhe3fJLXny7/aYtpp4e38SDVtFGAthD1eQ
j0fUVtSN3VU1wGwum0xjJiRQTqtsYN9i3TKYE2DsMKxJoTnJnm/FATdxqrineTjH
GO9F4VsrRdwSpOiBf3G+zKdr3Rgu1QSZFRBGJi1IDjlMm7wqMBDUn72FDLDLAiW1
oynM8JXRg+GaErMpW+ojCLuDq6TE4GugLV7pG9XX/6z7dxMJ5P2hbaL/mEI5tk7a
AEPHw0j5yXcfawcvLeIt8X+6hXlhDRr3SozwvpumKRgghP/RAiJY87hNqiW2kczb
Ut2qrvyhFzPuPXCh7oR0aKGkKqnGC8kiJOZRej8r1VKEJyMnIdv3PBZyWGDukZ8J
SADMpvyYQ7flnrLLkiR7KAM19qaCUpiY3qpozpTaDc88jhG2pzA2BH5qt/rjnr8s
4mv8aXlJOXAMmHEbVT0vdE8CUI2ZTHbFXNsR/Ax0Cj56JJM16ZVE3kaWaHIKdYSu
Np/wVSwsxAvlIKt6wcaxICQBgwYWlfU2uYhrSNW7D4XsDjBCK1tDyAKdjaTEoMLR
LdBUgtVoAwcaoZTUf7qwZA59ywyO2wWSNBwRFFgdfIlfZoSRuy54Hg2IDEw5rn85
Bm9c9N23jSaWfcv3FH/s
=YY/3
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
