From: Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: i2c-gpio and boards conversions to GPIO descriptors
Date: Fri, 25 May 2018 19:30:12 +0200
Message-ID: <20180525173012.GD19100@kw.sim.vm.gnt>
References: <20180525154144.GC19100@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5995815441025571834=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180525154144.GC19100@kw.sim.vm.gnt>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--===============5995815441025571834==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 05:41:44PM +0200, Simon Guinot wrote:
> Hi Linus,

Forwarding to some mailing lists I missed in a first place.

>=20
> I think your patch b2e63555592f "i2c: gpio: Convert to use descriptors"
> may have broken i2c-gpio support for some boards using old fashion
> platform_device declarations.
>=20
> Indeed when an "i2c-gpio" platform_device is registered with a fixed id
> e.g. 0, then I think the device name becomes "i2c-gpio.0". And then this
> won't match a lookup table registered with an "i2c-gpio" dev_id.
>=20
> Please double check this :)
>=20
> Simon

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAlsISCQACgkQzyg/RDPm
szrMXw//ZhBPxvbe4iPbi7Q2UPFHrxh43ol1czp7AvQqIAe3WnrYWg3mEu4SLWvc
7EkYL2O4SfiHc+QLSs8ZV8IjjVYwfRZmneRSmfOQjgqDsMulgMq5xRfaLpvXQtpT
aEqc+HwImYCSSiU0FB3L2diHuo4wyGMOikogOzi6cHVdO3SrQNvyXUth1960OfxE
xk471bW1Lt3fzqJnjHzVEzewbPPSDbkNw/MT6+FAJ6ZyUZB+/+Fudneess08f9Je
/m44+zeVB7SfR1JM84Jlt07xYtrLoHLMRSyEk9K92I0yAecMerfbE99XN9euTHxb
XHRaKV4AufQO9F35Os9ak/Yh3XbMlRfE212kNPdIUqti7Tzf++uR4pozczjZuhUu
3IDd//YJSZ1XIG3ZWJ5jmBEVt4TUXeW1VTYkpnZ6JpmrKgG42JtUe0k0EZpkZxwH
XtGrOcU0oP1hwv6y1X5b+bLQWCX2fxKPaWM7pLwQFwsNNATF51iTUjjXhDGmpP9x
jmL295ezX2uNx4KG9IhuWWCeC7X8l4IIzaNpzFBLHRs3QGAh4wR+3M8mEU/3t/T2
HF26HehIlTCJMF1jUItZNSb7aTXEc798WjdCHNq7gAEGDHQ2PRTNRQ15Y8uBCi0F
pxxjGGFMwccVRXFV7QO/rWNqxSFM3bUJg//LlG2jNDpdhpJV14E=
=vti/
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--


--===============5995815441025571834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5995815441025571834==--
