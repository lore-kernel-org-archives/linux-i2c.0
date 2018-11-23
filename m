From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date: Fri, 23 Nov 2018 13:47:30 +0100
Message-ID: <20181123124730.GA21651@ulmo>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <374af1fb-54bc-ee13-b4fd-616c2fe0746f@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <374af1fb-54bc-ee13-b4fd-616c2fe0746f@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh+dt@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 12:40:19PM +0000, Peter Rosin wrote:
> On 2018-11-23 13:10, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The "at," prefix was never correct for Atmel, so fix the few occurrences
> > that got it wrong. Use "atmel," instead.
>=20
> Fully agreed. However, given that atmel,24c08 is documented in .../eeprom=
/at24.txt
> I think it would be better to remove at,24c08 from trivial-devices.txt

Good point, will respin.

Thanks,
Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv39t8ACgkQ3SOs138+
s6GgpA/9HMnlBtqOGEZIOhZDI70tCul3alKe0py84MhZlf4lCr5PH3+znwzR+uVX
86VYxrs5iDM2oXz4lbXZ6O4zebMbnEIozyni7p2CqxgJ5Mk8z79ZkuovjIqhc5QM
9bbjuPbIiCh/TZflkm+1ujRA/iQCR7waRxBMEC5KIcWfwfA3Ddax/9TGGSGqvZAn
J3K9OhjvFIHl25lnEFCFKCj2HDx7jQp1+fZBwHtkMtRdYRT6toLedEsCOHXc45y0
W3vhp6OQiKVAlr+4UdcSuL53t6LYQ2l08IhC7B6ERY0XwvK5QOP8Ky8nj+mEZNjM
l9vHwiCoCYip/mHGHJuCFUdVXRz0RhRt3yLjl3fG/nMojapj7XUGVoMoT0s+4nxH
pvpATELxaevAsqEorvI99km2OYvOOw7Nlljq97ag3YjBn/cirbuwI1Lc5p+tigPA
TB9E6CFZp3gXtDg8MRa4yNphZeHvJPbyCKeAVMKUKksV1BfLqWVbGD6sJG59AjDu
g8t/B5H7335E0QzVtHjNntAnh1XSiwirJjm30nv9T/o5Oai6irurf+8Ap63C4hoN
T43ZGUDy5h9aNxk6G5P1Rsi9akmm+1Y6bb2dAyi6wA/miqfljqNgfBbISJUpRcEr
fi30H0uZnWySPb6eR3kwRX5i+tENLvLuD1sGGmejIpOFGTfRSec=
=63b1
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
