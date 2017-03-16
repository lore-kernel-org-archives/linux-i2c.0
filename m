From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] Documentation: devicetree: move trivial-devices out of
 I2C realm
Date: Thu, 16 Mar 2017 21:53:52 +0100
Message-ID: <20170316205352.kzg7o76ft6g72256@ninjato>
References: <20170306143859.11881-1-wsa@the-dreams.de>
 <20170313075457.GA1431@katana>
 <20170316205111.lpykvpbeaa4mih4n@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ucwxawrtyxpbmii7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170316205111.lpykvpbeaa4mih4n@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ucwxawrtyxpbmii7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:51:11PM -0500, Rob Herring wrote:
> On Mon, Mar 13, 2017 at 08:54:57AM +0100, Wolfram Sang wrote:
> > On Mon, Mar 06, 2017 at 03:38:59PM +0100, Wolfram Sang wrote:
> > > The I2C directory is for I2C master controllers, not for clients. So,
> > > move the file describing trivial devices one layer upwards where it
> > > fits its generic nature way better.
> > >=20
> > > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
=2E..
> > Rob, shall I take it or do you want?
>=20
> I've applied it.

Thanks a ton!


--ucwxawrtyxpbmii7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljK+1wACgkQFA3kzBSg
KbYwCBAAmLyvKkDXn3MsAYIPqSdqhTO+LmC1h7Sij3FlXPJ0jmrTSgw198WyyNZ7
WGeiW+djKtLqHinZnIUd4uGe7LF3u4jFBQml4azI/e2EutupMbC8dBCKRcc95hHD
1BDnMKTnR3xUBeoLy50lfNYQ2KaSqegjudix1Pb0Kpe6GGH6wkQn5q3Tqau6B5OR
DETfoMZfrVXzUVWNJgTwZ4U25+QeJc5suJI2TmZ89mwSBlV3GVah08xcA/XMv2uN
TEHDgy6Yt4l1ijrQXcY6tvJYvbCOYt/yq9xQ9WkHsfl62niNZRXfrL44WHKjj9Ae
HS0vvsTiESVMaOE09Kdz22l5Toc4EpTVDidQs/duWbgkkGJ1g0T+qsssKrvNejxZ
oVaTY5rWjKmbegA8djwE5eLTOKHE51tajPXk6kLQ9RFACSabDokLCGDtz2tf4h3a
urnQbtLpH9cL+7U+7bFdWBZAWPseCKhCwmCEoFxURtTvEGGR1K3hv6YhxJS7VYEj
JC9H900GIohF1DVrISnczcXk98Ls9FsxEMGIHDKuQJ/7vkBXWWBOt7KEOj9W/xL5
+sHQ98cHkN2FbUoTN3OxdA/gLVIpUvOk/ItXPbOAlaIKM87RPDdx9KMlAtrJnXCT
UZYKkICYzRzsJbyhjzM06G6Ire9Ahx71ar76owzUoAgVHUbhuvk=
=eXXE
-----END PGP SIGNATURE-----

--ucwxawrtyxpbmii7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
