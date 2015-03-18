From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Wed, 18 Mar 2015 15:00:37 +0100
Message-ID: <20150318140037.GE3580@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana>
 <55097C46.9010605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55097C46.9010605@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Gabriel Dobato <dobatog@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2015 at 02:23:18PM +0100, Sebastian Hesselbarth wrote:
> On 18.03.2015 13:30, Wolfram Sang wrote:
> >On Mon, Mar 09, 2015 at 01:21:05PM +0100, Sebastian Hesselbarth wrote:
> >>I2C mux pinctrl driver currently determines the number of sub-busses by
> >>counting available pinctrl-names. Unfortunately, this requires each
> >>incarnation of the devicetree node with different available sub-busses
> >>to be rewritten.
> >>
> >>This patch reworks i2c-mux-pinctrl driver to count the number of
> >>available sub-nodes instead. The rework should be compatible to the old
> >>way of probing for sub-busses and additionally allows to disable unused
> >>sub-busses with standard DT property status =3D "disabled".
> >
> >Not sure about this change. With DYNAMIC_OF these days, you can't rely
> >that 'disabled' stays disabled all the time. My gut feeling tells me
> >that people will want to use this someday.
>=20
> Possible. But this change just makes i2c-mux-pinctrl honor status
> property at all. There is no functional change except it now allows
> you to disable any of the sub-busses.

Actually, this is the feature I like. However, I wonder if we shouldn't
have that in the core, say in of_i2c_register_devices()?

> I agree that this driver still does not cope well with DYNAMIC_OF but
> neither did the former implementation. How about we settle this driver
> to this implementation now and wait for any maniac that wants to use it
> the way you are suggesting above?

Sure. I don't want you to make this driver OF_DYNAMIC compatible. I just
thought it makes it harder, though, e.g. you allocate memory for the
number of active busses not the number of possibilities, so that would
have to be reverted by the "maniac". I am still at the glimpse level,
but what if we let the mux-pinctrl parse all the data (even for disabled
busses), but only the enabled ones will get a muxed adapter because this
is handled in of_i2c_register_devices()?

> BTW, I have received a patchwork update notification - it may be
> unrelated but I prefer the Dove dts/dtsi changes to go through mvebu
> tree.

Yes, I only take dts patches in rare cases.


--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCYUFAAoJEBQN5MwUoCm294UQAKtiCrW6w3cXTTzqtE31Mf7K
Xesd6Zxo6QkwCWL9GH+ocUcT58i9vjEb/99QW9YV01dwVkX+PU0eZqJD3em9tHGT
uTiU7fWNjsHGjEoeZDXRRfyb4CWOUkpde7sa1JUNDXNA8c3wxSciAQ9BaxSgRmMd
HLR2V3ggHWdw4TTEJUSztZMGqGYfUKEZvYK21OAwcGgn6qDCpQRFIR3UZmfwmSiE
m3+gfWHLPyErF4EOPp0/sv8vEqsr04OQIFm2/Hi17Xea6neFo8DAWzwTmmtT1xq7
QinxN2d41N6npfbidI5RXebLbVguPOE9joha+J0RswSrFEhCt+skdieZWVI17l2t
EVGUoYr+RkGwJQi4gEV2owr1UP4+9rWd4Tqpg4DDQNOBKAW3DFLofX1TUKrychCr
NaTdtglfwuenvuzR77VusuCFXhvy+vJprDqbRIJuvtaqJ1hedZHb5QI1K8SyH3JS
fsnelQwYUc2FeX3ObEkeu+mpPMv6v1KkKhPa52kMad3RTMSny58fgKKM3/UJ6PoG
Jw2PWgt5IpDdwIy8Y1JkMlDQ5r90YD53gwXqwrvzaRWH8GwlqmjVZ9bIHgNi5eNH
tQ2n6394LwtHLSdZgIp2q4pij8aP5yJXGmTfVeGVhBFoVc0uEhbmOxRDDlobc0vS
5qM8gIUv8E5oiATRt80+
=iY7V
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
