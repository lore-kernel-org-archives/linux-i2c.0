From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Fri, 27 Mar 2015 14:01:08 +0100
Message-ID: <20150327130108.GA19151@katana>
References: <20150216120951.GA2840@katana>
 <20150317042049.GA6765@roeck-us.net>
 <20150318132707.GD3580@katana>
 <550A4162.8000009@roeck-us.net>
 <20150319081612.GA900@katana>
 <20150319174314.GA17329@roeck-us.net>
 <20150319213937.GA899@katana>
 <5512C213.7030705@roeck-us.net>
 <20150327080947.GA900@katana>
 <5515523F.9010609@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5515523F.9010609@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 27, 2015 at 05:51:11AM -0700, Guenter Roeck wrote:
> On 03/27/2015 01:09 AM, Wolfram Sang wrote:
> >
> >>just to give you an update: I do have some code, but it is a bit messy,
> >>and it doesn't work well for ds2482 (the chip behind it still hangs up
> >>if I access it in parallel through i2c-dev). On top of that, it causes
> >>pretty significant slow-downs when accessing other devices on the same
> >>bus at the same time. Not surprising, I guess, since it expands the scope
> >>of the bus lock significantly.
> >
> >Just to get a better idea: Did you try taking the adapter_lock before
> >the two SMBus command which needed to be concatenated (and use
> >smbus_xfer directly)?
> >
> I did. I didn't use smbus_xfer directly, though, but introduced lockless
> versions of the various smbus commands, and kept using those.

And then the chip still hangs? Or was that the performance penalty here?


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFVSUAAoJEBQN5MwUoCm2YdEP/3I4aRn/NGZ7OhMCxtsIO01Z
T776Yg2eqPez7VLHy2oIpgUdvKw9DFEGNzuWzxoCFc5QnT33NH8DaFKrmwY4C67w
mXeGpxAaJ6NCRPRVl/5ql5GL/EzIXDQor7/rl/YqzavSvLbcAlKyLfmgnHo5cmhY
BXcrd+QGkxilzeuF1gflZDbYjiJ87azLWsHqhLUvduMEL4iedt9YY4HfFDr5OEXf
ugj7HSsILtrA1nsS8WrSFfAHaKZZEnD8BbHaqtbcm1Jl2xdc8YeGWLhc6XxrTRN0
MmbI6aJ5P2aZxGHaT/vHDddtFVp7PAwZnwjF9L5f0VWMcUXkHjP76ahHOCS76MGp
qDYIjJLv889uoqnt1QBh0vIdOnEmEZbV+ZsA4d764EzNxQj7wLDQpDAq57t7Q+Ki
FuLU7eNM5uj6AeYx6roEzmpuLxp5suKqp2sHtuU/g/QLohG54Jli4uh0P7Ke/tCK
ckQgoDgfHSv+y5d1VPnJecLix4y3Rgk6pNmWH61gLsLIToowghLIyyDwWjSJ0MAd
7q9XGlBlBZIJ9sMqpthWDdGGRDka2ifLzE2HSK1YoN8uY3akDTpXY/qKZKNuPt2Z
FJLVFue8rk6AszYQJeXv0PTGJ5/6Qpeu7286VWEH1mR8oaQ9fB7OoKzyOaZvnQeT
HGT0x0k1Zdj+AdaUwgwI
=NeZ/
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
