From: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Still problems wit egt20 i2c driver
Date: Tue, 22 Nov 2011 19:52:57 +0900
Message-ID: <CANKRQniAsE-S_v15hRci8tXZpmaymL-7Sg=dyPxdnjGZm5=7fA@mail.gmail.com>
References: <CAH9NwWf-Dgme+SBR4vwrVux5C12nTTe5sJuCpusdw8LqeVD+xA@mail.gmail.com>
	<CANKRQnhPW3n6X29x1hrn+tpNapoi_d6Dk0zykQ8sNHioMC0K_A@mail.gmail.com>
	<CAH9NwWf9PpRN6zMp+TPkiRpwLvLZZ-ukiOBHGb22qaFaypn91A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAH9NwWf9PpRN6zMp+TPkiRpwLvLZZ-ukiOBHGb22qaFaypn91A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Christian,

Good news!

Except "[PATCH] i2c-eg20t: modified the setting of transfer rate",
all patches already accepted.
So, they will got into linux-3.3.

Thanks,

---
tomoya
ROHM Co., Ltd

2011/11/22 Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Hi Christian,
>>
>> I attached the latest our i2c-eg20t source file.
>> Is your source file the same as this?
>
> Hi,
>
> the file is the same... but I have some good news for you :) After
> hooking up an oszi
> to the i2c bus we found a problem with our custom hardware. It works
> now as required.
> Sorry for for all this noise. Whats the sate of your i2c patches? Wil=
l
> they go into v3.3?
> I am willing to add my signed off line if needed/wanted.
>
> thanks
> --
> Christian Gmeiner, MSc
>
>
>
> 2011/11/22 Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Hi Christian,
>>
>> I attached the latest our i2c-eg20t source file.
>> Is your source file the same as this?
>>
>> Regards,
>> ---
>> tomoya
>> ROHM Co., Ltd
>>
>> 2011/11/21 Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>> Hi all,
>>>
>>> I still have some problems with the egt20 i2c driver. I am running =
a
>>> 3.1.1 kernel with the following
>>> patches applied to it:
>>>
>>> * [PATCH 1/7 v4] i2c-eg20t: Fix bus-idle waiting issue -
>>> https://lkml.org/lkml/2011/10/12/3
>>> * [PATCH 2/7 v4] i2c-eg20t: Modify returned value s32 to long -
>>> https://lkml.org/lkml/2011/10/12/1
>>> * [PATCH 3/7 v2] i2c-eg20t: Fix 10bit access issue -
>>> https://lkml.org/lkml/2011/10/12/7
>>> * [PATCH 4/7 v4] i2c-eg20t: Separate error processing -
>>> https://lkml.org/lkml/2011/10/12/6
>>> * [PATCH 5/7 v4] i2c-eg20t: add stop sequence in case wait-event
>>> timeout occurs - https://lkml.org/lkml/2011/10/12/5
>>> * [PATCH 6/7 v4] i2c-eg20t: Fix flag setting issue -
>>> https://lkml.org/lkml/2011/10/12/2
>>> * [PATCH 7/7 v4] i2c-eg20t: Add initialize processing in case
>>> i2c-error occurs - https://lkml.org/lkml/2011/10/12/4
>>> * [PATCH] i2c-eg20t: modified the setting of transfer rate. -
>>> http://marc.info/?l=3Dlinux-i2c&m=3D131702145913299&w=3D2
>>>
>>> I have a PCA9555 (drivers/gpio/gpio-pca953x.c) at i2c addr 0x48.
>>>
>>> [ =A0 21.505138] pca953x 0-0048: probe
>>> [ =A0 21.505157] i2c i2c-0: master_xfer[0] W, addr=3D0x48, len=3D1
>>> [ =A0 21.505168] i2c i2c-0: master_xfer[1] R, addr=3D0x48, len=3D2
>>> [ =A0 21.505180] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>>> :adap->p_adapter_info->pch_i2c_suspended is 0
>>> [ =A0 21.505190] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoki=
ng
>>> I2C_MODE_SEL :flag=3D 0x0
>>> [ =A0 21.505206] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL=
 =3D
>>> 390 msgs->len =3D 1
>>> [ =A0 21.505220] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL =3D =
390
>>> [ =A0 21.505353] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.508667] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writin=
g 2
>>> to Data register
>>> [ =A0 21.508772] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.510043] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :I2CCTL =3D=
 3b0
>>> [ =A0 21.510058] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :return=
=3D1
>>> [ =A0 21.510068] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoki=
ng
>>> I2C_MODE_SEL :flag=3D 0x1
>>> [ =A0 21.510209] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.517833] i2c_eg20t 0000:02:0c.2: pch_i2c_sendack :I2CCTL =3D=
 3a0
>>> [ =A0 21.517962] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.517992] i2c_eg20t 0000:02:0c.2: pch_i2c_sendnack :I2CCTL =3D=
 3a0
>>> [ =A0 21.518114] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.518230] i2c_eg20t 0000:02:0c.2: pch_i2c_stop :I2CCTL =3D 3=
a8
>>> [ =A0 21.518251] i2c i2c-0: master_xfer[0] W, addr=3D0x48, len=3D1
>>> [ =A0 21.518261] i2c i2c-0: master_xfer[1] R, addr=3D0x48, len=3D2
>>> [ =A0 21.518271] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>>> :adap->p_adapter_info->pch_i2c_suspended is 0
>>> [ =A0 21.518281] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoki=
ng
>>> I2C_MODE_SEL :flag=3D 0x0
>>> [ =A0 21.518296] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL=
 =3D
>>> 398 msgs->len =3D 1
>>> [ =A0 21.518311] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL =3D =
398
>>> [ =A0 21.518442] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.520533] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writin=
g 6
>>> to Data register
>>> [ =A0 21.520627] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.520709] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :I2CCTL =3D=
 3b8
>>> [ =A0 21.520721] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :return=
=3D1
>>> [ =A0 21.520731] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoki=
ng
>>> I2C_MODE_SEL :flag=3D 0x1
>>> [ =A0 21.520868] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.522841] i2c_eg20t 0000:02:0c.2: pch_i2c_sendack :I2CCTL =3D=
 3a8
>>> [ =A0 21.522968] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.523533] i2c_eg20t 0000:02:0c.2: pch_i2c_sendnack :I2CCTL =3D=
 3a0
>>> [ =A0 21.523660] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.523785] i2c_eg20t 0000:02:0c.2: pch_i2c_stop :I2CCTL =3D 3=
a8
>>> [ =A0 21.523807] i2c i2c-0: master_xfer[0] W, addr=3D0x48, len=3D3
>>> [ =A0 21.523817] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>>> :adap->p_adapter_info->pch_i2c_suspended is 0
>>> [ =A0 21.523827] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoki=
ng
>>> I2C_MODE_SEL :flag=3D 0x0
>>> [ =A0 21.523842] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL=
 =3D
>>> 398 msgs->len =3D 3
>>> [ =A0 21.523856] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL =3D =
398
>>> [ =A0 21.523988] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.524570] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writin=
g 4
>>> to Data register
>>> [ =A0 21.524677] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.524791] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writin=
g 0
>>> to Data register
>>> [ =A0 21.524899] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
28
>>> [ =A0 21.524948] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writin=
g 0
>>> to Data register
>>> [ =A0 21.525056] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR =3D =
9
>>> [ =A0 21.525666] i2c_eg20t 0000:02:0c.2: pch_i2c_getack :return-71
>>> [ =A0 21.525746] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :Receiv=
e
>>> NACK for slave addresssetting
>>> [ =A0 21.525760] pca953x 0-0048: failed writing register
>>> [ =A0 21.525829] pca953x 0-0048: interrupt support not compiled in
>>> [ =A0 21.526029] i2c-core: driver [pca953x] registered
>>> [ =A0 21.526380] pca953x 0-0048: uevent
>>>
>>>
>>> What informations do you need to get this fixed?
>>>
>>> thanks
>>> --
>>> Christian Gmeiner, MSc
>>>
>>
>
