From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: algo-bit: add support for I2C_M_STOP
Date: Fri, 23 Jun 2017 20:47:41 +0200
Message-ID: <20170623184740.figeulice6bw7523@ninjato>
References: <20170621092402.773a4b14@endymion>
 <20170621145426.yeourbp3coddjwmu@ninjato>
 <20170622110630.42eae574@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4yzme5aqj46kii2n"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170622110630.42eae574@endymion>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--4yzme5aqj46kii2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +					bit_dbg(3, &i2c_adap->dev,
> > > +						"emitting enforced stop/start condition\n"); =20
> >=20
>=20
> Go ahead, fine with me.

Did so and applied to for-next, thanks!


--4yzme5aqj46kii2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllNYkwACgkQFA3kzBSg
KbanjxAAopyvKqO+QTic9sK97Ubbz4cvmKSs4xtcsMmWh2MWo76fCDnmOwM1iTuI
dOPNjOGhR2DkKvr2QrChYsYFg6OW3L5XEZ+ITubc2TDTm5W3/ljs6krbgIxAJVEx
3HKGzmgzdAMLqG9gE3A1hfIG4ePrGJGvWWKT+4236hiNFfykl9mnp9fsLWpcUblt
fBJ3IVEqSng+0im+ziKNG6g3e5Xob7C3PdhjZgQ8ryd9yN6E8mvw1015SBlxi92Z
v3ffA/cfn3XbujL2blQPYSKm4GKvV7lFg++ZORvxz9kDj4tHyLOLoDZicnRZmcM0
UV7cGe66ADpUmAIR+XyC21pj4dNdfGYVivKVyldV5gZdfDZpH64s0owJBBDmgr+C
Xihsib/SuAVWLfIFQbizTtxC0AZ1YOFZaSQii6gHXAr34N6Q/tQ41H3sCld7vzZ3
WRSNNbB+p5wZLKJZnxrE5F8WZdOZw1EPm1BQqYOR4jA1raGuOrGX8cUbHXG37leG
VOLG5bMRcABJETG0tl3g8DFtctLS/wA2Whs+ReoWYCcRkddnlAWxAKp5PLmwFYDc
n/BSc52vk6dkKszcF8BKqEzvO/+oX3sJSCwfgl31Ht+7AXuZCQT7O5Tx0vSiMGFU
RhC11clLPEg6CLaR/z6VQbYtfn5kpCgNwj84jFauuZKhz5Wt4Y4=
=KQWV
-----END PGP SIGNATURE-----

--4yzme5aqj46kii2n--
