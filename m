From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c-pxa: prepare clock before use
Date: Tue, 18 Jun 2013 18:12:49 +0200
Message-ID: <20130618161249.GE7718@katana>
References: <20130617153036.67CC84375@dev.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130617153036.67CC84375-2+9YHz4BXxlLDiiyqF6/jw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2013 at 11:30:36AM -0400, Daniel Drake wrote:
> On OLPC XO-1.75 (MMP2), a WARN_ON() was occurring during boot
> since the clock being enabled by i2c-pxa had not been prepared.
>=20
> Use clk_prepare_enable() to ensure that the prepare operation
> has taken place, and use clk_disable_unprepare() in the matching
> shutdown paths.
>=20
> Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwIcAAAoJEBQN5MwUoCm24W8P/A61wfP4p+JXh9ihN9tu2k0T
KcsjaVTxtFOo8tYmHKkx3AW3xJFgbuevEKnBlKRe+R01UJMGfQloLnzX3Hb3jE84
6vPjTSx91Pet4njPP8IrkLaHbysXmQvHAtgnLI0DV+5ETlRXerw5cHBdigYdv+oE
a5YCqBfTGq8HQzoHSpZfbMjmAMj1mjrelAD/qw7ZAuPUIKmLZlnRR5UNkXzBFKOe
x9Vsz/BLtmGAlvRQ2niXj16xkCFz0thBpEdJQbT78lEvYFyZq8K+eRf5Si4XIyPI
bfnJtPdF7xgnQvxUZcyFYtPFp42H/hJB0omhnF3PVnlmdxHOzoI/z7ZUpVGWBY3x
Ebc17qee+4H46XEZ3LNVtQ90D5eDTRvK6SzIAgdK2NghBdYXVAtNOwCWtLolocb3
q0zeG9SC2kdpuULrowUq88ilqxIP+0nQitU3MpJlO/mW9q1Xrgc7woSk7EZXXctD
kubHtSix+IWFb0Z5WMh5gl90IEbningkozLhatIZUZhqxnkw8E20DrpME88YAj3d
37/7v3wjOSlRCltlyXct7LWhE1JihQfgxCK5rruCdtW7h1+tDD4p/Z3PWZ+kHdAh
B3FAHWdH4aaXn/6Zc3RtHLuOJyAjDvA90CVIowrtN0pTJ1+seWvgvnXsTfhzKIlJ
+eOHIAdGZQe9svfMnWKz
=Yz0S
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
