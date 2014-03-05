From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/5] i2c: mv64xxx: Add reset deassert call
Date: Wed, 5 Mar 2014 17:31:31 +0100
Message-ID: <20140305163131.GB9228@katana>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Return-path: <linux-sunxi+bncBDP47C6LHEIOXIW5TACRUBHDDLFUC-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393950521-4173-2-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2014 at 05:28:37PM +0100, Maxime Ripard wrote:
> The Allwinner A31 SoC using that IP has a reset controller maintaining
> it reset unless told otherwise.
>=20
> Add some optional reset support to the driver.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Applied to for-next, thanks!


--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTF1FjAAoJEBQN5MwUoCm2Ca8QAJwl5eVudH7RDwfMT8fsJE9u
+8vh8hddNetRsGFot1fn2ivmHdbMM6wp/kXcFmXsdLMqMr7ojDRfcWMptnsa0G1r
CiHN/2CuUFOEkQAX2HB6r1HWecnq2UE0cbN0XDpHuayD3rujlld/DG8RYjiZnYRC
+6kqs+DCSGkGJLIHtt+4re0DoJ4gmpbCZrqCU54v49Re7XQcUlCQarn871BWvp6u
QWnrnxsS2u6B4E5opBmVzR729jkQeO1XyQ56INzLdiYTDJhgyPO806RM7doQm4LU
Rpicfo2+rtKORLXakeHkeJGtF6Tv2lohssS2bkgHWK23YVQoylViuefOXOF+yGXj
f4QsmzyWTmdPYUuM7Su70VRKrnLIEVvnXjHByixMJk0xtzFA6rY8nnh7wjrmJUrF
tLX32FJGW0sOQrNlO6w7Mro942m7GMZfc/sQN68ZiUhHvJqqCAeOWk/dIyPjuhq4
BOhtvuXyotx9yEaqgnsYhl2m0Ry3j2VHX6qoGlNLepHO8rRhBRsxPeOkifmRAMuI
F4dleEES8tWzl2SkNihKfmKVDweEAdmdgHrxbpDvpaMrxTbxoibonCnspQ6xLgu1
z1/5ehmKEeQ9vHoXJ1NULjAa3SsmVR2F3DfEGWo7IwVkfFMTmPUTRRJcYSH6apoJ
SDZRSnaeksASRS+l9nUv
=jwPk
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
