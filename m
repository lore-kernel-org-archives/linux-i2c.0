From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/3] i2c/at91: add support for runtime PM
Date: Sat, 8 Nov 2014 19:03:25 +0100
Message-ID: <20141108180325.GE4900@katana>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
 <1414133417-11530-2-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414133417-11530-2-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: ludovic.desroches@atmel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, khilman@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2014 at 02:50:15PM +0800, Wenyou Yang wrote:
> Drivers should put the device into low power states proactively whenever =
the
> device is not in use. Thus implement support for runtime PM and use the
> autosuspend feature to make sure that we can still perform well in case w=
e see
> lots of i2c traffic within short period of time.
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Applied to for-next, thanks!


--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXlrtAAoJEBQN5MwUoCm2dEgP/3CgAlRC/tVd2P9gDo9fxdH/
k8CpDbAD6f3RXH5etWInKCeVmeqO/w0PMUxE+dIfDFYJbDFU8JAeh/rUf7OVjOqJ
to1VfZ5GvMHpLMvy6GbiDfFjZZ8uMV4/ZuGFo1DKmznJZXe08+1TQyecU0l4ZYxr
fWeFfvEYM06mvcSG6TsMXlZIuMEcI8sAC7DEqCj9y4EK23S3pZX8/J2LW6LS3Kmw
ciGdEjFFVhaUQFJxwMUKveGqWs4r6GFgKetjlVTW/7jy5XdYt/QKWMGa7guythm2
I3Qh4ZY/dgh4LulH9NRt58HuIQZg5aYHXmGRX68IKr8xODNheyIu9K6dD1kHv5hx
YKg7xEM3MKAkJYszBwG99xw7XRuiUPMA/jv79tuq6hdmGAPkGPqHHS3aNndHAbvz
Wzi7ZGKeyb6C82dItrYzWTaRrY1iqWxxY5sjztCXUYpmcnYzokCl7qC7gqm3a8Mi
UuGJZpZePwtLORubhfv6pRer/Skv2eLeWyEziuHgbZgRE9PW9WmGMIiSUWqOPCEu
0FPI+uJu+Et95sDJucTSMkvHfVHTrRQBFNDc9AaIOlsnBmlUWJnhtjhVDAQ49STp
UO/o1soXSySlequzClTY9uRrvS2U2MmlF6kmXZYhAYJrjWrvTlSVWc2uz5rGcD0z
DnMn59OPSdfXf7SVnHTN
=/8Kn
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
