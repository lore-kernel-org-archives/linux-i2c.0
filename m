From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Tue, 13 Jan 2015 16:12:58 +0100
Message-ID: <20150113151258.GH7660@katana>
References: <1421082094-10267-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421082094-10267-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 07:01:34PM +0200, Pantelis Antoniou wrote:
> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> This is required to avoid multi probing when using I2C and device
> overlays containing a mux.
>=20
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Applied to for-current, thanks!


--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtTX6AAoJEBQN5MwUoCm2HdcQAJ1gGX76PYeL9L3vx1c+PN6Y
AhFpf4x/NluTMEskDT6tfMQV13GtPL5t1+KCIIGFGw6hCpngCg8jSCCbXg3eQR8M
Cs2lM0AucIratXvN3B3CxzURGDlJCG863ITA5ltjMMXUPdIubdXCSQiDTLI77v3z
u6DC79T3Am6akWW+lIZDI+6A4OJHb1WKs4gklkr8FA7RJEUnQQmTdmTtgUCt6jU4
rTWfwJ0OLCTVIRtsuFlHEHKsZn7F0J7MnH0ABIm/Ov0h8y/DaaKgUbGELhc+pp6j
QviN6xkWJwmiOCNOdJcBb0MFE3bM2ILvSUlD+YpjrzGxr/z9pTFU2kCx9/LXXynS
flS5oyXJDV8MsqnVd+6k/0mICUiOEkvv7YdJf0RauYNI5YzydoE9PSrAvSk2GUwl
Z+o3hIl6B5SU+29nwrn/XsddmmY+As9X8Ar5jWIn9Ln3v9CgRVqDkWSZiBlhR5w4
zUg0PKSWpWVfBHQ+hFU+fbap5qHogLSFc7zAsXby9sR+MnKxjyM2Ix4BDUA23Bsd
HbjYGK78OIpo3zXdSJGG+AMn7J4YTdEZbeZbE0SZiWwR4Yc1/YWNriN73zHGgc4F
5CYlq/ZbitA4MhX9aXxH2Ju7h1oR097NEfUdwAfXEQ9iVutYXsCSXymK0q6l5kVa
HIqvPxe/QoHVrwB1Qtbs
=YrUw
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
