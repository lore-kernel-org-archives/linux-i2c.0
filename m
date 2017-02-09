From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: busses: constify i2c_algorithm structures
Date: Thu, 9 Feb 2017 17:08:13 +0100
Message-ID: <20170209160813.b77an7ywhx4gnxjc@ninjato>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8911124393499140533=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: jdelvare@suse.com, andriy.shevchenko@linux.intel.com, kernel@stlinux.com, patrice.chotard@st.com, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, ludovic.desroches@atmel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, sonic.zhang@analog.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============8911124393499140533==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2bfrcdvqknmhxvv7"
Content-Disposition: inline


--2bfrcdvqknmhxvv7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 11:36:17PM +0530, Bhumika Goyal wrote:
> Declare i2c_algorithm structures as const as they are only stored in the
> algo field of an i2c_adapter structure. This field is of type const, so
> i2c_algorithm structures having this property can be made const too.
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to for-next with a shortened commit message, thanks!


--2bfrcdvqknmhxvv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlick+0ACgkQFA3kzBSg
KbZdIQ/5AXrZgALIEqIpBuw4RWzVdBSWQBwwcGcFLq785dr2BrdNRdyIrWoCg5xT
F1T2WFcFKN7UG8yWssRSz6QtEBsfRljIwnctORP8emtDiMxzL99fuRD6ulQvLt1Y
Pi0VDjz5JP495l2qI7p8symnftda8qlnPLVSaDVHQrEezfCDTmeEVKox+rfXSOVS
sqqlUmtX9mzpX6ySNdDWWghm3MvTWW8qVUBE/zn6suK633VslpYir7FTs0JZ3xO/
4TRC+z7mKTjHqt6erXlJ8nklVgL7ii9+JTBRTWVvJ+DAy5CVBRiJf9r3TNWC6lKo
HCtq5ZR6VxCSZp82Ds5EceNuu8K6Rah1YIGAS0TwRZWe7tkx1SRPv7Rtgnze08i4
5hF5x9cLcCEgnkC63lZkVw9HqR6BdHdYeLK7JbU5LPmdjnaUdRIzSwv/UG0jFzz4
NHavTok/1NzTIKx6C0FsS3tCvh5xx0ThSznx7ayEj+JrX6JsTMu1+EH5Id2qSDjy
G6Sb0wE8VkfPLcEYt1SXvSEV5q86jKB6cHDZkIObPjidh2WIQvV5luPo/f9VIevP
x/eC2761gIsOIX4hngCG+kE6f1HKQNCtjLR4xb+Wz7Y7StcUo+fLlSC2p+vJIaUj
d1yFOQdT8ndCCPPsNiiVT6sGjsolhP6p9hQRuvj7vvmK4v/UvWU=
=giab
-----END PGP SIGNATURE-----

--2bfrcdvqknmhxvv7--


--===============8911124393499140533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8911124393499140533==--
