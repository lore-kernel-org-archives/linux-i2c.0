From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme@gmail.com>
Subject: [PATCH 0/2] I2C: SIS630: Add SIS964 support
Date: Mon,  6 Aug 2012 00:11:52 +0200
Message-ID: <1344204714-16513-1-git-send-email-amaury.decreme@gmail.com>
References: <20120805140454.3e7a9606@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20120805140454.3e7a9606@endymion.delvare>
Sender: linux-doc-owner@vger.kernel.org
To: khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, rob@landley.net
Cc: amalysh@web.de, mhoffman@lightlink.com, ralf@linux-mips.org, manuel.lauss@googlemail.com, axel.lin@gmail.com, olof@lixom.net, rusty@rustcorp.com.au, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme@gmail.com>
List-Id: linux-i2c@vger.kernel.org

This series of patches add SIS964 support to i2c-sis630.

The SIS964 is very similar to SIS630 for the SMBus.
	+------------------------+--------------------+-------------------+
	|                        |     SIS630/730     |      SIS964       |
	+------------------------+--------------------+-------------------+
	| Clock                  | 14kHz/56kHz        | 55.56kHz/27.78kHz |
	| SMBus registers offset | 0x80               | 0xE0              |
	| SMB_CNT                | Bit 1 =3D Slave Busy | Bit 1 =3D Bus probe =
|
	| SMB_COUNT              | 4:0 bits           | 5:0 bits          |
	+------------------------+--------------------+-------------------+

The other differences doesn't affect the functions provided by the orig=
inal
driver.

The SIS964 name is ambiguous as this chip isn't part of the SIS96X fami=
ly and
behaves differently.

Done with SiS 630 and 964 datasheets.

Amaury Decr=C3=AAme (2):
  I2C: SIS630: Add SiS964 support
  I2C: SIS630: Cosmetics

 Documentation/i2c/busses/i2c-sis630 |   17 +-
 drivers/i2c/busses/Kconfig          |    4 +-
 drivers/i2c/busses/i2c-sis630.c     |  445 +++++++++++++++++++++------=
--------
 3 files changed, 278 insertions(+), 188 deletions(-)

--=20
1.7.8.6

