From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/6] I2C: sis630: add sis964 support
Date: Fri,  4 Jan 2013 14:13:29 +0100
Message-ID: <1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346204115-30293-1-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
=20
 Other differences don't affect the functions provided by the original =
driver.


Amaury Decr=C3=AAme (6):
  Add SIS964 bus support to i2c-sis630.
  Bugfix: clear sticky bits
  Bugfix: behavior after collision
  Cosmetics: hex to constants for SMBus commands
  Misc: display unsigned hex
  Cleanup

 Documentation/i2c/busses/i2c-sis630 |    9 +
 drivers/i2c/busses/Kconfig          |    4 +-
 drivers/i2c/busses/i2c-sis630.c     |  340 +++++++++++++++++++--------=
--------
 3 files changed, 196 insertions(+), 157 deletions(-)

--=20
1.7.8.6
