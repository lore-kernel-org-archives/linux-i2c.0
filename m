From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 15/28] i2c: eg20t: set i2c_adapter->dev.of_node
Date: Thu, 3 Dec 2015 22:06:01 +0100
Message-ID: <20151203210601.GF8509@katana>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-16-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1448900513-20856-16-git-send-email-paul.burton@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 04:21:40PM +0000, Paul Burton wrote:
> Set the I2C adapter devices of_node to that of the PCI device, such that
> I2C clients may be instantiated via device tree.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Applied to for-next, thanks!


--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYK65AAoJEBQN5MwUoCm2WgoP/2+pGSMn6dhbwEEp0XpkhDQS
gmT3L80YwMXT82Xn/9wyQ+C1z//Ifks7A1fD2nR+DJBARC2EzS4dFe26s+d2cgRj
tls2jt+Ok73wyIlJLQ8SESIW4vtI5iad2IbtjJhMwj0kx8T4RPA+VBvLEV/E5ABQ
a1GbB+7hZ942dDPUqcZYmDVeAqN4SVHp+UVeMTLjTK6c4pTPunB1mKDvGW66vbsI
ubP3oOeSe0ip0JR4E2xy6FynroiZZWdbuXfjp9u4wWZs1YriFu4Ktj6zpPtKNNZa
9cb8OV+fOoUbEMIru4Rmq1QOkmtchRPOvAnXJZFo4LgQT4VrHWkd9L+TPu08vmMa
a0X3KtzebwhHpzz2zgwPpHKQjjtSTytWsZJvNCrYHaJFqYuwveup6MWl5lJ1mL+W
l+3ozdsk+qr7StilGU4oA+fZMoNjF3CgCd058HjJPniPj7O7WZmcAae++6SJj31h
cwqufLuXiRKnIoy3Ug2X3m4XJ5gXWjZH5CMPhjwlGGhc74fsQOqDEzGrxCBbk+60
YbBOMSndY0KSSeF571o7qm3OxFKAklQsvAN1Jje+JUIGlZWhqdYrlb3OswThIStD
aiqdoUkKMHlrXkhScKkjsfqmdH5uO6XYK1qtmvAKLHZiKrIWFguRgC7FG4f5ED5k
377gltsbwvXw1qsX9Fmu
=laPP
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
