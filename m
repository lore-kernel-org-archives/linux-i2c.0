From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: [PATCH -next reresend] i2c: designware-pcidrv depends on PCI
Date: Wed, 13 Apr 2011 08:38:55 +1000
Message-ID: <20110413083855.c37ddadc.sfr@canb.auug.org.au>
References: <20110408083215.6b3b0bfe.randy.dunlap@oracle.com>
	<BANLkTikX_rG+6Eg4owary1YRGRG8NzyrGQ@mail.gmail.com>
	<20110412114722.0f2e67d6@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__13_Apr_2011_08_38_55_+1000_nTU98=yaV8/OtFn="
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110412114722.0f2e67d6-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--Signature=_Wed__13_Apr_2011_08_38_55_+1000_nTU98=yaV8/OtFn=
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean, Ben,

On Tue, 12 Apr 2011 11:47:22 +0200 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>
> On Sat, 9 Apr 2011 13:34:49 +0200, Geert Uytterhoeven wrote:
> > On Fri, Apr 8, 2011 at 17:32, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wr=
ote:
> > > From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> > >
> > > i2c-designware-pcidrv is a PCI driver and should depend on PCI.
> > > Fixes these build errors:
> > >
> > > drivers/i2c/busses/i2c-designware-pcidrv.c:256: error: implicit decla=
ration of function 'pci_request_region'
> > > drivers/i2c/busses/i2c-designware-pcidrv.c:338: error: implicit decla=
ration of function 'pci_release_region'
> > >
> > > Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> > > Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > > ---
> > > =C2=A0drivers/i2c/busses/Kconfig | =C2=A0 =C2=A01 +
> > > =C2=A01 file changed, 1 insertion(+)
> > >
> > > Does anybody merge i2c patches???
> >=20
> > Yes please, it's been there since Mar 17, reported several times, and p=
robably
> > masking other build failures.
>=20
> This bug only exists in linux-next, as the code in question wasn't
> merged in Linus's tree yet. It is drawn into linux-next from Ben
> Dooks's next-i2c branch:
>   http://git.fluff.org/gitweb?p=3Dbjdooks/linux.git;a=3Dshortlog;h=3Drefs=
/heads/next-i2c
>=20
> This is where it has to be fixed, so only Ben can do it. Ben, please?
>=20
> Meanwhile, it should be possible to apply a hot fix to linux-next
> directly, Stephen does it pretty often. Stephen, could you please apply
> this fix temporarily until Ben wakes up and applies it to his tree?

I will apply this patch as a merge fixup from today (if it is still
needed).  I also have a patch being applied to that tree to add an
include of linux/delay.h to drivers/i2c/busses/i2c-designware-core.c .

Ben?
--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__13_Apr_2011_08_38_55_+1000_nTU98=yaV8/OtFn=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNpNR/AAoJEDMEi1NhKgbskRAH/js0mYL+s/7V4wSHpECSeLvw
rO82Vhso4vLnBVgqGRswXjcA5ZOTvogSMum8MEbw7Nsnwai5r+K8xR6G2b+ADH72
x0PIWTHUoPLRw0/Mg9/sorHjLZ2aWn6Ve1q1V3BaEQ5RpdqKNViEe/z2IjrjcnOc
PJZZUtutUMZTkDRY4Sk5wNDr9+U0aBPDzuJBHL8/DTzrFsuI+eLNtsrP7nZme2FV
MfOMc0rQRTB/BqR0wCbpLSzL5ETwneNJBQz1bGzSLcF0+CFuJY5pb1MfiSqerSFQ
zVYEIQ0NuAEKqamwbW0qlLLZhSjmrZmNakWy22B8ohf7hEjDTPOX9ngRtu0wdDM=
=xutK
-----END PGP SIGNATURE-----

--Signature=_Wed__13_Apr_2011_08_38_55_+1000_nTU98=yaV8/OtFn=--
