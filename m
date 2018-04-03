From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
Date: Tue, 3 Apr 2018 20:32:20 +0200
Message-ID: <20180403183219.htbg3w6mejmysoel@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
 <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
 <20180403181216.f22vtkqrnxjgreuo@ninjato>
 <CAKv+Gu8R19T+9O2tODQeS9vtKANmBXgGcavkRdVRU0NmVtHn2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6981967126308911530=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKv+Gu8R19T+9O2tODQeS9vtKANmBXgGcavkRdVRU0NmVtHn2w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--===============6981967126308911530==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7f7znd6olo3gnx46"
Content-Disposition: inline


--7f7znd6olo3gnx46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I have used it with a ATSHA204A crypto chip, using a userland driver
> and i2c-dev, and with a NXP PCF8563 RTC using the kernel driver.

Sounds good. Suspend/resume?


--7f7znd6olo3gnx46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDyLMACgkQFA3kzBSg
KbZP+Q//W9e4Pq9EjYwqFJ5XV9wZpTW1zxMO3COwJmvVIS2oDscHy4LakD9dfPkQ
LXDtpaW0Mmi8uHL8FyCeowJ12/CGChOO8SthjNNV10XvkKlVcAXU0JLOUIg3XNXV
sGWGtFVkvCSQsJoKvYzjqO0XQD6eF4vM/Yr5R3BHIZLDGH+RpoS+UnjC8CcdqU2H
C+9Tk7HkdKtf2xO1R+yT/oZolF3p9vX3N2g6cd3NFs1dFLYC7srLVu7aXB0Spqoy
TvPYpfWJsfAHXPlMBinNlPGtfSAdUIIiJeIxgUjl5ovdfDPS4SM4e7yWE9oCNNa3
aCoJJkfVS4gUKH+nJc6mElhlyAB1OObfn/BZbDDbBP+02/kbxAAT9Xv4YR0/30IP
/Xk9ZYRIM75x3lRLl23siYmYnU6VE97fqqaUlGQWN7yYI3PoGDnj67mxr2dk5iYh
1CxBiFrKXI/Qc1GGdQjG8Uv7xjk198UrXVFhENjhmaX7L9pvAJ4a63TNTIHDhqUb
mzAuNI57aFpQL61/sPaHH/ORqiPubmXW1smW+vSnVxaqwjkw4a1IKY/BJl27vHC2
RCIyrZbbuXe5Fin984oLQe8JIbrpv+ZWYtTk+sz2C1h4qb7cVWyXRhhwJoSKYuuG
//nV9WZEs+Mx2rfL8tbpGy71Gjnl7/dIrPENDg2ywVahPBMg7VI=
=HHRl
-----END PGP SIGNATURE-----

--7f7znd6olo3gnx46--


--===============6981967126308911530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6981967126308911530==--
