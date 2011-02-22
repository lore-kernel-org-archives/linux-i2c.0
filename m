From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: xiic: Use 32bit accesses only
Date: Tue, 22 Feb 2011 11:08:28 -0700
Message-ID: <AANLkTinRVKMdOU-8DYLHe5q92nb3ysKnnG-jq8f++AEs@mail.gmail.com>
References: <1298396971-611-1-git-send-email-monstr@monstr.eu> <1298396971-611-2-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298396971-611-2-git-send-email-monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 22, 2011 at 10:49 AM, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org> wrote=
:
> i2c driver is used for LE/BE that's why is useful to use
> 32bit accesses. Then it is not necessary to solve any
> endian issues.

Are you sure?  I would expect the BE version needs to use
io{read,write}32be variants of the accessors.  What platforms have you
tested on?

>
> Signed-off-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-xiic.c | =A0 66 +++++++++++++++++----------=
--------------
> =A01 files changed, 27 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-x=
iic.c
> index 0b7647b..78b3b82 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -178,21 +178,6 @@ struct xiic_i2c {
> =A0static void xiic_start_xfer(struct xiic_i2c *i2c);
> =A0static void __xiic_start_xfer(struct xiic_i2c *i2c);
>
> -static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 va=
lue)
> -{
> - =A0 =A0 =A0 iowrite8(value, i2c->base + reg);
> -}
> -
> -static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
> -{
> - =A0 =A0 =A0 return ioread8(i2c->base + reg);
> -}
> -
> -static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 =
value)
> -{
> - =A0 =A0 =A0 iowrite16(value, i2c->base + reg);
> -}
> -
> =A0static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, in=
t value)
> =A0{
> =A0 =A0 =A0 =A0iowrite32(value, i2c->base + reg);
> @@ -230,10 +215,11 @@ static inline void xiic_irq_clr_en(struct xiic_=
i2c *i2c, u32 mask)
> =A0static void xiic_clear_rx_fifo(struct xiic_i2c *i2c)
> =A0{
> =A0 =A0 =A0 =A0u8 sr;
> - =A0 =A0 =A0 for (sr =3D xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
> + =A0 =A0 =A0 for (sr =3D xiic_getreg32(i2c, XIIC_SR_REG_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!(sr & XIIC_SR_RX_FIFO_EMPTY_MASK);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr =3D xiic_getreg8(i2c, XIIC_SR_REG_OF=
=46SET))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr =3D xiic_getreg32(i2c, XIIC_SR_REG_O=
=46FSET)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg32(i2c, XIIC_DRR_REG_OFFSET)=
;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static void xiic_reinit(struct xiic_i2c *i2c)
> @@ -241,13 +227,13 @@ static void xiic_reinit(struct xiic_i2c *i2c)
> =A0 =A0 =A0 =A0xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK=
);
>
> =A0 =A0 =A0 =A0/* Set receive Fifo depth to maximum (zero based). */
> - =A0 =A0 =A0 xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, IIC_RX_FIFO_DEPT=
H - 1);
> + =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_RFD_REG_OFFSET, IIC_RX_FIFO_DEP=
TH - 1);
>
> =A0 =A0 =A0 =A0/* Reset Tx Fifo. */
> - =A0 =A0 =A0 xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_TX_FIFO_R=
ESET_MASK);
> + =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_TX_FIFO_=
RESET_MASK);
>
> =A0 =A0 =A0 =A0/* Enable IIC Device, remove Tx Fifo reset & disable g=
eneral call. */
> - =A0 =A0 =A0 xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_ENABLE_DE=
VICE_MASK);
> + =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_ENABLE_D=
EVICE_MASK);
>
> =A0 =A0 =A0 =A0/* make sure RX fifo is empty */
> =A0 =A0 =A0 =A0xiic_clear_rx_fifo(i2c);
> @@ -265,8 +251,9 @@ static void xiic_deinit(struct xiic_i2c *i2c)
> =A0 =A0 =A0 =A0xiic_setreg32(i2c, XIIC_RESETR_OFFSET, XIIC_RESET_MASK=
);
>
> =A0 =A0 =A0 =A0/* Disable IIC Device. */
> - =A0 =A0 =A0 cr =3D xiic_getreg8(i2c, XIIC_CR_REG_OFFSET);
> - =A0 =A0 =A0 xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr & ~XIIC_CR_ENA=
BLE_DEVICE_MASK);
> + =A0 =A0 =A0 cr =3D xiic_getreg32(i2c, XIIC_CR_REG_OFFSET);
> + =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_CR_REG_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cr & ~XIIC_CR_ENABLE_DEVICE_MASK);
> =A0}
>
> =A0static void xiic_read_rx(struct xiic_i2c *i2c)
> @@ -274,22 +261,22 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
> =A0 =A0 =A0 =A0u8 bytes_in_fifo;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 bytes_in_fifo =3D xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET=
) + 1;
> + =A0 =A0 =A0 bytes_in_fifo =3D xiic_getreg32(i2c, XIIC_RFO_REG_OFFSE=
T) + 1;
>
> =A0 =A0 =A0 =A0dev_dbg(i2c->adap.dev.parent, "%s entry, bytes in fifo=
: %d, msg: %d"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0", SR: 0x%x, CR: 0x%x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, bytes_in_fifo, xiic_rx_space=
(i2c),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg32(i2c, XIIC_SR_REG_OFFSET),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg32(i2c, XIIC_CR_REG_OFFSET))=
;
>
> =A0 =A0 =A0 =A0if (bytes_in_fifo > xiic_rx_space(i2c))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bytes_in_fifo =3D xiic_rx_space(i2c);
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < bytes_in_fifo; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->rx_msg->buf[i2c->rx_pos++] =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg8(i2c, XIIC_=
DRR_REG_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg32(i2c, XIIC=
_DRR_REG_OFFSET);
>
> - =A0 =A0 =A0 xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET,
> + =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_RFD_REG_OFFSET,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(xiic_rx_space(i2c) > IIC_RX_FIFO_DEPT=
H) ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IIC_RX_FIFO_DEPTH - 1 : =A0xiic_rx_spa=
ce(i2c) - 1);
> =A0}
> @@ -297,7 +284,7 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
> =A0static int xiic_tx_fifo_space(struct xiic_i2c *i2c)
> =A0{
> =A0 =A0 =A0 =A0/* return the actual space left in the FIFO */
> - =A0 =A0 =A0 return IIC_TX_FIFO_DEPTH - xiic_getreg8(i2c, XIIC_TFO_R=
EG_OFFSET) - 1;
> + =A0 =A0 =A0 return IIC_TX_FIFO_DEPTH - xiic_getreg32(i2c, XIIC_TFO_=
REG_OFFSET) - 1;
> =A0}
>
> =A0static void xiic_fill_tx_fifo(struct xiic_i2c *i2c)
> @@ -317,9 +304,9 @@ static void xiic_fill_tx_fifo(struct xiic_i2c *i2=
c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data |=3D XIIC_TX_DYN_=
STOP_MASK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(i2c->adap.dev.=
parent, "%s TX STOP\n", __func__);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_setreg16(i2c, XIIC=
_DTR_REG_OFFSET, data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_setreg32(i2c, XIIC=
_DTR_REG_OFFSET, data);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_setreg8(i2c, XIIC_=
DTR_REG_OFFSET, data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_setreg32(i2c, XIIC=
_DTR_REG_OFFSET, data);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -348,7 +335,8 @@ static void xiic_process(struct xiic_i2c *i2c)
>
> =A0 =A0 =A0 =A0dev_dbg(i2c->adap.dev.parent, "%s entry, IER: 0x%x, IS=
R: 0x%x, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"pend: 0x%x, SR: 0x%x, msg: %p, nmsgs:=
 %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ier, isr, pend, xiic_getreg8(=
i2c, XIIC_SR_REG_OFFSET),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ier, isr, pend,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg32(i2c, XIIC_SR_REG_OFFSET),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->tx_msg, i2c->nmsgs);
>
> =A0 =A0 =A0 =A0/* Do not processes a devices interrupts if the device=
 has no
> @@ -479,7 +467,7 @@ out:
>
> =A0static int xiic_bus_busy(struct xiic_i2c *i2c)
> =A0{
> - =A0 =A0 =A0 u8 sr =3D xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
> + =A0 =A0 =A0 u8 sr =3D xiic_getreg32(i2c, XIIC_SR_REG_OFFSET);
>
> =A0 =A0 =A0 =A0return (sr & XIIC_SR_BUS_BUSY_MASK) ? -EBUSY : 0;
> =A0}
> @@ -522,17 +510,17 @@ static void xiic_start_recv(struct xiic_i2c *i2=
c)
> =A0 =A0 =A0 =A0rx_watermark =3D msg->len;
> =A0 =A0 =A0 =A0if (rx_watermark > IIC_RX_FIFO_DEPTH)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_watermark =3D IIC_RX_FIFO_DEPTH;
> - =A0 =A0 =A0 xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rx_watermark - 1=
);
> + =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_RFD_REG_OFFSET, rx_watermark - =
1);
>
> =A0 =A0 =A0 =A0if (!(msg->flags & I2C_M_NOSTART))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* write the address */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_DTR_REG_OFFSET,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(msg->addr << 1) | XII=
C_READ_OPERATION |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XIIC_TX_DYN_START_MASK=
);
>
> =A0 =A0 =A0 =A0xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
>
> - =A0 =A0 =A0 xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
> + =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_DTR_REG_OFFSET,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg->len | ((i2c->nmsgs =3D=3D 1) ? XI=
IC_TX_DYN_STOP_MASK : 0));
> =A0 =A0 =A0 =A0if (i2c->nmsgs =3D=3D 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* very last, enable bus not busy as w=
ell */
> @@ -551,7 +539,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
> =A0 =A0 =A0 =A0dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, len:=
 %d, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ISR: 0x%x, CR: 0x%x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, msg, msg->len, xiic_getreg32=
(i2c, XIIC_IISR_OFFSET),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg32(i2c, XIIC_CR_REG_OFFSET))=
;
>
> =A0 =A0 =A0 =A0if (!(msg->flags & I2C_M_NOSTART)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* write the address */
> @@ -561,7 +549,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* no data and last me=
ssage -> add STOP */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data |=3D XIIC_TX_DYN_=
STOP_MASK;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,=
 data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_setreg32(i2c, XIIC_DTR_REG_OFFSET,=
 data);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0xiic_fill_tx_fifo(i2c);
> @@ -653,7 +641,7 @@ static int xiic_xfer(struct i2c_adapter *adap, st=
ruct i2c_msg *msgs, int num)
> =A0 =A0 =A0 =A0int err;
>
> =A0 =A0 =A0 =A0dev_dbg(adap->dev.parent, "%s entry SR: 0x%x\n", __fun=
c__,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg8(i2c, XIIC_SR_REG_OFFSET));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xiic_getreg32(i2c, XIIC_SR_REG_OFFSET))=
;
>
> =A0 =A0 =A0 =A0err =3D xiic_busy(i2c);
> =A0 =A0 =A0 =A0if (err)
> --
> 1.5.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
