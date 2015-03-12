From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC] Revert "i2c: core: Dispose OF IRQ mapping at client
 removal time"
Date: Thu, 12 Mar 2015 10:23:26 +0100
Message-ID: <20150312092326.GA1000@katana>
References: <1426095336-16108-1-git-send-email-kubakici@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426095336-16108-1-git-send-email-kubakici-5tc4TXWwyLM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for the patch

On Wed, Mar 11, 2015 at 06:35:36PM +0100, Jakub Kicinski wrote:
> This reverts commit e4df3a0b6228
> ("i2c: core: Dispose OF IRQ mapping at client removal time")
>=20
> Calling irq_dispose_mapping() will destroy the mapping and
> disassociate the IRQ from the IRQ chip to which it belongs.
> There should be no real need to dispose of the mapping in
> the first place.
>=20
> Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>

There was another issue with this patch so I was going to revert it
today anyhow. However, you were first, so I'll take your patch, adapt
the commit message and send it out for -rc4.

Thanks,

   Wolfram


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAVsOAAoJEBQN5MwUoCm26vMQAIMRLtQ4gEBz8ULjRdSl7kPI
U7lascXUvxZBn3M0Lzn6fFLJeVmH09q2blijqWimkj8tRUMZqlHSphtMrgu/hfzD
59OQD5AOCuQzEXlFIqc/Rm5IqPAlOAZNPhz7c2DXIo4OkwPUeteRgReBGktCrPqh
K31OC+2LyRzY9beThq3JyouVrkJaOwM3PIS6OAR1b1vXouBS76QeSFKGHY+e3oj4
a+HWqETsrmgb7/jh+T8oVuUrMRubkfE1fgJ1y+ely9/uOOiPVJ6OIhC8H5qEz5bv
vXBzpB+DGxLBL4ZSMp0zMiGQN5er/7FY5W+MOoGyYTUE98NEgbCd8otJxkbmUrc/
psSEQUiY3rl0r+1pFhx6ItFofyDSt1B1gaQ4vJKIZtSUKbRlPmBLTzr/A+3YUFpV
HyuU7XT3uKewct7pEYhqXhZ72oioStW1xEQfdjrUpIOckFW+HIEKjglPFMzpPWSd
xsg852T2wfvaWTePlBKwjB3ZUW2G+T4IRa5radOVOy2EurWnDnC6id5P0hMOF50+
3XL4x1PJsKsOiiD00bdha5om3TSURNlM2St1sG8cTTLEDMgzsQkX/usmxsAjusGP
PoBY+hQXQL1MC3r6aQbdWBYIBo1lNDaXk0wK6+9YnSuUssJfcai/N12RidmiJFpE
gUS0l9JOU21JKvot86DH
=cjpM
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
