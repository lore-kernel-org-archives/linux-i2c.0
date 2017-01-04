From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Wed, 4 Jan 2017 11:25:50 +0100
Message-ID: <20170104102550.GA1452@katana>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au>
 <20161110153016.GJ26304@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110153016.GJ26304@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bump...

> Yes, this is a bug in the rcar-vin driver which is addressed in the Gen3=
=20
> patches. However I'm not sure those patches will make it to v4.10, not=20
> much review from the V4L2 side yet (Geert and Sergei have had a few=20
> comments so there will at lest be one more iteration).

Seems your predictions were correct. I still get:

* OOPS with renesas/dt-for-v4.11 and these patches on top
* no OOPS with renesas-drivers/master and these patches on top

So, it seems to me that we still should wait with the HDMI related
patches of this series until the rcar-vin-gen3 branch is in -next.
D'accord everyone?

Regards,

   Wolfram


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYbM2uAAoJEBQN5MwUoCm2f4gQAJtSLqqRypnXRiA9xKI2bIOk
ushY3K/ukTgI1C9n1lD7rv2kxaV8MlGf5GHDw74NK6TXAZd3Ikd6CfI+19wvZDVQ
zUgbsVPc+dECd7Wjegof+Bfkz2DTKel7qTmeErTj5oSB/YLk4xMu6rz2cadyMuEd
7XWTFiyDlEBoQ8futTomy6ctfHVoOqsDlbyo3vHL3qCy5i3KKHsVrDjFo823g0tY
Zlcf3zpXQh1ArPUEWxEe5yv2L9Fw7gbBLKotXTdahcE/VngtjZ1QhqczoTdjGExA
rX2wWgC++BVltyRtm1L3DuNpQ8HQoM53cYF2WscSDVTi6t0KKEHEwcwKhx8qKr6e
7Iy8SpGvnD/hRw52QtB7XhjTjoQQnKe9n355xD8oowFcyCC3kUjggbWdKhKu2blB
epns8nZbgOLKK52eK/+Ic6tPkkthPREmzz3L/mFdPa4QxfPZU83ZC7cO4ybpJHoi
FujMEL+/WXXGZ6usRfhhf/WHUxUJI88WRLKR7KEpDMA5K39tm0x1hPYVoDQqFIIR
qlztXU0QS4tggxVPvg+IQCD6o7Ho4OnWnBrc5o0ueshrpilSVMfFTQkmsycRmrmd
wMq7tbb2Fo47Hgpf14uqp4+k1MU6M6ND+ODl7velUPVbCQ1NYDRe9CKLfCaSL71j
sb6ESVWVo5heTsr8+5md
=++Lm
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
