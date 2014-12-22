From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC] i2c: designware: Avoid initcall and initialize the driver
 like a regular one
Date: Mon, 22 Dec 2014 20:02:33 +0100
Message-ID: <20141222190233.GA1014@katana>
References: <1419272149-28716-1-git-send-email-walter@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419272149-28716-1-git-send-email-walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2014 at 03:15:49PM -0300, Walter Lozano wrote:
> Currently, the driver is relying on a subsys_initcall() to register
> the platform driver struct. This is typically done to allow early uses
> of the I2C bus (for instance, I2C regulators used from early machine code=
).
>=20
> While this might work on some cases, it breaks on others. For instance,
> I2C devices with GPIO-wired interrupts will fail to request the
> interrupt because of this initcall usage.
>=20
> This commits attempts to fix the above issue, by converting the I2C
> driver into a regular kernel platform driver. This guarantees it will
> probe after GPIOs drivers.
>=20
> Platforms based on devicetree won't be affected by this change.

Huh, why is that?

> Legacy platforms, relying on the I2C being available early, might need
> to implement proper defered mechanisms to overcome potential problems.

NAK. We can't say "Let's cause a regression to force people to fix
things that used to work" IMO. You exactly pointed out the problem that usi=
ng
subsys_initcall() creates.

What about fixing the drivers you use to support deferred probing when
acquitin the irq?

Regards,

   Wolfram

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmGrJAAoJEBQN5MwUoCm2dSQQAJ9fQhqOe5KBj5bau/KFlRkV
zGMtMaD0A6VmytpDWzwNoZu0qoTtu5/E1IVnb/otKQaIJssUOfOTsQpulZeP7xBs
3kpLPI6AqLt/y10a6VwdUN4eQlrgMquzsgkCRHsYghInKSYJmV22bTgfcV0CK+ty
QhNmFlOXGz841DsOp3rfj5thMO6BZcURi98HpNMRtUqooqrGcgrUbaDVWmm3oTsi
gv3Nn8PGVLRRoBkp6q0h4HMJXiHGvATWnKJoDTIKt/YEoRwNToZ/vRsfHGvpestn
jdJj9pNHopzC5lPDmQbJ+k6qnnPKZ2YN5Ji5IzRXjTZEkmUbx3IrMtJX1B9v5XgI
SOQBSfSHBO1kWEUPDm5IdZpzYXeNp0X3ydUw2xOF2n5rrTG4SUj/PJreJC768fQA
NDfFdYQudzcJ5ElOL4CwvEHfrOZ4PkZFnkSnCDzPu8rxZ+wuKiNwGRGNpxDecbBR
Q1ChZ+ej0scmrifw8CUewPX6nQvmViv2rqZQsELo744nin6nxMufBMQ4epkwDwYT
hggQS7gSyEXYtAZ9SaCtNQK2YgPnsY/rC9TyFwcG/EQ2jo5z45qKbPXAY0Wp3/VO
TB+8akfhTuMI7WJ/dyayMSyXW6gYnW7X42eyBEty1Hu01ojBEPVkntgSdcn1Sn/e
X0mlG5xvF8t+e135BJBF
=i8Ng
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
