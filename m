From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: mv64xxx: Remove redundant of_match_ptr
Date: Wed, 2 Oct 2013 00:20:50 +0200
Message-ID: <20131001222049.GC5028@katana>
References: <1380542526-2943-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380542526-2943-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 05:32:06PM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks! I hope you checked if you missed other
occurences, too. My pointing to mv64xxx was an example, not a complete
list.


--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSS0rBAAoJEBQN5MwUoCm2BEcP/jrWGpvfj+s+hddaZ7h2ZXZP
PVtYeb1v5UXZCyCLCTP+5PvIedKTWi+jBwQ1qvaMvBzVFfUBoOW/NDbCjil2FqWt
iBX4TyGvs8msj1StCAWRG66buM6GOtr0ScmmRwQoEn1gclTm50cMAKJ8r6k7vqhw
usGpHCOCPs3VOUl82dWczqLwc3BkDD7LMxuD6datJ6Waoq+cQsjas/rrBmzwrsjn
ObLGB1toC9eWBYWserbxG8aTzK/3UX5c/XS6I7DJ2eZey+skZ0Kr5vzGTSfQzoNy
zhR59zHSoDwpncipQOc8iEG60Jo6thOfnzVBfQ35xltTBbP+6/B4Pv9y9Ie817DC
iS0OFoMrYyQMSKKMpx8wUXMM9BCl2uL03tTtcfLVK9jkCR6LNVJBmvNHWuxCukA6
y/IH40zLWlpccr2dwoE3Ua0/mzmQo8+h7QQc0YKr2JbR4oP6xo9qX2ovizphwwiB
hiE0fxgGVI5E7CfLB6kPUdQqIGLWb7FsNVGudx2pWkbnshXSXv+EUanTeQXit/+W
ih5A4nMFeNb9GpPfYmNcRD9pVkN54ryppRnWdCqH37WKpGOcmF7WrOuK6F+b0BAD
hb8qgpOvcvFHHOXRtZmay+K0MsDWFxbHSgnp6jsd5KKqbKkvlul8PtDSV7SGC5ua
qNSE9FZ5g6ZHcgCJFAcO
=dGw/
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
