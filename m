From: Ulrich Drepper <drepper@redhat.com>
Subject: Re: i2c or eeprom enumeration problem
Date: Mon, 28 Apr 2008 08:27:12 -0700
Message-ID: <4815ECD0.80201@redhat.com>
References: <4815509A.9040802@redhat.com>	<20080428050515.fcc05689.akpm@linux-foundation.org>	<20080428141526.2f4e993f@hyperion.delvare>	<4815DC52.1050908@redhat.com> <20080428162123.7fd8eb04@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935727AbYD1PaB@vger.kernel.org>
In-Reply-To: <20080428162123.7fd8eb04@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jean Delvare wrote:
> OK. Maybe it uses the same trick as the S4882... Can you get the
> information from Tyan?

I don't have a special link to Tyan but I can try.  What information do
you need?


> Please provide the output of i2cdetect for all the SMBus channels.

[Strange, the lm_sensors package in F9 doesn't have i2cdetect anymore.
Anything replacing it?]

I see two busses:

  Installed I2C busses:
    i2c-0       smbus           SMBus nForce2 adapter at a000
    i2c-1       smbus           SMBus nForce2 adapter at a040

Using -a to get all the info on those busses I see this:

Bus 0:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: -- -- -- -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- 18 -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: UU UU UU UU -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


Bus 1:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: -- -- -- -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- 19 -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- 2d -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- 48 49 -- -- -- -- -- --
50: -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --



This motherboard uses the NVidia nForce n4250QE chipset.

- --
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro S=
t =E2=9E=A7 Mountain View, CA =E2=9D=96
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFIFezP2ijCOnn/RHQRAmd2AJ4gAQWzPhjBylM8g0Tzrw4L88xy0ACghI9q
Za0TJOrHDSlMzq8S2DShh4o=3D
=3DaCCS
-----END PGP SIGNATURE-----
