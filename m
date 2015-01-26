From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware-baytrail: use proper Kconfig dependencies
Date: Mon, 26 Jan 2015 19:10:43 +0100
Message-ID: <20150126181043.GC25317@katana>
References: <1422290974-24561-1-git-send-email-wsa@the-dreams.de>
 <20150126180110.GA31916@pathfinder>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150126180110.GA31916@pathfinder>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 10:01:10AM -0800, David E. Box wrote:
> On Mon, Jan 26, 2015 at 05:49:34PM +0100, Wolfram Sang wrote:
> > IOSF_MBI depends on PCI, so we should not select it but depend on it.
> > This ensures also we compile on X86 only, other archs will break because
> > of an arch specific include. Also depend on ACPI since this driver uses
> > it.
> >=20
> > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>=20
> Signed-off-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

You probably mean Acked-by?


--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxoMjAAoJEBQN5MwUoCm2cKoQAJbXYRs1wZjSyWmSZz6eCNKe
nMOYIlxI/8r7mTcrW3L6afogXVBSunw2zMbrX0vlAIIYsQbegKqvn4TRt+PGmi8b
cHT03FH1UyhPZXe62effCZPWx07YktqQ80vMMY0epdNVmS67TgMQxbe+3ND6/ku5
YDhBET6KK2Rx7P9MvCwABjj+fb4Ubf5J1KInyVguJPs9U43X3IkZ1C22aFBFt6T7
2FoS3wCeO54G9KyWWi20TwglTsoGvpYAZ2KDUGippvn1AxEiPj/W+d+LKknALhET
hayvKvZ3ZhxmHZEFEZEXImKW6b86QAHD889A0MtIVVM+IDsBhjqS3WYDleJK0T0N
h1IKzbrl0MOVZ+foRfMHPIZuIXs697DKJZ79keYPcRoqCZ298XHk3Mkm1IS0iD5p
NCzQHvKL7rD19UuKPHNiWc7X1RefY+rL93V0n4e4+eWDcxwLB+Y6iQ3E3EEG8Gbg
b/f3iB9tZabMohbfAu82C7Eee3O9xPB8OE2N93xdzW1/hVYDwRCdTnghOvKLvANJ
rLbGYqMxDqFE9TDrxakMuLhmXBTXOXCFI8PLg9Eg2Ipev/w4l90rvtpM783ZIvJk
amOigAX4UgCd6bkYnjpzdahBNRQiv+rhbzzam0yYlvQwKgBbtl08G8ZlDoVAy5Mg
4lfbPLEUd2JJzfN/Lla1
=pPux
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
