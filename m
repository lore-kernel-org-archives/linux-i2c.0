From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: OMAP: send i2c message ignoring NAK
Date: Tue, 17 Jul 2012 11:31:33 +0200
Message-ID: <CAGm1_ktYqq5HKt13RuQVL8axX0FUnZ_5a6va7BRuUschQRKERQ@mail.gmail.com>
References: <CAGm1_ktL96X7kF3tvKErtirwnL7FGU=zGe+EyhX4GcUkZUeSkQ@mail.gmail.com>
 <20120703103221.62fcb7ae@endymion.delvare> <CAGm1_kvBerv_Ot-NX2+ozZT3y+h4ECzwb-MM0-v=3M9aRRznzA@mail.gmail.com>
 <CAM=Q2cv2yCEaxjSL45PSpf8k8pgMuhr88TJ-RWc0OW1GL+n6Dg@mail.gmail.com>
 <CAGm1_kvLwj3iFz5M6zc+pitS_45OYPYw=aBU4bv8TdOhH600NA@mail.gmail.com>
 <4FFDAF5A.8070205@ti.com> <CANQgH-YxYY7M6o4Hxw0kq9=GSwF8TSgiobXLJoPnGhj=c3w4KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANQgH-YxYY7M6o4Hxw0kq9=GSwF8TSgiobXLJoPnGhj=c3w4KQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 12, 2012 at 7:24 AM, Datta, Shubhrajyoti
<shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
> On Wed, Jul 11, 2012 at 10:22 PM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>> On Wednesday 11 July 2012 09:53 PM, Yegor Yefremov wrote:
> [...]
> Yegor I have made a patch to ignore the NACK in the ISR let me know if
> that helps you.
>
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 9895fa7..e13061f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -476,6 +476,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>
>         if (msg->len == 0)
>                 return -EINVAL;
> +       if (msg->flags & I2C_M_IGNORE_NAK)
> +               dev->flags |= OMAP_I2C_FLAG_NO_NAK;
>
>         omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
>
> @@ -776,18 +778,26 @@ complete:
>                                 ~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
>                                 OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
>
> -               if (stat & OMAP_I2C_STAT_NACK)
> +               if (stat & OMAP_I2C_STAT_NACK &&
> +                               !(dev->flags & OMAP_I2C_FLAG_NO_NAK)) {
>                         err |= OMAP_I2C_STAT_NACK;
> +                       omap_i2c_ack_stat(dev, stat &
> +                               (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> +                               OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
> +                               OMAP_I2C_STAT_ARDY));
> +                       omap_i2c_complete_cmd(dev, err);
> +                       return IRQ_HANDLED;
> +               }
>
>                 if (stat & OMAP_I2C_STAT_AL) {
>                         dev_err(dev->dev, "Arbitration lost\n");
>                         err |= OMAP_I2C_STAT_AL;
>                 }
> +
>                 /*
>                  * ProDB0017052: Clear ARDY bit twice
>                  */
> -               if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
> -                                       OMAP_I2C_STAT_AL)) {
> +               if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_AL)) {
>                         omap_i2c_ack_stat(dev, stat &
>                                 (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
>                                 OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
> index 92a0dc7..f386150 100644
> --- a/include/linux/i2c-omap.h
> +++ b/include/linux/i2c-omap.h
> @@ -29,6 +29,7 @@
>  #define OMAP_I2C_FLAG_BUS_SHIFT_1              BIT(7)
>  #define OMAP_I2C_FLAG_BUS_SHIFT_2              BIT(8)
>  #define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
> +#define OMAP_I2C_FLAG_NO_NAK                   BIT(9)
>
>  struct omap_i2c_bus_platform_data {
>         u32             clkrate;

Thank you for the patch and sorry for delay. I tried the patch, but it
doesn't help. I still get timeouts only. I fear it is really a
hardware feature, that OMAPs i2c stops if address is not acknowledged.
At least this is my understanding of the reference manual.

Here is the output from dmesg:

i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
omap_i2c omap_i2c.2: addr: 0x0039, len: 2, flags: 0x0, stop: 1
omap_i2c omap_i2c.2: IRQ (ISR = 0x4000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x0004)
i2c i2c-2: master_xfer[0] W, addr=0x39, len=1
i2c i2c-2: master_xfer[1] R, addr=0x39, len=1
omap_i2c omap_i2c.2: addr: 0x0039, len: 1, flags: 0x0, stop: 0
omap_i2c omap_i2c.2: IRQ (ISR = 0x4000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x1004)
omap_i2c omap_i2c.2: addr: 0x0039, len: 1, flags: 0x1, stop: 1
omap_i2c omap_i2c.2: IRQ (ISR = 0x3000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x0004)
SIIHDMI: Device ID: 0xb0
i2c i2c-2: master_xfer[0] W, addr=0x39, len=1
i2c i2c-2: master_xfer[1] R, addr=0x39, len=1
omap_i2c omap_i2c.2: addr: 0x0039, len: 1, flags: 0x0, stop: 0
omap_i2c omap_i2c.2: IRQ (ISR = 0x4000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x1004)
omap_i2c omap_i2c.2: addr: 0x0039, len: 1, flags: 0x1, stop: 1
omap_i2c omap_i2c.2: IRQ (ISR = 0x3000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x0004)
(rev 0.2)
i2c i2c-2: master_xfer[0] W, addr=0x39, len=1
i2c i2c-2: master_xfer[1] R, addr=0x39, len=1
omap_i2c omap_i2c.2: addr: 0x0039, len: 1, flags: 0x0, stop: 0
omap_i2c omap_i2c.2: IRQ (ISR = 0x4000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x1004)
omap_i2c omap_i2c.2: addr: 0x0039, len: 1, flags: 0x1, stop: 1
omap_i2c omap_i2c.2: IRQ (ISR = 0x3000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x0004)
(TPI revision 0.3)
i2c i2c-2: master_xfer[0] W, addr=0x39, len=1
i2c i2c-2: master_xfer[1] R, addr=0x39, len=1
omap_i2c omap_i2c.2: addr: 0x0039, len: 1, flags: 0x0, stop: 0
omap_i2c omap_i2c.2: IRQ (ISR = 0x4000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x1004)
omap_i2c omap_i2c.2: addr: 0x0039, len: 1, flags: 0x1, stop: 1
omap_i2c omap_i2c.2: IRQ (ISR = 0x3000)
omap_i2c omap_i2c.2: IRQ (ISR = 0x0004)

I have placed some debugging output:

SIIHDMI: Device ID: 0xb0
 (rev 0.2)
 (TPI revision 0.3)

YY: NAK should be ignored (here the flag will be set according to the msg->flag)
omap_i2c omap_i2c.2: controller timed out
YY: NAK should be ignored
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
YY: NAK should be ignored
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out

Yegor
