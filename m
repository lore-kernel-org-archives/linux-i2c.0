From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: mediatek: fix i2c multi transfer issue in
 high speed mode
Date: Tue, 1 Dec 2015 01:54:55 +0100
Message-ID: <20151201005455.GB2064@katana>
References: <1447047839-5223-1-git-send-email-liguo.zhang@mediatek.com>
 <1447047839-5223-3-git-send-email-liguo.zhang@mediatek.com>
 <CAGS+omAixwqw2QwR5_4VffHN66aAYNXP1ZJPxsq2WKcgzVxOZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46512 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488AbbLAAzD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 19:55:03 -0500
Content-Disposition: inline
In-Reply-To: <CAGS+omAixwqw2QwR5_4VffHN66aAYNXP1ZJPxsq2WKcgzVxOZw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Liguo Zhang <liguo.zhang@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2015 at 10:38:42PM +0800, Daniel Kurtz wrote:
> On Mon, Nov 9, 2015 at 1:43 PM, Liguo Zhang <liguo.zhang@mediatek.com> wr=
ote:
> > For platform with auto restart support, when doing i2c multi transfer
> > in high speed, for example, doing write-then-read transfer, the master
> > code will occupy the first transfer, and the second transfer will be
> > the read transfer, the write transfer will be discarded. So we should
> > first send the master code, and then start i2c multi transfer.
> >
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> > Reviewed-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c | 45 +++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-m=
t65xx.c
> > index dc4aac6..249df86 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -53,6 +53,8 @@
> >  #define I2C_FS_TIME_INIT_VALUE         0x1303
> >  #define I2C_WRRD_TRANAC_VALUE          0x0002
> >  #define I2C_RD_TRANAC_VALUE            0x0001
> > +#define I2C_TRAN_DEFAULT_VALUE         0x0001
> > +#define I2C_TRANAC_DEFAULT_VALUE       0x0001
>=20
> "TRAN" and "TRANAC" are not good names; this should be "TRANSFER_LEN"
> and "TRANSAC", based on the names of the registers to which you write
> these constants.
>=20
> Furthermore, these are not "default" values, they are the transfer
> length and number of transactions for sending the "master code", so:
>=20
> #define I2C_TRANSFER_LEN_MASTER_CODE         0x0001
> #define I2C_TRANSAC_LEN_MASTER_CODE       0x0001
>=20
> Similarly, I think the "TRANAC" in I2C_WRRD_TRANAC_VALUE and
> I2C_RD_TRANAC_VALUE should also be TRANSAC.
>=20
> >
> >  #define I2C_DMA_CON_TX                 0x0000
> >  #define I2C_DMA_CON_RX                 0x0001
> > @@ -365,6 +367,43 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, =
unsigned int parent_clk,
> >         return 0;
> >  }
> >
> > +static int mtk_i2c_send_master_code(struct mtk_i2c *i2c)
> > +{
> > +       int ret =3D 0;
> > +
> > +       reinit_completion(&i2c->msg_complete);
> > +
> > +       writew(I2C_CONTROL_RS | I2C_CONTROL_ACKERR_DET_EN |
> > +              I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN,
> > +              i2c->base + OFFSET_CONTROL);
> > +
> > +       /* Clear interrupt status */
> > +       writew(I2C_RS_TRANSFER | I2C_TRANSAC_COMP | I2C_HS_NACKERR | I2=
C_ACKERR,
> > +              i2c->base + OFFSET_INTR_STAT);
> > +
> > +       /* Enable interrupt */
> > +       writew(I2C_RS_TRANSFER | I2C_TRANSAC_COMP, i2c->base +
> > +              OFFSET_INTR_MASK);
> > +
> > +       writew(I2C_TRAN_DEFAULT_VALUE, i2c->base + OFFSET_TRANSFER_LEN);
> > +       writew(I2C_TRANAC_DEFAULT_VALUE, i2c->base + OFFSET_TRANSAC_LEN=
);
> > +
> > +       writew(I2C_TRANSAC_START | I2C_RS_MUL_CNFG, i2c->base + OFFSET_=
START);
> > +
> > +       ret =3D wait_for_completion_timeout(&i2c->msg_complete,
> > +                                         i2c->adap.timeout);
>=20
> How does the hardware know that this transaction should be a "master code=
"?
> Do you have to tell the hardware what value ('00001XXX') to use as the
> master code?
> The Master Code must be sent at <=3D 400 kHz, not the target clock.  How
> does the hardware know what rate to use?
> When sending the master code, arbitration is supposed to occur, such
> that only one winning master can proceed with the following high speed
> transaction.
> Where do you check that you won this arbitration?
> If this is not implemented, adding a "TODO" would be helpful.
>=20
> > +
> > +       completion_done(&i2c->msg_complete);
>=20
> This completion_done() is only useful if you check the return value.
> You should check it too, since we should only check for timeout if the
> message hasn't completed.
>=20
> > +
> > +       if (ret =3D=3D 0) {
> > +               dev_dbg(i2c->dev, "send master code timeout.\n");
> > +               mtk_i2c_init_hw(i2c);
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *ms=
gs,
> >                                int num, int left_num)
> >  {
> > @@ -539,6 +578,12 @@ static int mtk_i2c_transfer(struct i2c_adapter *ad=
ap,
> >                 }
> >         }
> >
> > +       if (i2c->auto_restart && i2c->speed_hz > 400000) {
>=20
> Don't we need to send the master code for *every* HS transaction, not
> just "auto_restart"?
>=20
> "400000" =3D> You already have a macro for this: MAX_FS_MODE_SPEED

Please address Daniel's comments and questions.

Thanks!


--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXO/eAAoJEBQN5MwUoCm2+bcP/iO5wimS2gexZaFLYVfM98TE
Gv9RbQ3ZR1W7kw0pRgUVtym19mClfezU+j7tjAMqIKH/IkdPFO3uLMI+Xf7acDau
QudGnAiqYbwDWiMkpRvqEPvGKmcsl3NR/O+QTGjZzFtEFATrlBdKUUoXESDABV7K
e/crd/zGCRM1pNkYBFQmYxyv5sUGV1wAbXMqbmLy/NATFhYekxJdEbJVxP7lrtoc
MNWP8OBdn6NVIxFIUE3c5ZHFryLbr0eVQr3Y+wrjIntEdtyg/onV7bjl5JUB8Wzx
82yIBhYSNSnMBVxF3NTBwePm76jIqnHW+8pm4lmLP1+DiuweyugDQuYKHd6P9hXr
5UBxphFOgbk6U1hrxi8QKEsnZYPG/j8oZc4YnoDF+L56Jt7z/hrX5XrSfLSmbam0
Cy0CpGtf5zJB+V7jlBdIL8mLw6BQedzDfzNCyZnMGeEIsjNoLEtG8BvnNKDPDMS7
w/nJHns1Jj3Rn7EAFrRIfu0flUVQaA3+2nHfGjdw/M5qWoo6dNoAdwYLUF/217VB
sQvkTXCLqMLw9a+ga2/9LxxW7FdN27T7ESf4CgkxKwa+pDTyifl/lbBRqqdle/bd
I5VBWKmOv1U4Fi/av+HLSLREwZtL9wrFZ6aY+ErgL0w/8wrh0jG6g+2TSfyonnWj
2TobxxuJmp77dO6/2S/4
=g8AH
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
