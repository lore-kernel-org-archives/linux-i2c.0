From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: Re: Problems with i2c_eg20t
Date: Tue, 18 Oct 2011 21:22:50 +0900
Message-ID: <4E9D6F9A.2060406@dsn.lapis-semi.com>
References: <CAH9NwWdogRey=hmzjebP9qhX5iOw3rTzdyt2fTWq5C4Z31t=cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAH9NwWdogRey=hmzjebP9qhX5iOw3rTzdyt2fTWq5C4Z31t=cA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

(2011/10/18 20:16), Christian Gmeiner wrote:

Hi, Christian

> Hi all
>
> I am using a 3.0.7 linux kernel with "[PATCH x/7 v4] i2c-eg20t: ..."
> from 12. October on top of
> it.
>
> ...
> ...
> [    1.439115] i2c_eg20t 0000:02:0c.2: pch_i2c_probe :Entered.
> [    1.439163] i2c_eg20t 0000:02:0c.2: PCI INT C ->  GSI 18 (level,
> low) ->  IRQ 18
> [    1.439602] i2c-dev: adapter [i2c_eg20t] registered as minor 0
> [    1.439738] i2c i2c-0: adapter [i2c_eg20t] registered
> [    1.460041] i2c_eg20t 0000:02:0c.2: pch_i2c_init :I2CCTL=380
> pch_i2cbc=fc0 pch_i2ctmr=186a Enable interrupts
> [    1.460097] i2c_eg20t 0000:02:0c.2: pch_i2c_probe :returns 0.
> ...
> ...
> [    2.098641] i2c 0-0050: uevent
> [    2.098823] at24 0-0050: probe
> [    2.098874] i2c 0-0051: uevent
> [    2.099070] dummy 0-0051: probe
> [    2.099084] i2c i2c-0: client [dummy] registered with bus id 0-0051
> [    2.099099] at24 0-0050: 512 byte 24c04 EEPROM, writable, 16 bytes/write
> [    2.099130] i2c i2c-0: master_xfer[0] W, addr=0x50, len=1
> [    2.099140] i2c i2c-0: master_xfer[1] R, addr=0x50, len=24
> [    2.099151] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
> :adap->p_adapter_info->pch_i2c_suspended is 0
> [    2.099161] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
> I2C_MODE_SEL :flag= 0x0
> [    2.099171] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invoking pch_i2c_writebytes
> [    2.099187] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL =
> 390 msgs->len = 1
> [    2.099202] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL = 390
> [    2.099559] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
> [    2.099586] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writing 0
> to Data register
> [    2.099872] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
> [    2.099903] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :I2CCTL = 3b0
> [    2.099915] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :return=1
> [    2.101095] i2c i2c-0: master_xfer[0] W, addr=0x50, len=1
> [    2.101107] i2c i2c-0: master_xfer[1] R, addr=0x50, len=24
> [    2.101118] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
> :adap->p_adapter_info->pch_i2c_suspended is 0
> [    2.101128] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
> I2C_MODE_SEL :flag= 0x0
> [    2.101138] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invoking pch_i2c_writebytes
> [    2.101153] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL =
> 3b4 msgs->len = 1
> [    2.122099] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_bus_idle :I2CSR = 28
> [    2.122116] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_bus_idle
> :pch_i2c_wait_for_bus_idle: Timeout Error.return-62
> [    2.143103] i2c_eg20t 0000:02:0c.2: pch_i2c_init :I2CCTL=380
> pch_i2cbc=fc0 pch_i2ctmr=186a Enable interrupts
> [    2.145097] i2c i2c-0: master_xfer[0] W, addr=0x50, len=1
> [    2.145112] i2c i2c-0: master_xfer[1] R, addr=0x50, len=24
> [    2.145124] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
> :adap->p_adapter_info->pch_i2c_suspended is 0
> [    2.145135] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
> I2C_MODE_SEL :flag= 0x0
> [    2.145145] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invoking pch_i2c_writebytes
> [    2.145160] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL =
> 390 msgs->len = 1
> [    2.145174] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL = 390
> [    2.145530] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
> [    2.145556] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writing 0
> to Data register
> [    2.145843] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
> [    2.145874] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :I2CCTL = 3b0
> [    2.145886] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :return=1
> [    2.147055] failed to read eeprom
>
> Any hints? Btw. the eg20t i2c driver works much better with the patch
> series from 12. October.
>

We tested again for I2C EEPROM access using Linux-3.1.0-rc9.
As a result, the test is OK.

Let me know how to do your test ?

-- 
tomoya
ROHM Co., Ltd.
