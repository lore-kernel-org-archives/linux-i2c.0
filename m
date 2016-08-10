From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0244/1285] Replace numeric parameter like 0444 with macro
Date: Wed, 10 Aug 2016 15:58:51 +0200
Message-ID: <20160810135851.GA1607@katana>
References: <20160802105246.30008-1-baolex.ni@intel.com>
 <CACRpkdZsgSfL9rwe-vU5S6nNy0weD3O3PZymUZQsvJhQTSjf=w@mail.gmail.com>
 <5052478.g1CZhtD17T@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6536418760077876564=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5052478.g1CZhtD17T@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Dave Airlie <airlied@linux.ie>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Baole Ni <baolex.ni@intel.com>, Andrew Duggan <aduggan@synaptics.com>, Kukjin Kim <kgene@kernel.org>, Borislav Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>, dougthompson@xmission.com, chuansheng.liu@intel.com, linux-arm-kernel@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============6536418760077876564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I assume Wolfram will merge this.
>=20
> I assume not, see http://lwn.net/Articles/696227/

Thanks for the pointer. I missed the discussion but came up with the
same conclusions: a) octals are easier to read and b) original author
should have asked if this change was feasible before posting 1285
patches :(


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXqzMbAAoJEBQN5MwUoCm2UwMP/2FZ50TOAgGf/ZEmLciGgqxM
I2TSHxs40llMir5m6YmlBUQBnfy/W4hiCmDNlaOvXmRYFJKe4/rS8TTnDNTo0rTF
yGdxtDeSdDY0e5LxuMHR1TteKOMsBdNSysTQGAa8GF0WW08j8RBYVfK+Lxju0p/i
T1GREBZpEn0eVjga0aX4rKq7km3qu9BNOamX81Ts3qT3jdSTPjeqgGWcVwBDimZy
/S/rKv/CJfouL7azJZoeRupB88dQ/KkE9QY0uZAmEWZIPgNa2VgtVlH6Csr6Ssvi
rM0fLfbFB+8kTwHUxXRIYkRRBB/Wgi8pCYDXMeCNISIf2yQMODD8w4TBgMx8Ti4V
GID4Or14LExws9EaMwNF0SIf43WmiM3cmjpNQe+w0gxGhz3EG1HarKUQIlJnVR0J
fXzmA+jeUH78h/EtRmzUU0jX0fiJ5jwcFGuFuvYPRxNixLpju+ItsukKyY1wp9wf
t5MiVeHYsSpWCNilauwZdsGREnuLJWFbyG0/Q53PvMFc/Kth1tDXbz3NIc7BXcvA
9EDQLA18FWHI7XVrM2BV0IgU3kPQwIU8AJYmcNZClWs/F7NyJzjLwIlpK3nN8f3O
Wpb7n+IZvxcex/5wQjFWKfgaPEX2FLWLd5gZFDvSryNSMab2jEu3UkBpX8oNoB69
zXI7KxjqgLjkdnvt73qc
=43hQ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--


--===============6536418760077876564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6536418760077876564==--
