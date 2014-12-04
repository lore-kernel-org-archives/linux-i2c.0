From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
Date: Thu, 4 Dec 2014 19:40:46 +0100
Message-ID: <20141204184046.GL7944@katana>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
 <20141203111518.GB1039@katana>
 <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjamM5M9kpPM/bcu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Max Schwarz <max.schwarz@online.de>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Eddie Cai <cf@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, Chris <zyw@rock-chips.com>, =?utf-8?B?5aea5pm65oOF?= <yzq@rock-chips.com>, han jiang <hj@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Lin Huang <hl@rock-chips.com>, caesar <caesar.wang@rock-c>
List-Id: linux-i2c@vger.kernel.org


--xjamM5M9kpPM/bcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> If you don't read all the below, my belief is that we should simply
> rename the strings in Addy's patch.  We should change "rise-ns" to
> "i2c-scl-rising-time" and "fall-ns" to "i2c-scl-falling-time".
> Wolfram: can you confirm this is OK?  I'm voting to leave the "-ns"
> off the end of both to avoid asymmetry.

New binding should have the "-ns" suffix, right? So, I'd vote to add the
suffix to the new bindings and deprecate the ones used in the designware
driver: "i2c-scl-rising-time-ns" and "i2c-scl-falling-time-ns"

It might be a little more work now, but it will help us in the future,
because it is the correct way to do it.

--xjamM5M9kpPM/bcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgKquAAoJEBQN5MwUoCm2/BgP/3HQXR2iRvK+F1+ZQS/jilk3
L/1gRWOud2ixUpGzPLCWeEEPO+MFO2Pbci4cE2ULPp6e2ta7eVRpOIOColSCYDMO
iamBdCYJ1af2s6Z7oPrMGihp9b9BurvJw1PmIqnXHmOUuUqjKkikFueCY5wMuHuS
LsFx71BFYKrVhAiuy5I3TkcUeZwc+GNrbZCoTLnWuD+I/tM6TtGeUlWn/1WSJbmU
Ht0iR8cpMSu/yGpNKKToXGT0iTsBkSbCoGaK5nej9jz/s55OvoCiq8pnw29d7qdq
VTlMLkrXxbYQJJ6JhM6TlT17Lakj/8PXxZMI0p+mXIWiXJYSpopd57vjg1GYD8OF
nZEYm40ppufY+gofuJvB2/RiCHf7N9eCiiqvcwMPjrMI5t3CqNtm3djI9oL4Hut4
psUy5rMO1ddRce911/o0teWdpfrerw7jmfD0zm4K3cB6Fgf4tvU8BdVXb+UhiR2I
R2yVOVEMgXsjeYRKJdFC5ALcwG3CXAcPyiqq89aSX3rfh52G6hTyXNlPN2ys5VUA
zkclj4i7EUz64JO1XTiRCXRW0JZ1QcKw4QqqkHATC+tHBBubV/Sp6XlbtkF4wDE+
40L8FhOC1D0ID/txWKJE5Mewbs9A7jT1pdy/0oQgZv5efLfaWJH7SQKRHV52ui9E
oLhql1hQxpvrS5IUQSrC
=Hh5C
-----END PGP SIGNATURE-----

--xjamM5M9kpPM/bcu--
