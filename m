From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: bfin_twi: remove unnecessary Blackfin SSYNC from
 the driver
Date: Fri, 14 Feb 2014 18:15:27 +0800
Message-ID: <CAJxxZ0MNYrx7cO96765Z==QFUynE-CYfG5P=tSMSDmbJ0TzuaA@mail.gmail.com>
References: <1390899322-1184-1-git-send-email-sonic.adi@gmail.com>
	<1390899322-1184-2-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390899322-1184-2-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

PING

On Tue, Jan 28, 2014 at 4:55 PM, Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> Put necessary SSYNC code into blackfin twi arch header. The generic TWI
> driver should not contain any architecture specific code.
>
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/blackfin/include/asm/bfin_twi.h | 23 +++++++++++++++++++++--
>  drivers/i2c/busses/i2c-bfin-twi.c    | 14 --------------
>  2 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/arch/blackfin/include/asm/bfin_twi.h b/arch/blackfin/include/asm/bfin_twi.h
> index 34cc395..aaa0834 100644
> --- a/arch/blackfin/include/asm/bfin_twi.h
> +++ b/arch/blackfin/include/asm/bfin_twi.h
> @@ -18,7 +18,6 @@ static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
>         { bfin_write16(&iface->regs_base->reg, v); }
>
>  DEFINE_TWI_REG(CLKDIV, clkdiv)
> -DEFINE_TWI_REG(CONTROL, control)
>  DEFINE_TWI_REG(SLAVE_CTL, slave_ctl)
>  DEFINE_TWI_REG(SLAVE_STAT, slave_stat)
>  DEFINE_TWI_REG(SLAVE_ADDR, slave_addr)
> @@ -27,7 +26,6 @@ DEFINE_TWI_REG(MASTER_STAT, master_stat)
>  DEFINE_TWI_REG(MASTER_ADDR, master_addr)
>  DEFINE_TWI_REG(INT_STAT, int_stat)
>  DEFINE_TWI_REG(INT_MASK, int_mask)
> -DEFINE_TWI_REG(FIFO_CTL, fifo_ctl)
>  DEFINE_TWI_REG(FIFO_STAT, fifo_stat)
>  DEFINE_TWI_REG(XMT_DATA8, xmt_data8)
>  DEFINE_TWI_REG(XMT_DATA16, xmt_data16)
> @@ -60,4 +58,25 @@ static inline u16 read_RCV_DATA16(struct bfin_twi_iface *iface)
>  }
>  #endif
>
> +static inline u16 read_FIFO_CTL(struct bfin_twi_iface *iface)
> +{
> +       return bfin_read16(&iface->regs_base->fifo_ctl);
> +}
> +
> +static inline void write_FIFO_CTL(struct bfin_twi_iface *iface, u16 v)
> +{
> +       bfin_write16(&iface->regs_base->fifo_ctl, v);
> +       SSYNC();
> +}
> +
> +static inline u16 read_CONTROL(struct bfin_twi_iface *iface)
> +{
> +       return bfin_read16(&iface->regs_base->control);
> +}
> +
> +static inline void write_CONTROL(struct bfin_twi_iface *iface, u16 v)
> +{
> +       SSYNC();
> +       bfin_write16(&iface->regs_base->control, v);
> +}
>  #endif
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
> index fd0696e..0db3203 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -65,7 +65,6 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
>                 /* Transmit next data */
>                 while (iface->writeNum > 0 &&
>                         (read_FIFO_STAT(iface) & XMTSTAT) != XMT_FULL) {
> -                       SSYNC();
>                         write_XMT_DATA8(iface, *(iface->transPtr++));
>                         iface->writeNum--;
>                 }
> @@ -248,7 +247,6 @@ static irqreturn_t bfin_twi_interrupt_entry(int irq, void *dev_id)
>                 /* Clear interrupt status */
>                 write_INT_STAT(iface, twi_int_status);
>                 bfin_twi_handle_interrupt(iface, twi_int_status);
> -               SSYNC();
>         }
>         spin_unlock_irqrestore(&iface->lock, flags);
>         return IRQ_HANDLED;
> @@ -294,9 +292,7 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
>          *  discarded before start a new operation.
>          */
>         write_FIFO_CTL(iface, 0x3);
> -       SSYNC();
>         write_FIFO_CTL(iface, 0);
> -       SSYNC();
>
>         if (pmsg->flags & I2C_M_RD)
>                 iface->read_write = I2C_SMBUS_READ;
> @@ -306,7 +302,6 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
>                 if (iface->writeNum > 0) {
>                         write_XMT_DATA8(iface, *(iface->transPtr++));
>                         iface->writeNum--;
> -                       SSYNC();
>                 }
>         }
>
> @@ -315,7 +310,6 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
>
>         /* Interrupt mask . Enable XMT, RCV interrupt */
>         write_INT_MASK(iface, MCOMP | MERR | RCVSERV | XMTSERV);
> -       SSYNC();
>
>         if (pmsg->len <= 255)
>                 write_MASTER_CTL(iface, pmsg->len << 6);
> @@ -329,7 +323,6 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
>                 (iface->msg_num > 1 ? RSTART : 0) |
>                 ((iface->read_write == I2C_SMBUS_READ) ? MDIR : 0) |
>                 ((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ > 100) ? FAST : 0));
> -       SSYNC();
>
>         while (!iface->result) {
>                 if (!wait_for_completion_timeout(&iface->complete,
> @@ -453,7 +446,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
>          * start a new operation.
>          */
>         write_FIFO_CTL(iface, 0x3);
> -       SSYNC();
>         write_FIFO_CTL(iface, 0);
>
>         /* clear int stat */
> @@ -461,7 +453,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
>
>         /* Set Transmit device address */
>         write_MASTER_ADDR(iface, addr);
> -       SSYNC();
>
>         switch (iface->cur_mode) {
>         case TWI_I2C_MODE_STANDARDSUB:
> @@ -469,7 +460,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
>                 write_INT_MASK(iface, MCOMP | MERR |
>                         ((iface->read_write == I2C_SMBUS_READ) ?
>                         RCVSERV : XMTSERV));
> -               SSYNC();
>
>                 if (iface->writeNum + 1 <= 255)
>                         write_MASTER_CTL(iface, (iface->writeNum + 1) << 6);
> @@ -484,7 +474,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
>         case TWI_I2C_MODE_COMBINED:
>                 write_XMT_DATA8(iface, iface->command);
>                 write_INT_MASK(iface, MCOMP | MERR | RCVSERV | XMTSERV);
> -               SSYNC();
>
>                 if (iface->writeNum > 0)
>                         write_MASTER_CTL(iface, (iface->writeNum + 1) << 6);
> @@ -531,7 +520,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
>                 write_INT_MASK(iface, MCOMP | MERR |
>                         ((iface->read_write == I2C_SMBUS_READ) ?
>                         RCVSERV : XMTSERV));
> -               SSYNC();
>
>                 /* Master enable */
>                 write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
> @@ -539,7 +527,6 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
>                         ((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ > 100) ? FAST : 0));
>                 break;
>         }
> -       SSYNC();
>
>         while (!iface->result) {
>                 if (!wait_for_completion_timeout(&iface->complete,
> @@ -704,7 +691,6 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>
>         /* Enable TWI */
>         write_CONTROL(iface, read_CONTROL(iface) | TWI_ENA);
> -       SSYNC();
>
>         rc = i2c_add_numbered_adapter(p_adap);
>         if (rc < 0) {
> --
> 1.8.2.3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
