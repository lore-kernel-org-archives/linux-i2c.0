From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2 0/9] i2c: xiic: cleanups
Date: Thu, 9 Jul 2015 19:35:01 +0200
Message-ID: <20150709173501.GE4744@katana>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434554299-23443-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 08:48:10PM +0530, Shubhrajyoti Datta wrote:
> This is a series of cleanups for the axi iic.
> tested on zc702 and microblaze.
>=20
> Changes from v1
> Updated the commit message.
> =20
>=20
> Shubhrajyoti Datta (9):
>   i2c: xiic: Remove the disabling of interrupts
>   i2c: xiic: move the xiic_process to thread context
>   i2c: xiic: Do not reset controller before every transfer
>   i2c: xiic: Remove the disabling of interrupts
>   i2c: xiic: Remove busy loop while waiting for bus busy
>   i2c: xiic: Add a debug msg in case of timeout
>   i2c: xiic: Remove the Addressed as slave interrupt
>   i2c: xiic: Service all interrupts in isr
>   i2c: xiic: Do not continue in case of errors in Rx

Commit messages are a lot better, thanks!

Two minor comments. If you agree to them, I can simply drop patch 6 and
fixup patch 2. Then, no need for resending.


--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnrDFAAoJEBQN5MwUoCm21S8P/A2HD4aa56WYQ6wnRpncA3hs
vIRzQz12U2LNKiKzOgi5l06dzKVgaEcBAjQHWdZ2wx3l7aFJe2jlU8P7ZSGssTfe
UCKfQqWlem0ZXGCymnrw90RjJA1uVxcj5jLYZZN8Da1inkWq8Z37t3PtMk2tcKPJ
ERXTZupOtQ4SLvwWDdrc8/UXEtWrG22uAb6XXeMUph+AnpZd/pAPu60JrkDNayVp
gNKqQwQnSe4rghI1SjXLgnKgyrjd7xNG/LkZlDQOMPTbN7QyF3FAB5ssSvXiU1Fi
pKNeocqlDNQyyRoh+dFr1aQVV0FY8l8nZV/2XE89ZTLXYjRffiOtTHsBHwXk6iuG
mUjIzrv4MCrChqqJHi0LXqX8dq8LlyxxFn81MSk9hT2SIkV1THm9mmK2PNdHZK5/
43pDYCAYgjC2C5KtKbx3BUE/7HkjHwG5pqsiekoTS/k1kJ/s3ReBCTi9hxbNexP3
KgF+g6KLTry1sYPDzyjI5ltsk50htagzyFwcFjbcDQGfZSqjOnCyhU32UB3WGVZe
2TZRk7rKMQS2mQGHKmJAYyELADTAfg9lBJP3Vtc9gm5fFWAlghwq+shSBOjdtQG/
NnuGzya1fLrf/CBYmg5OtaXQNB25I2V51Oh2ux5huXHCjR55mkHZW28xc6/4YB9n
NDgCDsm7rEQfJj5WgDmv
=cIv/
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
