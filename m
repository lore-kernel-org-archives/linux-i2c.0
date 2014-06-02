From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: designware: Fixes for Asus T100 and Haswell PCI
 IDs
Date: Mon, 2 Jun 2014 18:16:23 +0200
Message-ID: <20140602161623.GH2654@katana>
References: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400164644-3222-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Yao Jin <yao.jin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aubrey Li <aubrey.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2014 at 05:37:20PM +0300, Mika Westerberg wrote:
> Hi,
>=20
> Patches 1-3 are needed in order to get runtime PM working properly on Int=
el
> Baytrail based tablets, like on Asus T100. We need to re-initialize the
> controller on resume.
>=20
> Patch 4 adds Haswell PCI IDs to the driver. It is independent of the
> preceding patches but I decided to include it here as well. Haswell based
> chromebooks need this.
>=20
> Mika Westerberg (4):
>   i2c: designware: No need to disable already disabled controller
>   i2c: designware: Disable device on system suspend
>   i2c: designware: Add runtime PM hooks
>   i2c: designware-pci: Add Haswell PCI IDs
>=20
>  drivers/i2c/busses/i2c-designware-core.c    |  4 ++++
>  drivers/i2c/busses/i2c-designware-pcidrv.c  | 22 ++++++++++++++++++++++

Patches 2-4 applied to for-next, thanks! Patch 1 leaves a question to
me.


--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjKNXAAoJEBQN5MwUoCm2kDoP/22Ogi7vGBZPAPmChQUTS2Nu
k59LAyjLaJpMZ+QkD04DEvN8CKAiWHrEpE07vzUHHH1aezk/2vHBu0oWPA4zaS4D
9fq7GEoIZpDleBu85im2R88b9l4x6cyghH79MkyU7Y9gxilBcbCSuOLOeMkbME9W
dT86/ILv3y9hA8Z2eMldl4Z1Jb1N396wTIRFcPMZ0IuO4cEgh0fr4bVPtGC5l+AB
vNQ0Z8xuimhWLLM7R1A+5JIAs8dS7MCqX92B+I/AXKngBxhwPTTkJjcD1ULqbX8K
i3dAxNgYRIc9iMGWy+E2IPZq932i9TcfdEzc9hcLcns0lgkGrKe+80NP4HOOIQpY
pYNnINXOZ8HVabiG1mnkrQjR+IjLSeiY2/O9qozqtU8GMZlwMqBgT8U6hX1RtHej
R8Bc51BBzqJm6fOo8Xy7Qf2sbcZEyVr5alkj2dX6RUKopzHz1zNg/lRWfgINJ1MQ
koXbcg/glr2SEcn/tZAp6TIYaqYSLsZPRt53ezDYNJsMd82pOYqVaeKArOq2Dkbc
ZMSOIoCP6aRG5DZ1GlHdE+aQCHjVeW7VWCQczNqwi75bDHStj7sj7QjXxk/zYWmP
na/zaZXcxHWyxOH4EEo/1QeRljYectfRxskohf7DBTR1VfFGJJCNu/ySGwPOMCnm
eQu6ypajm2pp09F+7eXE
=KFJo
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
