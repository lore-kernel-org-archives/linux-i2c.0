From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: mux: pca954x: Add interrupt controller
 support
Date: Fri, 13 Jan 2017 19:54:17 +0100
Message-ID: <20170113185417.GA1449@katana>
References: <1483952576-5308-1-git-send-email-preid@electromag.com.au>
 <1483952576-5308-4-git-send-email-preid@electromag.com.au>
 <383ee3cb-b452-259f-486f-682ea9526708@axentia.se>
 <1284b1c8-bb90-fbd9-53a2-0c36f2597b29@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1284b1c8-bb90-fbd9-53a2-0c36f2597b29-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >BTW, what does client->irq =3D=3D 0 represent?
>=20
> This one I'm fairly confident on. Initially I had "client->irq < 0"
> Which caused problems with an i2c mux that doesn't have irq's defined in =
the dt.
>=20
> This commit seems to confirm that.
> commit dab472eb931b ("i2c / ACPI: Use 0 to indicate that device does not =
have interrupt assigned")

In the Linux Kernel, 0 means no irq so one can write:

	if (!irq) ...

There used to be NO_IRQ per arch but this is converted over, although it
takes a lot of time... If there is a HW IRQ0, it needs to be remapped.
But since we rely on irq_desc these days and not irq numbers, this is
easy.

At least this was the transition a few years ago, but I don't think
something essential has changed. Please enlighten me, if so.

Regards,

   Wolfram


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYeSJZAAoJEBQN5MwUoCm2kEAP/iDnVBMuXXzptnBfHv2EGTJd
EEqpMeIuk6Dcm7UJQh2SrfSKK6H3gFhQGxocCtiF4EPyDczLTDolMdlDqoBO1xHu
3WODCgDzrMwx3KQgtVtAfqWSLDP5nHc6RKh5K/alqd/8CWkyU8O1s+EdzRgkbdWB
60Lwvlp9RmtqMVrC82Vd804v4v3TI1sCU8adr8gKvNEMx2VySl6osbBwhGMeY8W3
769ByLZcdLU6uWjzDQveKVJsiszH1DHqzCeCSMsLvqTm0nldMH0shnXVy23+dx+R
iUY+dirMvMhJiEQMISYJsbKMsHgin+WCr0Wuc1KgTNcjF4Yb3Vicl395KoWsvmMV
sbu7k6Nc4ATMB6RyoortgZ8hURe2Dhc6Qqtu4lLYNWiv5wVmuYDaE5bL3ZJgVSRi
eYGDTOaj5fDL2+yzDoqKe3HczyUU5i2lH+Q3KL8t5EiY+nNd6iHOhnENUdrw2xQp
36xJ3W5rzmedNNN1fHHagQNTvJ15btqOorp3B1nzOTUBg9P+QZgXCEIqeK+lJ4B4
mTlsgtPYLtalF6fj8LUPrpposmTxEsDEq2mC+18ao0iCD/6IEVDBgZqdIf8whi2N
FOXJ2ZgU4VIzsznZ3bV0PkCL/i7ZJVnz5eNJsOsvshtbPywSPSqphLIwy3FTHCzP
dqX7X55W65XGlW8TSmFE
=UiFk
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
