From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: pmcmsp: remove dead code
Date: Tue, 13 Jan 2015 10:44:08 +0100
Message-ID: <20150113094336.GA1059@katana>
References: <1420744740-26468-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420744740-26468-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2015 at 08:19:00PM +0100, Wolfram Sang wrote:
> CPPCHECK rightfully says:
>=20
> drivers/i2c/busses/i2c-pmcmsp.c:151: style: The function 'pmcmsptwi_reg_t=
o_clock' is never used.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtOjoAAoJEBQN5MwUoCm2EIkP/RdYsRpy/YENBTaTLFILCMki
9IPu3ss4I1Dw1PopRIcGLgR/xK/CVevHE6pYLDxHlZp3F5mqJwaYTLXWcmsetLoH
7+OecBh7xEd3F7zGRAizroNhDu5DlP4b9QYyKYU99puTB+ItbPHTXWB1/ZQGifrS
IVJTkvJNaLHkhu9LE0hiHMMU8I7alLRU9J/iFrVV2CJxXeEhLD7ukUliPgLoiLof
cUTEoWDtETS/bzNKz4Axh6WzRFXNyW3H4YvIRgsWhoD4LNpxT4IwvSufIea1BiZp
UfqL7xursv3sWQOgWehmwOHb3f9f3GrTmF1mvhWc8jJKFX/yCA1bcqiugnfRkhhQ
7WWBN/wSmLLlIVlWoCHw04EuqPz2HkJityv/I6KyMw1d3PIhC499DLZYX4qCQV6k
UnAyUCmnJVqfqPDrTciQB8FUOGqOFhq2mpe7hidKcAL48BId6k5DZ5ZfrjONDLVL
Lpt37N8Aah4r1OfyXvMPBMfhiF/ygQ+018sKCZwpI0uMpFlx+rhFALXQFaulnHlQ
2NigVMXiWo1ZCk9HSCF5ghV9drQAu/IAmRnnGurlAIPFuBOJ+bfWvjVxfBsz+T4w
AsyBAR2zafae0lvGPg73oNlI43KaR3gaOkwvT21297D7Deu6ur/fCtJJyFRcUqW2
cLr9dRRDT5pLCM0dbGpb
=dtU8
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
