From: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: piix4_smbus: How to deal with conflicting ACPI regions?
Date: Tue, 16 Jul 2013 01:04:13 +0200
Message-ID: <1373929453.12205.1.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-RpbEnjZq1VNwY/cKzDWD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--=-RpbEnjZq1VNwY/cKzDWD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


using coreboot on the ASRock E350M1, the ACPI table contains the
following [1].

        $ more src/mainboard/asrock/e350m1/acpi/smbus.asl
        [=E2=80=A6]
        /* SMBUS Support */
        Mutex (SBX0, 0x00)
        OperationRegion (SMB0, SystemIO, 0xB00, 0x0C)
        	Field (SMB0, ByteAcc, NoLock, Preserve) {
        		HSTS,   8,  /* SMBUS status */
        		SSTS,   8,  /* SMBUS slave status */
        		HCNT,   8,  /* SMBUS control */
        		HCMD,   8,  /* SMBUS host cmd */
        		HADD,   8,  /* SMBUS address */
        		DAT0,   8,  /* SMBUS data0 */
        		DAT1,   8,  /* SMBUS data1 */
        		BLKD,   8,  /* SMBUS block data */
        		SCNT,   8,  /* SMBUS slave control */
        		SCMD,   8,  /* SMBUS shaow cmd */
        		SEVT,   8,  /* SMBUS slave event */
        		SDAT,   8   /* SMBUS slave data */
        }
       =20
        Method (WCLR, 0, NotSerialized) { /* clear SMBUS status register */
        	Store (0x1E, HSTS)
        	Store (0xFA, Local0)
        	While (LAnd (LNotEqual (And (HSTS, 0x1E), Zero), LGreater (Local0,=
 Zero))) {
        		Stall (0x64)
        		Decrement (Local0)
        	}
       =20
        	Return (Local0)
        }

This causes a conflict later with piix4_smbus.

        ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI =
region SMB0 [io 0xb00-0xb0b]

And the log message tells me to use an ACPI driver, if available.

Is there such a driver? I ask, because I was not able to find one. Would
that work with `decode-dimms`?

If the above is not possible, would the workaround be to remove the ACPI
SMBus configuration?


Thanks,

Paul


[1] http://review.coreboot.org/gitweb?p=3Dcoreboot.git;a=3Dblob;f=3Dsrc/mai=
nboard/asrock/e350m1/acpi/e350m1/acpi/smbus.asl;h=3De4ccfe3467c1b49edbf21b1=
1add62872286684ed;hb=3DHEAD

--=-RpbEnjZq1VNwY/cKzDWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlHkf+0ACgkQPX1aK2wOHVhoVgCfWhygw4j7+ctJnix/jutqb41V
/bwAn0tkgFcxfkUSG1r0Nf9189mqBjYR
=tejy
-----END PGP SIGNATURE-----

--=-RpbEnjZq1VNwY/cKzDWD--
