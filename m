From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [v6,1/2] i2c: qup: add ACPI support
Date: Tue, 29 Nov 2016 22:46:00 +0100
Message-ID: <20161129214600.GA23045@katana>
References: <1476203277-6893-2-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4420749512298508697=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476203277-6893-2-git-send-email-austinwc@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Austin Christ <austinwc@codeaurora.org>
Cc: wsa@the-dreams.de, linux-arm-msm@vger.kernel.org, timur@codeaurora.org, linux-kernel@vger.kernel.org, rruigrok@codeaurora.org, nkaje@codeaurora.org, linux-i2c@vger.kernel.org, sricharan@codeaurora.org, linux-arm-kernel@lists.infradead.org, cov@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--===============4420749512298508697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2016 at 10:27:56AM -0600, Austin Christ wrote:
> From: Naveen Kaje <nkaje@codeaurora.org>
>=20
> Add support to get the device parameters from ACPI. Assume
> that the clocks are managed by firmware.
>=20
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
> Signed-off-by: Austin Christ <austinwc@codeaurora.org>
> Reviewed-by: Sricharan R <sricharan@codeaurora.org>

Applied to for-next, thanks!


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPfcXAAoJEBQN5MwUoCm2kosP/A3AQBuh17mhQzhHgULhmjD/
C/5cx0QaEVxMyu8edUWcfNS2aeIPgMLX+wHeG44sIbj7kJHN3V3wgL2INzonVjHj
yl1Ba0Fo2DUvFOqZfeRoHYiLmxVXbA7HO3TSwhnZ1NlJvFk+PIKC3m2PGI8mvY3h
j2e+XUNijZGJk6QwDn6AJNualiDEli8lieAjmM9WofW1B54Y5tGlzeQS5fLlM0zc
HgxpQCqXDk/HCSXPnifQOC/nBZoQmql9FwNFbe0SOfLZxGn8T+3YiwjBwi/bh4y1
xyii1vB0Ywem+T91//lEVR04o26lrf3H/wa6bDDV+f+hISVwy1e9S1uqszMZGskl
WIwqebRWbl5Vdx6WB+dnQ6cyjJh1JaAmac2s+mXFwGftdCXlbT9StZ96ZK8DFeZ7
CW7Ony/RUMdCZGk6BTLNjDQoqtYoglv2bbpIySk3vSQUREE4X+q5cRIPk8Y3aiLF
jvdKjLpG3EBagvrtMypFyXkAC8RzG7HR2wUeP1w+Uidkb9ScLcsOKBhvv62hrHa5
uw5fwcWnHY5efPzTkOeCwGY7t4gS7SbtZ06HLT1qhLA8aFyfK/WT3KDFI/0IxpKv
MdgCIKcSS29cgTIPLSoQvVKizxriZNsKViIfKS9I5jYGEHrs+mWvWinvdsDGpOUW
ihIDjNlmsCvCxhWbI4fT
=YDej
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


--===============4420749512298508697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4420749512298508697==--
