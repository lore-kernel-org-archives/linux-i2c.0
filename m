From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: bcm2835: Model Divider in CCF
Date: Sat, 8 Jun 2019 00:38:23 +0200
Message-ID: <20190607223822.GG869@kunai>
References: <20190529042912.12956-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1574616671006844114=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190529042912.12956-1-nh6z@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: stefan.wahren@i2se.com, f.fainelli@gmail.com, swarren@wwwdotorg.org, team@nwdigitalradio.com, eric@anholt.net, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--===============1574616671006844114==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	devm_clk_unregister(i2c_dev->dev, bus_clk);

Is there a reason you call this and not rely on devm to unregister?

Other than that, looks good from what I can tell.


--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlz6514ACgkQFA3kzBSg
KbaMExAApAMFnRZJvXuFOCFels8tmkIPUkpkZ69YwmOIYzCf8kK1VDSpQ3jzmrVN
gWajpxvY8z9Vn3x95HPtzpuoo8qkhnydRE+mS98Yto2qek3Z6gMCjwY5V9X7go0P
y5goRoVDz7yLMvWtJMH+gc4fPrDoFXz17+vpkX1+fHz94Em/Q801nZTUsqe8S2K1
sCQrL37uijXaXlihwCWbRfn+XC26Ci4oyJ733rVUoc0LqSUH1uk19OwN1ASZ3M1l
yLDEnCh7FsEmi7n30F0bvF6EU718HrOb9assrqIvu6mzh+t1Pdmo/2Cw48ZQai4Q
Dp50Tzt5Ky7J0ufI1koR9h4xkQIRsy4lVNNzohkzOutgHNOPh3qmfjH/K4DAi0Hx
FIhl+mKU7QFlcFHTHfEUC+SZpC9Cu4mCnWdpvzoZvgOOm6BpH5vUg7NCcFhBY7wn
AoVojYqtZIjDuQmSHDLeQXbz7Tz0TeP7FF7ZUYEyOKnnSASMlWKf/XN3Rs0u9KaZ
GeBTT5aEXyIgUuVfXo+rJrW0/9KPbZ5aJpIa6c9eiDYHjbrNFIBl4PEpF+UmovPX
N+r8tXKI/UOqRzvqBFiIweFMl0kIPi9h/sZFERTLuYshmkN6bmLb/CR7rqvSfeQz
6jaeK7xsRVupOhNrNyAC5Blh6OX+uyzOjGDMhFPOyNVdW9EskGA=
=R1IH
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--


--===============1574616671006844114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1574616671006844114==--
