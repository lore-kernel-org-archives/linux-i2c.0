From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/6] I2C: sis630: add sis964 support
Date: Mon, 28 Jan 2013 22:21:04 +0100
Message-ID: <1359408070-31832-1-git-send-email-amaury.decreme@gmail.com>
References: <20130124083043.57f91a3d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130124083043.57f91a3d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Those patches add sis964 support to i2c-sis630.

The SiS datasheets have been used.

The SiS964 isn't part of the SIS96X family and behaves like the SiS630
chip family.

=46or I2C, this array show the differences between a SiS630 and a SiS96=
4.
 +------------------------+--------------------+-------------------+
 |                        |     SIS630/730     |      SIS964       |
 +------------------------+--------------------+-------------------+
 | Clock                  | 14kHz/56kHz        | 55.56kHz/27.78kHz |
 | SMBus registers offset | 0x80               | 0xE0              |
 | SMB_CNT                | Bit 1 =3D Slave Busy | Bit 1 =3D Bus probe =
|
 |         (not used yet) | Bit 3 is reserved  | Bit 3 =3D Last byte |
 | SMB_PCOUNT             | Offset + 0x06      | Offset + 0x14     |
 | SMB_COUNT              | 4:0 bits           | 5:0 bits          |
 +------------------------+--------------------+-------------------+

Other differences don't affect the functions provided by the original d=
river.

Changes v2 -> v3:
  Added a missing BYTE_DONE_STS in cosmetics patch
  Unsigned hex patch corrected
  Checkpatch patch improved

Amaury Decr=C3=AAme (6):
  Add SIS964 bus support to i2c-sis630.
  Bugfix: clear sticky bits
  Bugfix: behavior after collision
  Cosmetics: hex to constants for SMBus commands
  Misc: display unsigned hex
  Cleanup

 Documentation/i2c/busses/i2c-sis630 |   9 +
 drivers/i2c/busses/Kconfig          |   4 +-
 drivers/i2c/busses/i2c-sis630.c     | 356 ++++++++++++++++++++--------=
--------
 3 files changed, 209 insertions(+), 160 deletions(-)

--=20
1.7.12.4
