From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: qup: Fix order of runtime pm initialization
Date: Fri, 3 Oct 2014 03:21:38 +0200
Message-ID: <20141003012138.GH1323@katana>
References: <1412028051-21774-1-git-send-email-agross@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412028051-21774-1-git-send-email-agross@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <agross@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Bjorn Andersson <bjorn.andersson@sonymobile.com>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 05:00:51PM -0500, Andy Gross wrote:
> The runtime pm calls need to be done before populating the children via t=
he
> i2c_add_adapter call.  If this is not done, a child can run into issues t=
rying
> to do i2c read/writes due to the pm_runtime_sync failing.
>=20
> Signed-off-by: Andy Gross <agross@codeaurora.org>

Applied to for-current, thanks!


--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULfohAAoJEBQN5MwUoCm2qaIP/1H0wlX9Fe+0xy2IB3MnX5Ya
jlgiCl2ixzSy3Q328pDjwaNgt6uSjSC/ZD6kWkZ5p8ReLb9mb+tFT9GgDRZXrCnZ
f2n1kSsOBjwrXEUE6PliIHga0FRWgZziNku5d4QtsxVPbynH3Bm6S7UUrhdYg6gX
PLR4oL1SKTW5HDFxfIjD0rHSTqQ6doPEbewow1CvTGR2eFC7MlNBGaoSkk6abQai
n8EmMCWLdovKQrMc5aXLydhEx6HuUh3Pi0brEaXvUeiB6RKnBidgJIDfMQjudUIA
zIOTLnHWbphpbT48iHKUp2oe8DgDL4yyf3rjEBsgDvxz/A5rAODtXH9my5T+//NH
1EfNvPsN+LicEwk6epTnAq5vb6W6nRpVSVjHDYSldxc/FaWqNgphtbeRlfG9XE51
FHPT5N8UytcCjMXMwaEDIFn1u4OBv0vO358NW1x31wD5G0MAku3t0o2EY4GrmCoz
UWYroII3Pc4MEy2G/2mJDilnxpDR43GqRdlZDV6lI3sLwF2IFC/J1Cdaak28SK19
n7bvdvhfKL0znfoROkPRaymjkUhVUlxeR7LgAlN8lL+zHdx5DZdZjGRjkfHk9dJ8
hJPOQGyQHUNbnE/snuddqVL0GNHc0TuVMqimcDD+Y0DW3YZwO4mk6hfNDeDzOmNQ
URPYDG6QyR3ppNjzqbi0
=nZj/
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
