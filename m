From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-designware: increase timeout of semaphore transfer
Date: Wed, 22 Mar 2017 09:48:19 +0100
Message-ID: <20170322084819.6dblcq6s3itn5s3q@ninjato>
References: <20170320133730.23041-1-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dzytrrvso43qwvrw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34066 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933620AbdCVI4k (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 22 Mar 2017 04:56:40 -0400
Content-Disposition: inline
In-Reply-To: <20170320133730.23041-1-oneukum@suse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, hdegoede@redhat.com


--dzytrrvso43qwvrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 02:37:30PM +0100, Oliver Neukum wrote:
> Our testing shows the semaphore failing to be transferred on CherryTrail
> in about 0.5% of all cases. The existing timeout needs to be lengthened
> to accomodate the worst cases.
>=20
> V2: Rebased on https://cgit.freedesktop.org/drm-intel/commit/?h=3Dtopic/d=
esignware-baytrail
>=20
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Fixed this checkpatch issue:

WARNING: 'accomodate' may be misspelled - perhaps 'accommodate'?

and applied to for-next, thanks!


--dzytrrvso43qwvrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljSOlMACgkQFA3kzBSg
KbbfJhAAgFfLLxMgzyWuGkX+Ui8eM1eIX4x4bw7IpPlnxvqTbUKZ7XmxCJiqy9iX
n6Itvde/TZ8RFS/HxDN6EPNEpVYmqwg/mtT3gu3Oy30hADcXLyJvpsteU84QpxPz
rMzRCgzmiQKjOvPlNollUb1v0wzt5wTG3kxBxG/iwZHzQ5t/DErofd4lYF0jegTb
CCs5k2Nw5OqiGc9n6FUbzLphjAvobH7Mg1pexTYQdfaYlnS4QFXmr0HKE6WI9Kx/
NOySeqmmGvLm5B2KfVovB8bl6WVN7YvJQeqsbYCip3rhpgv9m8ialWixpvLyMjkh
vUA3H8Pp0z6sFjrQPT/9Xc58fYBLXrnf4KYo+affUjOQvxUJs9vNCHWrbW1ZH5qn
PH59zic/GHY366A50dcXLQzLHGrlDo87j0XtJtMBY+avmC13ZQHKxfcmrnRupRWX
dqH/Nea73E30eUYgspVmG3FGhLFdb7vSXfGMM3k4Dg4NZTUksN2FFWYbe98+SUw2
Rk1F9pwaEtz1FbaqjDQzmc893ojO00zVC93cjka+jX5BRWpBOpIpeF/PWCZw9eaY
1JWtHj8FOzZiVsiQx7BaeTjhX4kY6AIEWXpGDajoA8iSsI2NbTjtvj5otYeIA0P/
pCeqDc+sx84KlusZY+FsSNaDtvi2OyaarhWf+aX0/FlBeyY8Xpw=
=6444
-----END PGP SIGNATURE-----

--dzytrrvso43qwvrw--
