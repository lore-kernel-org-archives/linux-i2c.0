From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Date: Fri, 15 Feb 2019 10:09:59 +0100
Message-ID: <20190215090959.soxkf3ho3or2geme@ninjato>
References: <20190215090202.157100-1-hsinyi@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5826440666001856318=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190215090202.157100-1-hsinyi@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Jun Gao <jun.gao@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============5826440666001856318==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7e24ofik27zxdzz"
Content-Disposition: inline


--z7e24ofik27zxdzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshol=
d is
> 0 and msg->len is also 0, function makes zero-length allocation, which re=
turns
> a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause la=
ter
> code to fail. Modify the threshold to > 0 so the function returns NULL po=
inter.
>=20
> Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transac=
tions")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Right. But we need to fix i2c_get_dma_safe_msg_buf(), so it will be
handled for all callers. Do you want to add a check if msg->len is 0 or
shall I? Both fine for me.


--z7e24ofik27zxdzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmgecACgkQFA3kzBSg
KbbmfBAAqYW+JvwMtjirjdXC3UPcneALX9Iw2pOiZ2zmKVFJp27osp1IkQyxPDgW
WvJ1+0O2l2+YLM1HMxhQKZVSsULwUD8CaltGxlKypNQZa/ka8kWOffsOUODldueC
bqddzNomrk5OCmkywbbcAq4iVcxfLRffnrjqtP+CXHqxi5OIG5cNclI5u5zjnuOY
rEg7fu2p9p0wXS6fSfEW0iK84XKfbAkcyxJLryEx8o5QDAvow99wmFjJ3x9deKFf
UNcoRYUgyZK+DXQF0SUr1EuEOStuXC8yoKncyuYD7rfRIMQBU0Q/YDy3TnWj5Fa3
AI07nksJ+Swqzu3hn158vKvqMRkX9n+C6BSBgajGE/mAMffIHXuDTfxpNOkDDqri
FaVtITfGcp/s3aLCu8vFoyuyK05LV0xt7RGqMt4mglFU/dMXvRkKEyDmLx3ASdIl
7S2fO8ldd5DPTAKnpBJnEhxD1x2YdPqn0o8lMYMXPkIk1+6tFakXB7ACBJ4b5oJf
CBUzj/2aYGJ9RH5AEW+BVXnTrKwBTs885zmZkgHM/FxgusV6t1srPXImocRVvyQC
KtGiVLYW34c3x72ONu/09kPocbRJubyWUsCntSDWfIBuRkcQXmfbroNRq2SEFlGA
hy18Oc7VKRxSqrRs8V4ibmcpEY7BcMydmFC4aelBei3mCz1nHms=
=Jioo
-----END PGP SIGNATURE-----

--z7e24ofik27zxdzz--


--===============5826440666001856318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5826440666001856318==--
