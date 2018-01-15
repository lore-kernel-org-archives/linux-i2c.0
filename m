From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Documentation: i2c: drop unnecessary .owner field in
 examples
Date: Mon, 15 Jan 2018 21:28:47 +0100
Message-ID: <20180115202847.77s42fgc2zsdnc6s@ninjato>
References: <1516018126-16119-1-git-send-email-hofrat@osadl.org>
 <CAHp75VeamZDS=-bwGYn41y0pwKEptRE02W3bRe326Q34i68=yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xd2pgsnk47seodj7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeamZDS=-bwGYn41y0pwKEptRE02W3bRe326Q34i68=yg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Jonathan Corbet <corbet@lwn.net>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicholas Mc Guire <hofrat@osadl.at>
List-Id: linux-i2c@vger.kernel.org


--xd2pgsnk47seodj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 10:24:52PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 15, 2018 at 2:08 PM, Nicholas Mc Guire <hofrat@osadl.org> wro=
te:
> > From: Nicholas Mc Guire <hofrat@osadl.at>
> >
> >  Currently there are a few drivers that still set the .owner
> >  in the i2c_driver structure - all of which are reported by
> >  coccinelle (scripts/coccinelle/api/platform_no_drv_owner.cocci)
> >  and there are no cases that set the .onwer and do not call any
> >  of the functions that set the .owner field anyway in any of the
> >  drivers (checked by a modified coccinelle script based on the
> >  above) so it seems that the examples are no longer valid and
> >  .owner =3D THIS_MODULE, can be removed here.
> >
> >  While at it an obvious typo (new new) was also fixed.
>=20
> AFAIU It is right only in case when someone does this, e.g.
> module_i2c_driver() macro. Otherwise the field is pretty valid and
> must be filled.

It gets filled with i2c_add_driver. module_i2c_driver uses
i2c_add_driver. I was about to suggest to keep the field in the old
driver and describe that it can be removed when using one of
i2c_add_driver or module_i2c_driver.

But then I realised that the kernel tree does not have any such old
drivers anymore and I couldn't even find out-of-tree code via some
search engines (I tried looking for "I2C_CLIENT_INSMOD").

I consider this obsolete and irrelevant these days. It might be good to
simply remove it to not confuse users.

Thoughts?


--xd2pgsnk47seodj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpdDv8ACgkQFA3kzBSg
KbbyiRAAmMmUzVGFoiaYtNfS+vDrdxAVaeiLcYkpTDQDwzE7AcuF8k4sTemb5Jy8
AmRWqpfrC7X8U39+PAHC+28Ibp5UxfSpNpbmnR6AbfapMumLzSz3KwhIw1mbsO3m
JxtO1INmgobkkkaA1I+gHmMe1dt6LITtdnFYbXC5PqM8oOnqYzt+fRThWXly83QE
rSXOZUXV3zfrN/twc6YL4b/M0PwVDOi8lGAaF/FWJ2SsdOPDE9XbzaCCzCusDMy2
+1zU0jfV7mwA4g425LJ4OTLVH1OwARal3ao1A+PzGXYAqoqU2IVy8ni+hhUQqaDI
bNpNNkxadf39+hyR7G5VbE5G/t9CIiuFxEvZQAVy5H5QsVJgfkW8nvCAgJT0ZLY/
z/w02a9z6hQw5pqZfQXHmlrexI9eZAGnuLtMP5JwFbAfZD8lA+5H7ntOCiidyBeL
agOt6sh5gJHQCVyG0b1b+kSq4qMKuYP379EzWA0z/AQLHCCHrPVpGq65roicNHlG
usWCaY25DhM6uTcEiViLDWiMqaXwgVJLHTpufRy/cNDAKCjWbkNczWtXMIGWhP/K
cejb12ONfMsv2ASahkTprEtAbMcfoDKYSN+LO5EJBp1xKT99G5riGpkOG1AyJxz9
TDO/LHmafZfOv6IaFGH0VMLddiP9zJCIrSnPzLy7odK5uwzsUn4=
=u9Mj
-----END PGP SIGNATURE-----

--xd2pgsnk47seodj7--
