From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
Date: Sat, 14 Mar 2015 12:14:51 +0100
Message-ID: <20150314111450.GC970@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424880126-15047-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 05:01:51PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>=20
> Here is the second version of the patch series to describe i2c adapter qu=
irks
> in a generic way. For the motivation, please read description of patch 1.=
 This
> is still RFC because I would like to do some more tests on my own, but I =
need
> to write a tool for that. However, I'd really like to have the driver aut=
hors
> to have a look already. Actual testing is very much appreciated. Thanks t=
o the
> Mediatek guys for rebasing their new driver to this framework. That helps=
, too!

Thanks for all the testing. Merged this branch now into for-next!


--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBBgqAAoJEBQN5MwUoCm2fQAQAI1w0/RXIcR5OoBFBLw5DkCr
vA2Ou1OG9x9M2FP29hco4AzXRaRRHqe9hFRl31Adm0YoQF41/nf+7z4g1VveN4hD
P+ocEWMvzHnafbwGO0+QIYY4nhBVN+/a8eg+j4+AbKdQBLL2+b0I9uwpL1uwdiCY
ceRhoMrrg1oHcFUNKErXyuzA/t0dNq5ekx3z8iqpjjXjp3JRVmfpeueCzD6Gv0zg
HkXAC+U9Ur2gLvBpSRhadn9/Cy6cvOeuIF8Jq2wMOKDUM54Z1HwttT7dTiW8IGXo
xgXFaimc4StYeR1JQEyGLYUATfhXlOKPFOXrUktTwWLlGbgjKUqB3KKGDzR9XXB+
NvtWekSj9+h/c0hHYOiezMV21AIzr7n3c3cmAoK9XYMRz/NeTseC1jG4EgSVCQr1
Vl+QgAgOiOcSNJ3BPfLStNM0kAyPov0UB41EP25fWq3eOJMWUzUEvlLkJMadmPbL
ucvuLhMUvI1jp8EdTEiBltQuukM4tlHgp/tQrK245vO1s0NHnbOdgy68Lab7RfFp
KxbBwIQ1DOhMin80xOC9AUkkYbBppbqhCUc79Fpufx5FYSd+tS3dTLAdwOErmmSh
7YbWXMOdscAUD3+vuDYTWn4gPJGDtzM4MaYn2AAbGVchPa6UR/W1UZDKlpTDLcV/
wvo+3WNDb7KyV+YGySP4
=KnPk
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
