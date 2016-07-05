From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Tue, 5 Jul 2016 13:30:23 +0200
Message-ID: <201607051330.23650@pali>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com> <20160704102212.319cfd8e@endymion> <20160705101455.GM23527@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4005530.jjvsuqtTtb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160705101455.GM23527@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--nextPart4005530.jjvsuqtTtb
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 July 2016 12:14:55 Mika Westerberg wrote:
> The whole point of this patch is that we expect that nobody never
> uses that OpRegion. I'm 99% sure you don't find a single machine
> where it is actually in use.

HP EliteBook 8460p uses it for sure! Here are DSDT snips:


                Method (\_SB.PCI0.LPCB.SMAB, 3, Serialized)
                {
                    If (LEqual (And (Arg0, 0x01), 0x00))
                    {
                        Store (0x01, Local0)
                        Store (\_SB.PCI0.SBUS.SWRB (Arg0, Arg1, Arg2), Loca=
l1)
                        If (Local1)
                        {
                            Store (0x00, Local0)
                        }
                    }
                    Else
                    {
                        Store (\_SB.PCI0.SBUS.SRDB (Arg0, Arg1), Local0)
                    }

                    Return (Local0)
                }

=2E..

                Method (ALRD, 1, Serialized)
                {
                    Store (\_SB.PCI0.LPCB.SMAB (0x33, Arg0, 0x00), Local0)
                    Return (Local0)
                }

                Method (ALWR, 2, Serialized)
                {
                    Store (\_SB.PCI0.LPCB.SMAB (0x32, Arg0, Arg1), Local0)
                    Return (Local0)
                }


And ALRD and ALWR methods are used by hp_accel.ko kernel driver.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4005530.jjvsuqtTtb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAld7mk8ACgkQi/DJPQPkQ1JRwwCgtXmDtn0SoBp/eFT0R/Egrm7q
tKIAoJYmn9RWX0KIYgMtaIaFORlNSLox
=HbfV
-----END PGP SIGNATURE-----

--nextPart4005530.jjvsuqtTtb--
