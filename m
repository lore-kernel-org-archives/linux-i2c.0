From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-eg20t : Fix the issue of Combined R/W transfer mode
Date: Thu, 30 Jun 2011 10:16:59 +0200
Message-ID: <BANLkTi=zDMnwX5xYFazM3qb17wa6yY4LZw@mail.gmail.com>
References: <1308813430-2697-1-git-send-email-tomoya-linux@dsn.okisemi.com>
 <201106230952.09286.alexander.stein@systec-electronic.com> <4E02FD74.8020503@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E02FD74.8020503-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2011/6/23 Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>:
> (2011/06/23 16:52), Alexander Stein wrote:
>>
>> Do you have any other local pending patches which are not in git yet? I
>> can't
>> find this for loop in current master.
>>
>
> I sent a patch for i2c-eg20t in 9-June which haven't been reviewed yet by
> i2c maintainer.
>

I have tried both patches, as I need combined R/W with i2c-eg20t to
work. I have some devices connected
on this bus, but I don't get them to work.

- lm75 probe failed
- at24 eeprom read failed
- i2cdetect works sometimes

I am using a Intel Corporation Platform Controller Hub EG20T I2C
Controller [8086:8817].


This happens, when I want to readout the eeprom:

[ 2222.113891] i2c i2c-0: master_xfer[0] W, addr=0x50, len=1
[ 2222.113906] i2c i2c-0: master_xfer[1] R, addr=0x50, len=128
[ 2222.113919] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
:adap->p_adapter_info->pch_i2c_suspended is 0
[ 2222.113931] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
I2C_MODE_SEL :flag= 0x0
[ 2222.113941] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invoking pch_i2c_writebytes
[ 2222.113957] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL =
398 msgs->len = 1
[ 2222.134154] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_bus_idle :I2CSR = 28
[ 2222.134171] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL = 398
[ 2222.184143] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_xfer_complete
:timeout: 0
[ 2222.207152] i2c_eg20t 0000:02:0c.2: pch_i2c_stop :I2CCTL = 3b8
[ 2222.207185] at24 0-0050: read 128@0 --> -5 (1922207)
[ 2222.209093] i2c i2c-0: master_xfer[0] W, addr=0x50, len=1
[ 2222.209107] i2c i2c-0: master_xfer[1] R, addr=0x50, len=128
[ 2222.209118] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
:adap->p_adapter_info->pch_i2c_suspended is 0
[ 2222.209129] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
I2C_MODE_SEL :flag= 0x0
[ 2222.209140] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invoking pch_i2c_writebytes
[ 2222.209156] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL =
398 msgs->len = 1
[ 2222.230144] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_bus_idle :I2CSR = 28
[ 2222.230159] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL = 398
[ 2222.280142] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_xfer_complete
:timeout: 0
[ 2222.303171] i2c_eg20t 0000:02:0c.2: pch_i2c_stop :I2CCTL = 3b8
[ 2222.303202] at24 0-0050: read 128@0 --> -5 (1922303)

I looks like I am running in timeouts.

--
Christian Gmeiner, MSc
