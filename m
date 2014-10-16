From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] drivers/misc/eeprom/men_eeprod: Introduce MEN Board
 Information EEPROM driver
Date: Thu, 16 Oct 2014 11:48:04 +0200
Message-ID: <20141016094804.GB1273@katana>
References: <cover.1413416105.git.andreas.werner@men.de>
 <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner@men.de>
 <20141016085835.GA1273@katana>
 <20141016093414.GA25214@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141016093414.GA25214-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Andreas Werner <andreas.werner-csrFAY9JiS4@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johannes.thumshirn-csrFAY9JiS4@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2014 at 11:34:14AM +0200, Greg KH wrote:
> On Thu, Oct 16, 2014 at 10:58:35AM +0200, Wolfram Sang wrote:
> > > +struct eeprom_data {
> > > +	uint8_t eeprod_id;
> > > +
> > > +	uint8_t revision[3];
> > > +	uint32_t serialnr;
> > > +	uint8_t board_model;
> > > +	char hw_name[6];
> > > +
> > > +	uint8_t reserved;
> > > +
> > > +	__be16 prod_date;
> > > +	__be16 rep_date;
> > > +
> > > +	uint8_t reserved2[4];
> > > +};
> >=20
> > And what if the compiler reorders?
>=20
> It's not allowed to reorder, but it can add padding wherever it wants
> to, which if this is a on-device structure, can cause problems.  Use
> __packed to prevent that.

Yes, took the wrong word, sorry, I meant __packed.


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUP5RUAAoJEBQN5MwUoCm2MZUP+QGAz+WpLi+FF45FIonW1/SB
3dhP8GOLhKjHo0NoxvSeqELwP2TgpRxWG9JuVODxYA8owXTH4ijJYBEFKi5VYdhT
FaSLF0eUwzTC60yWNk4VD0o/05kI5ccj0pjgDZVGoiKZL9CDXu4HdRf2lLJn/It6
DhRqZiR9EItkJ1abf9WqjQ38gaeXcProoWCFc5o9+jIhzE6R9oK5/q39fhDwg6I8
WwBd42xpQFdUod5mxj0fXe9v2nYMCRe1OmoYUsVmG9xRu9ws2wG8lOc9H6uRGjQr
20O/KYOzvKfm3iR+UnOQcEXZ4sHrXRd4tHGyFriuZTdf41BmUyOR5pIUJquHI7Eh
YVnE+ZIbwrUWlyzZzvq6aJvK/rQGxXftRA/et3Ml5K0rW7tCv7MM78VATF221Gr5
ZXeoPkPWfyO4PNU4sXM3KWUZzr31GcLcxKNwSZMHRF1lAk03hT/hgqlzwR2I6F/g
qENGPrSLvk84WKbWJJrjf4WNclt+lLDoRog2cu4Uw41SVx3kyGz7/gpphsCJ32Yb
dAxHZU32/WgYG8wZ4I3jolarNKVMamlenfxPpPePA1bWRKdYSlDvcmOJxDF/t2MX
DNHHn8A3eYWmyXUqsVIRVm0AcD0YV/elWuGwCbwUlpRJAItRad0Af94HiafzZgR1
8uj2qlqx0xrs62ZtEodQ
=KeL/
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
