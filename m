From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 8/8] i2c: i2c-bfin-twi: Move blackfin TWI register
 access Macro to head file.
Date: Fri, 25 May 2012 05:54:13 -0400
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D170230E5ADF@NWD2CMBX1.ad.analog.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
	<1337152826-9850-8-git-send-email-sonic.zhang@analog.com>
 <CAM=Q2csSuQ3R9U=XKwj9F0xijTxx_ULperAiQYD_X3a5GKVjFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2csSuQ3R9U=XKwj9F0xijTxx_ULperAiQYD_X3a5GKVjFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



>-----Original Message-----
>From: Shubhrajyoti Datta [mailto:omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>Sent: Friday, May 25, 2012 5:48 PM
>To: Zhang, Sonic
>Cc: Ben Dooks; Wolfram Sang; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; LKML; uclinux-dist-
>devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
>Subject: Re: [PATCH 8/8] i2c: i2c-bfin-twi: Move blackfin TWI register access
>Macro to head file.
>
>Hi ,
>Some minor comments/ doubts.
>On Wed, May 16, 2012 at 12:50 PM,  <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> wrote:
>> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>
>A small description may be helpful.
>Also the $SUBJECT says move the patch looks more like the remove.
>Am I missing something.

The subject says these definitions are moved to a head file by the other patch for Blackfin architecture.

Regards,

Sonic

>
>> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-bfin-twi.c |   45 -------------------------------------
>>  1 files changed, 0 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
>> index b2ca317..e6a0cba 100644
>> --- a/drivers/i2c/busses/i2c-bfin-twi.c
>> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
>> @@ -33,51 +33,6 @@
>>  #define TWI_I2C_MODE_COMBINED          3
>>  #define TWI_I2C_MODE_REPEAT            4
>>
>> -struct bfin_twi_iface {
>> -       int                     irq;
>> -       spinlock_t              lock;
>> -       char                    read_write;
>> -       u8                      command;
>> -       u8                      *transPtr;
>> -       int                     readNum;
>> -       int                     writeNum;
>> -       int                     cur_mode;
>> -       int                     manual_stop;
>> -       int                     result;
>> -       struct i2c_adapter      adap;
>> -       struct completion       complete;
>> -       struct i2c_msg          *pmsg;
>> -       int                     msg_num;
>> -       int                     cur_msg;
>> -       u16                     saved_clkdiv;
>> -       u16                     saved_control;
>> -       void __iomem            *regs_base;
>> -};
>> -
>> -
>> -#define DEFINE_TWI_REG(reg, off) \
>> -static inline u16 read_##reg(struct bfin_twi_iface *iface) \
>> -       { return bfin_read16(iface->regs_base + (off)); } \
>> -static inline void write_##reg(struct bfin_twi_iface *iface, u16 v) \
>> -       { bfin_write16(iface->regs_base + (off), v); }
>> -
>> -DEFINE_TWI_REG(CLKDIV, 0x00)
>> -DEFINE_TWI_REG(CONTROL, 0x04)
>> -DEFINE_TWI_REG(SLAVE_CTL, 0x08)
>> -DEFINE_TWI_REG(SLAVE_STAT, 0x0C)
>> -DEFINE_TWI_REG(SLAVE_ADDR, 0x10)
>> -DEFINE_TWI_REG(MASTER_CTL, 0x14)
>> -DEFINE_TWI_REG(MASTER_STAT, 0x18)
>> -DEFINE_TWI_REG(MASTER_ADDR, 0x1C)
>> -DEFINE_TWI_REG(INT_STAT, 0x20)
>> -DEFINE_TWI_REG(INT_MASK, 0x24)
>> -DEFINE_TWI_REG(FIFO_CTL, 0x28)
>> -DEFINE_TWI_REG(FIFO_STAT, 0x2C)
>> -DEFINE_TWI_REG(XMT_DATA8, 0x80)
>> -DEFINE_TWI_REG(XMT_DATA16, 0x84)
>> -DEFINE_TWI_REG(RCV_DATA8, 0x88)
>> -DEFINE_TWI_REG(RCV_DATA16, 0x8C)
>> -
>>  static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
>>                                        unsigned short twi_int_status)
>>  {
>> --
>> 1.7.0.4
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
