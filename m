From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6] eeprom: at24: Add OF device ID table
Date: Tue, 17 Oct 2017 23:47:32 +0200
Message-ID: <20171017214732.f3iaw2mgue2kfbf6@ninjato>
References: <20171001104948.21663-1-javierm@redhat.com>
 <20171017214040.kak3kpvh6tunjjfp@ninjato>
 <CABGGiswNP=PrwpuqSH-Lqz6tBzrNUpZYCEzFHOPmZSWqsn3zaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zxu6mycnmrp56kxs"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54684 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753138AbdJQVre (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Oct 2017 17:47:34 -0400
Content-Disposition: inline
In-Reply-To: <CABGGiswNP=PrwpuqSH-Lqz6tBzrNUpZYCEzFHOPmZSWqsn3zaA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>


--zxu6mycnmrp56kxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 04:43:14PM -0500, Rob Herring wrote:
> On Tue, Oct 17, 2017 at 4:40 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > Hi,
> >
> >> +     {
> >> +             .compatible =3D "atmel,spd",
> >> +             .data =3D (void *)AT24_DEVICE_MAGIC(2048 / 8,
> >> +                             AT24_FLAG_READONLY | AT24_FLAG_IRUGO)
> >> +     },
> >
> > checkpatch reported this one as un-documented. And come to think of it,
> > since this is solely for EEPROMs on RAM modules, I think we can drop a
> > DT binding for it. Could you agree? I can do it locally, no need to
> > resend. I'll do HW testing later, but wanted to check on your opinion
> > already.
>=20
> It is used by arch/powerpc/boot/dts/mpc8349emitx.dts.

Thanks!


--zxu6mycnmrp56kxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmenQACgkQFA3kzBSg
KbZb5Q/+MSvlXzLoUS3cWZr97ExVZG48CKqtK/+MWhcEaf9/DvFE8gF+pA62xdvs
D9Ua0PHqGzkoyB0P7YN5hMi9pEzO8HnWC6yUALcMoQO8H8UQpcC2WtZAbqwQLjC3
+TUwabY85MQwsqOrhjrrLPDO3ufPwfPB5ikTubkGrHeH+XtixOKGpZwr9JDQ6OEr
y5frh32DiqRAGZpJ9s0Kd5hCLtuORqywbTR1tE4zzK++mEfCTsjuXTsH0pCfm7jY
zbqBlmulddjs7VmdcS8noGv0lGArYFSSQAQ+vYDQplpzjm7ViATuPvMfHnYcABiO
3ySfUxbwJCwtK9ohpZeXwoff3HzJSO837ncOgvGmWaKPYXl2S7LLh/w5fEdG9w6l
d7UHwmPshua2Q8/DJB6/jSX0SkUyA+5vALN6bSVnCSiIrdZLy7RzWdi2oJ+q49l+
yR9qYqlN3mpZxWJfXUn/iaNH2t/sURxZltRombLFlzpNCCubTO5ohG0ubTa8eX6t
l3aWK86Frm85Tm7GttCz04SFChMSQl08qKMd8JU/nAybYfjGhXGVPj8BPShz7Pix
HLk6dkXZGTQ74W8oHliGer0FHwfQCbsiwqDLn7QUl8zTqII/1wrG/NT9AgS/fBja
EctOuSrOXxReqVBcUygTQjD9xM3w6dZJwQYXzCtEKg3L2b3g8yM=
=Dmgo
-----END PGP SIGNATURE-----

--zxu6mycnmrp56kxs--
