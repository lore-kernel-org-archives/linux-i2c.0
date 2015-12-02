From: liguo zhang <liguo.zhang@mediatek.com>
Subject: Re: [PATCH v2 2/2] i2c: mediatek: fix i2c multi transfer issue in
 high speed mode
Date: Wed, 2 Dec 2015 10:51:36 +0800
Message-ID: <1449024696.7079.6.camel@mhfsdcap03>
References: <1447047839-5223-1-git-send-email-liguo.zhang@mediatek.com>
	 <1447047839-5223-3-git-send-email-liguo.zhang@mediatek.com>
	 <CAGS+omAixwqw2QwR5_4VffHN66aAYNXP1ZJPxsq2WKcgzVxOZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:38490 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754820AbbLBCvy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Dec 2015 21:51:54 -0500
In-Reply-To: <CAGS+omAixwqw2QwR5_4VffHN66aAYNXP1ZJPxsq2WKcgzVxOZw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, srv_heupstream <srv_heupstream@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org

On Sat, 2015-11-14 at 22:38 +0800, Daniel Kurtz wrote:
> On Mon, Nov 9, 2015 at 1:43 PM, Liguo Zhang <liguo.zhang@mediatek.com=
> wrote:
> > For platform with auto restart support, when doing i2c multi transf=
er
> > in high speed, for example, doing write-then-read transfer, the mas=
ter
> > code will occupy the first transfer, and the second transfer will b=
e
> > the read transfer, the write transfer will be discarded. So we shou=
ld
> > first send the master code, and then start i2c multi transfer.
> >
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> > Reviewed-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c | 45 +++++++++++++++++++++++++++++=
++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i=
2c-mt65xx.c
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

Yes, I will follow your advice.

> >
> >  #define I2C_DMA_CON_TX                 0x0000
> >  #define I2C_DMA_CON_RX                 0x0001
> > @@ -365,6 +367,43 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i=
2c, unsigned int parent_clk,
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
> > +       writew(I2C_RS_TRANSFER | I2C_TRANSAC_COMP | I2C_HS_NACKERR =
| I2C_ACKERR,
> > +              i2c->base + OFFSET_INTR_STAT);
> > +
> > +       /* Enable interrupt */
> > +       writew(I2C_RS_TRANSFER | I2C_TRANSAC_COMP, i2c->base +
> > +              OFFSET_INTR_MASK);
> > +
> > +       writew(I2C_TRAN_DEFAULT_VALUE, i2c->base + OFFSET_TRANSFER_=
LEN);
> > +       writew(I2C_TRANAC_DEFAULT_VALUE, i2c->base + OFFSET_TRANSAC=
_LEN);
> > +
> > +       writew(I2C_TRANSAC_START | I2C_RS_MUL_CNFG, i2c->base + OFF=
SET_START);
> > +
> > +       ret =3D wait_for_completion_timeout(&i2c->msg_complete,
> > +                                         i2c->adap.timeout);
>=20
> How does the hardware know that this transaction should be a "master =
code"?
> Do you have to tell the hardware what value ('00001XXX') to use as th=
e
> master code?

When we set i2c speed > 400K , the hardware will send master code. We
have a register to configure master code=EF=BC=8Cand usually we use the=
 default
value "00001000".

> The Master Code must be sent at <=3D 400 kHz, not the target clock.  =
How
> does the hardware know what rate to use?

The i2c speed is defined in dts, and we will set the i2c speed in i2c
register, so HW will know the rate to use.

> When sending the master code, arbitration is supposed to occur, such
> that only one winning master can proceed with the following high spee=
d
> transaction.
> Where do you check that you won this arbitration?

> If this is not implemented, adding a "TODO" would be helpful.
>=20
Our i2c driver now only support one master.

> > +
> > +       completion_done(&i2c->msg_complete);
>=20
> This completion_done() is only useful if you check the return value.
> You should check it too, since we should only check for timeout if th=
e
> message hasn't completed.
>=20
I will delete the completion_done() function.

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
> >  static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg=
 *msgs,
> >                                int num, int left_num)
> >  {
> > @@ -539,6 +578,12 @@ static int mtk_i2c_transfer(struct i2c_adapter=
 *adap,
> >                 }
> >         }
> >
> > +       if (i2c->auto_restart && i2c->speed_hz > 400000) {
>=20
> Don't we need to send the master code for *every* HS transaction, not
> just "auto_restart"?
>=20
When we don't use auto restart, we also need to send the master code,
the master code is sent by HW automatically.
I am improving the master code section when use auto restart, and this
will be released in the next patch.

> "400000" =3D> You already have a macro for this: MAX_FS_MODE_SPEED
>=20
Yes, I will use MAX_FS_MODE_SPEED.

> > +               ret =3D mtk_i2c_send_master_code(i2c);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         while (left_num--) {
> >                 if (!msgs->buf) {
> >                         dev_dbg(i2c->dev, "data buffer is NULL.\n")=
;
> > --
> > 1.8.1.1.dirty
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
