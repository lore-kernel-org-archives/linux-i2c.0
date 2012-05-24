From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] i2c: i2c-bfin-twi: Move blackfin TWI register access
 Macro to head file.
Date: Thu, 24 May 2012 17:19:08 +0800
Message-ID: <CAJxxZ0NwNh70EzNYCqpSec+ZfeaxzJ3b=QY7w24EqmyA7+2VQw@mail.gmail.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
	<1337152826-9850-8-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337152826-9850-8-git-send-email-sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

PING

On Wed, May 16, 2012 at 3:20 PM,  <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-bfin-twi.c | =A0 45 -----------------------=
--------------
> =A01 files changed, 0 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i=
2c-bfin-twi.c
> index b2ca317..e6a0cba 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -33,51 +33,6 @@
> =A0#define TWI_I2C_MODE_COMBINED =A0 =A0 =A0 =A0 =A03
> =A0#define TWI_I2C_MODE_REPEAT =A0 =A0 =A0 =A0 =A0 =A04
>
> -struct bfin_twi_iface {
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> - =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> - =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read_write;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0command;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*transPtr=
;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 readNum;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeNum;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_mode;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 manual_stop=
;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result;
> - =A0 =A0 =A0 struct i2c_adapter =A0 =A0 =A0adap;
> - =A0 =A0 =A0 struct completion =A0 =A0 =A0 complete;
> - =A0 =A0 =A0 struct i2c_msg =A0 =A0 =A0 =A0 =A0*pmsg;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_num;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_msg;
> - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_clkdi=
v;
> - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_contr=
ol;
> - =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*regs_base;
> -};
> -
> -
> -#define DEFINE_TWI_REG(reg, off) \
> -static inline u16 read_##reg(struct bfin_twi_iface *iface) \
> - =A0 =A0 =A0 { return bfin_read16(iface->regs_base + (off)); } \
> -static inline void write_##reg(struct bfin_twi_iface *iface, u16 v) =
\
> - =A0 =A0 =A0 { bfin_write16(iface->regs_base + (off), v); }
> -
> -DEFINE_TWI_REG(CLKDIV, 0x00)
> -DEFINE_TWI_REG(CONTROL, 0x04)
> -DEFINE_TWI_REG(SLAVE_CTL, 0x08)
> -DEFINE_TWI_REG(SLAVE_STAT, 0x0C)
> -DEFINE_TWI_REG(SLAVE_ADDR, 0x10)
> -DEFINE_TWI_REG(MASTER_CTL, 0x14)
> -DEFINE_TWI_REG(MASTER_STAT, 0x18)
> -DEFINE_TWI_REG(MASTER_ADDR, 0x1C)
> -DEFINE_TWI_REG(INT_STAT, 0x20)
> -DEFINE_TWI_REG(INT_MASK, 0x24)
> -DEFINE_TWI_REG(FIFO_CTL, 0x28)
> -DEFINE_TWI_REG(FIFO_STAT, 0x2C)
> -DEFINE_TWI_REG(XMT_DATA8, 0x80)
> -DEFINE_TWI_REG(XMT_DATA16, 0x84)
> -DEFINE_TWI_REG(RCV_DATA8, 0x88)
> -DEFINE_TWI_REG(RCV_DATA16, 0x8C)
> -
> =A0static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned short twi_int_status)
> =A0{
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
