From: Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH 2/5] i2c: mediatek: remove useless code and replace definitions
Date: Tue, 4 Dec 2018 12:37:08 -0800
Message-ID: <CAGp9LzrC4xLML0D-8tq+T-042=vMEZF7rSNDYzT7imcBYgt7wA@mail.gmail.com>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com> <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qii.wang@mediatek.com
Cc: wsa@the-dreams.de, devicetree@vger.kernel.org, ryder.lee@mediatek.com, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

<qii.wang@mediatek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=883=E6=97=A5 =E9=80=
=B1=E4=B8=80 =E4=B8=8A=E5=8D=885:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: qii wang <qii.wang@mediatek.com>
>
> Completion_done is useless when we don't use its return value,
> so we remove it. Different speeds have been defined by macros,
> so we use macros definitions.
>
> Signed-off-by: qii wang <qii.wang@mediatek.com>
Reviewed-by: Sean Wang <sean.wang@kernel.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt6=
5xx.c
> index a74ef76..660de1e 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -456,7 +456,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>
>         control_reg =3D readw(i2c->base + OFFSET_CONTROL) &
>                         ~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
> -       if ((i2c->speed_hz > 400000) || (left_num >=3D 1))
> +       if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >=3D 1))
>                 control_reg |=3D I2C_CONTROL_RS;
>
>         if (i2c->op =3D=3D I2C_MASTER_WRRD)
> @@ -465,7 +465,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>         writew(control_reg, i2c->base + OFFSET_CONTROL);
>
>         /* set start condition */
> -       if (i2c->speed_hz <=3D 100000)
> +       if (i2c->speed_hz <=3D I2C_DEFAULT_SPEED)
>                 writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
>         else
>                 writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> @@ -642,8 +642,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>                 return -ETIMEDOUT;
>         }
>
> -       completion_done(&i2c->msg_complete);
> -
>         if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
>                 dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs-=
>addr);
>                 mtk_i2c_init_hw(i2c);
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
