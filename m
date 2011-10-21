From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Problems with i2c_eg20t
Date: Fri, 21 Oct 2011 09:23:55 +0200
Message-ID: <CAH9NwWeMbE-sYx5Xms+yO1a_H9Q6bDMMyEo2PAvhHu5vsf--7A@mail.gmail.com>
References: <CAH9NwWdogRey=hmzjebP9qhX5iOw3rTzdyt2fTWq5C4Z31t=cA@mail.gmail.com>
 <4E9D6F9A.2060406@dsn.lapis-semi.com> <20111020232701.GK19115@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111020232701.GK19115-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

2011/10/21 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:
> On Tue, Oct 18, 2011 at 09:22:50PM +0900, Tomoya MORINAGA wrote:
>> (2011/10/18 20:16), Christian Gmeiner wrote:
>>
>> Hi, Christian
>>
>>> Hi all
>>>
>>> I am using a 3.0.7 linux kernel with "[PATCH x/7 v4] i2c-eg20t: ...=
"
>>> from 12. October on top of
>>> it.
>
> Shall I leave v4 on the list of things to submit?

The v4 patch series improves the driver... before it I was not even
possible to run i2cdetect.
Now with v4 applied I can see all devices which are connected to the
eg20t i2c adapter.
So it would be fine to if you could merge v4 into upstream.

>
>>> ...
>>> ...
>>> [ =C2=A0 =C2=A01.439115] i2c_eg20t 0000:02:0c.2: pch_i2c_probe :Ent=
ered.
>>> [ =C2=A0 =C2=A01.439163] i2c_eg20t 0000:02:0c.2: PCI INT C -> =C2=A0=
GSI 18 (level,
>>> low) -> =C2=A0IRQ 18
>>> [ =C2=A0 =C2=A01.439602] i2c-dev: adapter [i2c_eg20t] registered as=
 minor 0
>>> [ =C2=A0 =C2=A01.439738] i2c i2c-0: adapter [i2c_eg20t] registered
>>> [ =C2=A0 =C2=A01.460041] i2c_eg20t 0000:02:0c.2: pch_i2c_init :I2CC=
TL=3D380
>>> pch_i2cbc=3Dfc0 pch_i2ctmr=3D186a Enable interrupts
>>> [ =C2=A0 =C2=A01.460097] i2c_eg20t 0000:02:0c.2: pch_i2c_probe :ret=
urns 0.
>>> ...
>>> ...
>>> [ =C2=A0 =C2=A02.098641] i2c 0-0050: uevent
>>> [ =C2=A0 =C2=A02.098823] at24 0-0050: probe
>>> [ =C2=A0 =C2=A02.098874] i2c 0-0051: uevent
>>> [ =C2=A0 =C2=A02.099070] dummy 0-0051: probe
>>> [ =C2=A0 =C2=A02.099084] i2c i2c-0: client [dummy] registered with =
bus id 0-0051
>>> [ =C2=A0 =C2=A02.099099] at24 0-0050: 512 byte 24c04 EEPROM, writab=
le, 16 bytes/write
>>> [ =C2=A0 =C2=A02.099130] i2c i2c-0: master_xfer[0] W, addr=3D0x50, =
len=3D1
>>> [ =C2=A0 =C2=A02.099140] i2c i2c-0: master_xfer[1] R, addr=3D0x50, =
len=3D24
>>> [ =C2=A0 =C2=A02.099151] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>>> :adap->p_adapter_info->pch_i2c_suspended is 0
>>> [ =C2=A0 =C2=A02.099161] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :Afte=
r invoking
>>> I2C_MODE_SEL :flag=3D 0x0
>>> [ =C2=A0 =C2=A02.099171] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invo=
king pch_i2c_writebytes
>>> [ =C2=A0 =C2=A02.099187] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes=
 :I2CCTL =3D
>>> 390 msgs->len =3D 1
>>> [ =C2=A0 =C2=A02.099202] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2C=
CTL =3D 390
>>> [ =C2=A0 =C2=A02.099559] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2=
CSR =3D 28
>>> [ =C2=A0 =C2=A02.099586] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes=
 :writing 0
>>> to Data register
>>> [ =C2=A0 =C2=A02.099872] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2=
CSR =3D 28
>>> [ =C2=A0 =C2=A02.099903] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :=
I2CCTL =3D 3b0
>>> [ =C2=A0 =C2=A02.099915] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes=
 :return=3D1
>>> [ =C2=A0 =C2=A02.101095] i2c i2c-0: master_xfer[0] W, addr=3D0x50, =
len=3D1
>>> [ =C2=A0 =C2=A02.101107] i2c i2c-0: master_xfer[1] R, addr=3D0x50, =
len=3D24
>>> [ =C2=A0 =C2=A02.101118] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>>> :adap->p_adapter_info->pch_i2c_suspended is 0
>>> [ =C2=A0 =C2=A02.101128] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :Afte=
r invoking
>>> I2C_MODE_SEL :flag=3D 0x0
>>> [ =C2=A0 =C2=A02.101138] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invo=
king pch_i2c_writebytes
>>> [ =C2=A0 =C2=A02.101153] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes=
 :I2CCTL =3D
>>> 3b4 msgs->len =3D 1
>>> [ =C2=A0 =C2=A02.122099] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_b=
us_idle :I2CSR =3D 28
>>> [ =C2=A0 =C2=A02.122116] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_b=
us_idle
>>> :pch_i2c_wait_for_bus_idle: Timeout Error.return-62
>>> [ =C2=A0 =C2=A02.143103] i2c_eg20t 0000:02:0c.2: pch_i2c_init :I2CC=
TL=3D380
>>> pch_i2cbc=3Dfc0 pch_i2ctmr=3D186a Enable interrupts
>>> [ =C2=A0 =C2=A02.145097] i2c i2c-0: master_xfer[0] W, addr=3D0x50, =
len=3D1
>>> [ =C2=A0 =C2=A02.145112] i2c i2c-0: master_xfer[1] R, addr=3D0x50, =
len=3D24
>>> [ =C2=A0 =C2=A02.145124] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>>> :adap->p_adapter_info->pch_i2c_suspended is 0
>>> [ =C2=A0 =C2=A02.145135] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :Afte=
r invoking
>>> I2C_MODE_SEL :flag=3D 0x0
>>> [ =C2=A0 =C2=A02.145145] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invo=
king pch_i2c_writebytes
>>> [ =C2=A0 =C2=A02.145160] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes=
 :I2CCTL =3D
>>> 390 msgs->len =3D 1
>>> [ =C2=A0 =C2=A02.145174] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2C=
CTL =3D 390
>>> [ =C2=A0 =C2=A02.145530] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2=
CSR =3D 28
>>> [ =C2=A0 =C2=A02.145556] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes=
 :writing 0
>>> to Data register
>>> [ =C2=A0 =C2=A02.145843] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2=
CSR =3D 28
>>> [ =C2=A0 =C2=A02.145874] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :=
I2CCTL =3D 3b0
>>> [ =C2=A0 =C2=A02.145886] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes=
 :return=3D1
>>> [ =C2=A0 =C2=A02.147055] failed to read eeprom
>>>
>>> Any hints? Btw. the eg20t i2c driver works much better with the pat=
ch
>>> series from 12. October.
>>>
>>
>> We tested again for I2C EEPROM access using Linux-3.1.0-rc9.
>> As a result, the test is OK.
>>
>> Let me know how to do your test ?
>>
>> --
>> tomoya
>> ROHM Co., Ltd.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>

Greets
--
Christian Gmeiner, MSc
