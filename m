From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Date: Mon, 1 Apr 2019 17:13:52 +0200
Message-ID: <20190401151352.tf7ljaqpzic6hlj3@ninjato>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
 <20190401104756.GK11158@hirez.programming.kicks-ass.net>
 <20190401111323.ajvo4drongc6dtel@ninjato>
 <20190401112109.GB12232@hirez.programming.kicks-ass.net>
 <20190401115414.hxrqqjujvwczdafz@ninjato>
 <20190401134224.GD12232@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1442273164098100259=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401134224.GD12232@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============1442273164098100259==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5q7udkjw363natoy"
Content-Disposition: inline


--5q7udkjw363natoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Looking at kernel_restart_prepare(), we set SYSTEM_REBOOT in normal
> context, specifically it just did a blocking notifier call.
>=20
> So no, you'll have to combine the two.

I see now. Combining the two is still readable, but I'll abstract this
away into some 'i2c_is_atomic_xfer_mode()' helper with proper
explanation. Thank you for the input!


--5q7udkjw363natoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyiKrAACgkQFA3kzBSg
Kbb9fhAAgdxtR0YZkUVqgbe0pJ84u9zEPK81oMzK0wiWAJDrE+loguZeKFd2rsYd
Yn5ovyhRmkmXqBgMug/iR7mhmj/+IX6TAF0VJMuQce7liMApUqJB7XHVnDUdHLaZ
Jpb1w3VN4JjUPEdp3eRKPR4ECzScz3MLV1voP8LMjHP0q6kyWxN2GdecmRH7LyjY
Q++GClmliiPhRosMtEd6yBf921rMzQTYYvt//zWXBauofv8cyZlhce7b31tQl5Pb
uiNidBTG9otaRUjxbcNHYwTM3NFGv7fwTwljhksHpU5XxdDmDEV3QdBCKu1GVvZw
EnK/nPpVUNzOta9+wMDQyt48VYzFzO/iLrxZqr8fc+HtKolnawdETIA37ZJ389XT
wEcVVPZibe+PFBf3iiqBeBpWUIyyo3ruX5R38g5Wn0zWX7lfxHn8ZTYu6Fz6NF6f
Z98/HFIYDzWTU95JFIYTogJHhybZGBPLUaGXcCXzAZ3lE7HsmboM5uPZ0WKtoWrf
B9AzsHaNewBnNEHCDbApE/4CrActL82mN3xJ1vUVSEL9+l6pFkzs3wLzNJfmYgFg
udS+a/biNW8HrfthNpu5pwqF6WteelT56fJVMklXo5hEH7ou+IOBBVrmgbZL5oDO
I44J68uuTC4L18ekouyY0Znzr/LsDRfSOvSm6nmBzz7Fh5CTBro=
=FYTW
-----END PGP SIGNATURE-----

--5q7udkjw363natoy--


--===============1442273164098100259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1442273164098100259==--
