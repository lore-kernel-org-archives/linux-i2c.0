From: Rolf Eike Beer <eb-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V2 0/9] I2C ACPI operation region handler support
Date: Fri, 23 May 2014 08:55:55 +0200
Message-ID: <1481506.mZgg6LykyH@devpool02>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <4867018.HWMf8AlFN3@devpool02> <537E143F.7060701@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1922782.EugPuHskmN"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <537E143F.7060701-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--nextPart1922782.EugPuHskmN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Lan Tianyu wrote:
> On 05/20/2014 10:17 PM, Rolf Eike Beer wrote:

> > It may be that I have taken the wrong ACPI files. This is the resul=
t of a
> > fresh run of acpidump, together with the most recent dmesg.log, jus=
t in
> > case I messed it up.
>=20
> =09I have check the log. I2C ACPI operation region targets to I2C con=
troller
> which has one ACPI node in the ACPI table and is associated with one =
I2C
> adapter. Graphic with one ACPI handle registers several I2C adapters.=
 This
> causes attach data to the ACPI handle with the same handler several t=
ime.
> The ACPICA function will return ALREADY EXIST error code and causes t=
he log
> you mentioned. There is no I2C ACPI operation region under graphic de=
vice
> node and so not break function. To avoid these noise logs, I make the=
m only
> appear under dynamic debug mode in the my V3 patchset.

Hi,

thanks for the clarification.

Greetings,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Bertha-von-Suttner-Str. 9, 37085 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source

--nextPart1922782.EugPuHskmN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAAECAAYFAlN+8QAACgkQq+RR+17trfxx1wP8DoKWvPE+OkJHU9GNtZGvMc5O
QB+oE0ze1TOja0pudZ0Dm1uQsu7tYwriyTf7mmeaVRs7dq4bhN9xKdbJgacKaLdd
DlvaCU5dtvwpPEiAMdRvce+vDdeymXIMmwN5duuxg/q/bUFkUTjS3RFzTjBj8du1
IiQakdk/fHAToXf8gMo=
=xs/A
-----END PGP SIGNATURE-----

--nextPart1922782.EugPuHskmN--
