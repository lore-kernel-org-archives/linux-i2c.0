From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/6] i2c: designware: Rename
	accessor_flags to flags
Date: Sun, 15 Jan 2017 16:18:05 +0100
Message-ID: <20170115151804.GB1739@katana>
References: <20170101201521.12364-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0939942139=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170101201521.12364-1-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============0939942139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 01, 2017 at 09:15:16PM +0100, Hans de Goede wrote:
> Rename accessor_flags to flags, so that we can use the field for
> other flags too. This is a preparation patch for adding cherrytrail
> support to the punit semaphore code.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Takashi Iwai <tiwai@suse.de>

This and the whole series is:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYe5KsAAoJEBQN5MwUoCm2kiwQAJleXtgNc5ZbORfyo7eWQXzc
ggv7pe3bkaQ/Nel51oswFBG5r+WLFVfMJgKD4dyHag0YH+MAI9TLfT4XaUEKTkYa
pWqel6ASrV4tUgVw6TbplvsKeb7lKKk1B4c6luQPmLpfI5HChp/aefWCobrx+KrV
Jy7TUmBPT5qqyQKYxNzRVTnXT9dAj5iVHzAznoOYOTpUogXcYhnwlljFum/zgDu4
5tE5qhYhv1tN7q/xZBPiaZ9fCUZxElpl97WDUtt2cKHRfomClbkwbkQq3DNFhRer
KdhtInxuDj3nYNO+mKRSElLVLJlRFqT3i6ubyxVyQD0SKcO48jmUx0RG7hxfrUKs
CESdT0kp1lAjfXf7lphaMiODStaAlvDKBFhaisjI/+CbQoutUsyQa4M66wA58pjI
alBLG7vOjmFqXkWOzsraweUawTb/ac7KLuMgX0vywF3KDPx3OSnP5pWlKAjJgzzS
IQSHSles8pxkHVQtJFurEbFaYg81j2lNQhy1c9JywT6BN+OLomw5LwHbWh8WsG35
2S0BtmjaLh8mss83SRZzwp9UQxEodkDx1fIhhUYk3nrJYFkJcN0D21J9iYuDBh9T
cCguWldoStszECJMAFmFaqScxE24/nIkoaXmZWCxBrKc/RXU8ijstVM07hW4urSk
HFTpiaA6OTZRK0XVpg8F
=gymf
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

--===============0939942139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0939942139==--
