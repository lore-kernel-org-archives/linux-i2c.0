From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 16:12:18 +0200
Message-ID: <20170801141218.GA1450@katana>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon>
 <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
 <20170801142936.5df48702@bbrezillon>
 <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
 <20170801153414.6ce34ee8@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170801153414.6ce34ee8@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar
List-Id: linux-i2c@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The second way is to have a number of #ifdef and complex
> > Kconfig dependencies for the driver to only register the
> > device_driver objects for the buses that are enabled. This
> > is also doable, but everyone gets the logic wrong the first time.
>=20
> Hm, I understand now why you'd prefer to have a single bus. Can't we
> solve this problem with a module_i3c_i2c_driver() macro that would hide
> all this complexity from I2C/I3C drivers?

Do you know of devices speaking both i3c and i2c as of today?

I think I3C/I2C is a bit different than I2C/SPI. For the latter, it
might happen that you have only this or that bus on the board, so it
makes sense to support both. But if you have I3C, you can simply attach
the I2C device onto it. I guess you would only implement I3C in the
device if you explicitly need its feature set. And then, a I2C fallback
doesn't make much sense? Or am I missing something?

OK, now I know that those I3C+I2C devices will exist, even if only for
Murphy's law. However, my assumptions would be that those devices are
not common and so we could live with the core plus bus_drivers
seperation we have for SPI/I2C already (although I would love a common
regmap-based I2C/SPI abstraction).


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmAjD4ACgkQFA3kzBSg
KbZn2hAAqS/CMHPeGV3BOaKeTrZ5K+wyuhpekEn5kMQJsGeq046rXUayOT1VEvvM
WvZtldBi1QXb28l0vz3Rkyxear6RRcRNMvBkC2Sf6Qie0fMRVkNZSj476BlV9TG5
hIha9yKOYscvaPTViaeDG9Y69iCgzWNuy1RtMHZMwM+RdEwWuK16lxtPTvD0evo7
dhw7jTwAskpfVG6b/M3d+/FEmBYrHYfLSdiBzMgTnm/5oiaATu2uBAsMJOTu7apC
nXuM2hwSTYAj9WKv3PePGUPr1strqu0PXZilQOMoOGxCwv2CPXgiux4ujD7RKPRU
oYsNisBT7Wloxw5IkbkeGWTeRRn0TgLl/L9/EP2uDrgDSgaB50VwN2g5JOfrXMZ8
DhrQXAaTH+mkoPmvNLOBEQWpIAGWscCl1ff7iV3cksBlP1oNJ+PLSNWSdtpfnb3u
bFJjWWpyBstZoLRTvUBVPPZ43KNlQlgwbXSWQ7Zx3sL/lByxyrHmC9wFnR7WYDsN
uLl0FIY9msF2CbxRNIZAK+xw3ePn6a1+e8CrydiTTxJPuJkG2jvwpxJ05Xtqg+Kn
aTh6IRhBJatzeLoVVry1IgvC6dSAE46aHPw4cMB/BOWNYeC74t+2LXGbx9FSPhWW
y2IIeorxRVYIIgA5izmxVGZVkByFm6mVwsCq8UTWCh2G5/MjAeQ=
=B8Vj
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
