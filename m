From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Problems with i2c_eg20t
Date: Wed, 19 Oct 2011 08:44:00 +0200
Message-ID: <CAH9NwWcDS=Os6efNU+xvJBJPzC5iRLvEffvSe-yvPhMiKLtX3A@mail.gmail.com>
References: <CAH9NwWdogRey=hmzjebP9qhX5iOw3rTzdyt2fTWq5C4Z31t=cA@mail.gmail.com>
 <4E9D6F9A.2060406@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E9D6F9A.2060406-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2011/10/18 Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>:
> (2011/10/18 20:16), Christian Gmeiner wrote:
>
> Hi, Christian
>
>> Hi all
>>
>> I am using a 3.0.7 linux kernel with "[PATCH x/7 v4] i2c-eg20t: ..."
>> from 12. October on top of
>> it.
>>
>> ...
>> ...
>> [ =C2=A0 =C2=A01.439115] i2c_eg20t 0000:02:0c.2: pch_i2c_probe :Ente=
red.
>> [ =C2=A0 =C2=A01.439163] i2c_eg20t 0000:02:0c.2: PCI INT C -> =C2=A0=
GSI 18 (level,
>> low) -> =C2=A0IRQ 18
>> [ =C2=A0 =C2=A01.439602] i2c-dev: adapter [i2c_eg20t] registered as =
minor 0
>> [ =C2=A0 =C2=A01.439738] i2c i2c-0: adapter [i2c_eg20t] registered
>> [ =C2=A0 =C2=A01.460041] i2c_eg20t 0000:02:0c.2: pch_i2c_init :I2CCT=
L=3D380
>> pch_i2cbc=3Dfc0 pch_i2ctmr=3D186a Enable interrupts
>> [ =C2=A0 =C2=A01.460097] i2c_eg20t 0000:02:0c.2: pch_i2c_probe :retu=
rns 0.
>> ...
>> ...
>> [ =C2=A0 =C2=A02.098641] i2c 0-0050: uevent
>> [ =C2=A0 =C2=A02.098823] at24 0-0050: probe
>> [ =C2=A0 =C2=A02.098874] i2c 0-0051: uevent
>> [ =C2=A0 =C2=A02.099070] dummy 0-0051: probe
>> [ =C2=A0 =C2=A02.099084] i2c i2c-0: client [dummy] registered with b=
us id 0-0051
>> [ =C2=A0 =C2=A02.099099] at24 0-0050: 512 byte 24c04 EEPROM, writabl=
e, 16
>> bytes/write
>> [ =C2=A0 =C2=A02.099130] i2c i2c-0: master_xfer[0] W, addr=3D0x50, l=
en=3D1
>> [ =C2=A0 =C2=A02.099140] i2c i2c-0: master_xfer[1] R, addr=3D0x50, l=
en=3D24
>> [ =C2=A0 =C2=A02.099151] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>> :adap->p_adapter_info->pch_i2c_suspended is 0
>> [ =C2=A0 =C2=A02.099161] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After=
 invoking
>> I2C_MODE_SEL :flag=3D 0x0
>> [ =C2=A0 =C2=A02.099171] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invok=
ing
>> pch_i2c_writebytes
>> [ =C2=A0 =C2=A02.099187] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes =
:I2CCTL =3D
>> 390 msgs->len =3D 1
>> [ =C2=A0 =C2=A02.099202] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CC=
TL =3D 390
>> [ =C2=A0 =C2=A02.099559] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2C=
SR =3D 28
>> [ =C2=A0 =C2=A02.099586] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes =
:writing 0
>> to Data register
>> [ =C2=A0 =C2=A02.099872] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2C=
SR =3D 28
>> [ =C2=A0 =C2=A02.099903] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :I=
2CCTL =3D 3b0
>> [ =C2=A0 =C2=A02.099915] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes =
:return=3D1
>> [ =C2=A0 =C2=A02.101095] i2c i2c-0: master_xfer[0] W, addr=3D0x50, l=
en=3D1
>> [ =C2=A0 =C2=A02.101107] i2c i2c-0: master_xfer[1] R, addr=3D0x50, l=
en=3D24
>> [ =C2=A0 =C2=A02.101118] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>> :adap->p_adapter_info->pch_i2c_suspended is 0
>> [ =C2=A0 =C2=A02.101128] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After=
 invoking
>> I2C_MODE_SEL :flag=3D 0x0
>> [ =C2=A0 =C2=A02.101138] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invok=
ing
>> pch_i2c_writebytes
>> [ =C2=A0 =C2=A02.101153] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes =
:I2CCTL =3D
>> 3b4 msgs->len =3D 1
>> [ =C2=A0 =C2=A02.122099] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_bu=
s_idle :I2CSR =3D
>> 28
>> [ =C2=A0 =C2=A02.122116] i2c_eg20t 0000:02:0c.2: pch_i2c_wait_for_bu=
s_idle
>> :pch_i2c_wait_for_bus_idle: Timeout Error.return-62
>> [ =C2=A0 =C2=A02.143103] i2c_eg20t 0000:02:0c.2: pch_i2c_init :I2CCT=
L=3D380
>> pch_i2cbc=3Dfc0 pch_i2ctmr=3D186a Enable interrupts
>> [ =C2=A0 =C2=A02.145097] i2c i2c-0: master_xfer[0] W, addr=3D0x50, l=
en=3D1
>> [ =C2=A0 =C2=A02.145112] i2c i2c-0: master_xfer[1] R, addr=3D0x50, l=
en=3D24
>> [ =C2=A0 =C2=A02.145124] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
>> :adap->p_adapter_info->pch_i2c_suspended is 0
>> [ =C2=A0 =C2=A02.145135] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After=
 invoking
>> I2C_MODE_SEL :flag=3D 0x0
>> [ =C2=A0 =C2=A02.145145] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :invok=
ing
>> pch_i2c_writebytes
>> [ =C2=A0 =C2=A02.145160] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes =
:I2CCTL =3D
>> 390 msgs->len =3D 1
>> [ =C2=A0 =C2=A02.145174] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CC=
TL =3D 390
>> [ =C2=A0 =C2=A02.145530] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2C=
SR =3D 28
>> [ =C2=A0 =C2=A02.145556] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes =
:writing 0
>> to Data register
>> [ =C2=A0 =C2=A02.145843] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2C=
SR =3D 28
>> [ =C2=A0 =C2=A02.145874] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :I=
2CCTL =3D 3b0
>> [ =C2=A0 =C2=A02.145886] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes =
:return=3D1
>> [ =C2=A0 =C2=A02.147055] failed to read eeprom
>>
>> Any hints? Btw. the eg20t i2c driver works much better with the patc=
h
>> series from 12. October.
>>
>
> We tested again for I2C EEPROM access using Linux-3.1.0-rc9.
> As a result, the test is OK.
>
> Let me know how to do your test ?

02:0c.2 Serial bus controller [0c80]: Intel Corporation Platform
Controller Hub EG20T I2C Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 1: Memory at d0144000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [40] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: i2c_eg20t


Okay... now to the interesting part. I wrote a very simple driver,
which should read the content of the eeprom
and should export some informations via /proc. This works very well on
an other x86 based device, so
there should not be a problem in general.

Here are some parts of my driver:

/* technical description of our used EEPROM */
static struct at24_platform_data ot1300_eeprom_info =3D {
	.byte_len	=3D 512,
	.page_size	=3D 16,
	.flags		=3D 0,
	.setup		=3D eeprom_read,
};

static struct i2c_board_info ot1300_i2c_eeprom =3D {
	I2C_BOARD_INFO("24c04", 0x50),
	.platform_data	=3D &ot1300_eeprom_info,
};

int e6xx_init(void)
{
	struct i2c_adapter *i2c_adap;

	/* we use the integrated i2c adapter */
	i2c_adap =3D i2c_get_adapter(0);

	if (!i2c_adap) {
		printk(KERN_ERR "xxx: failed to get i2c adapter 0\n");
		return -EIO;
	}

	eeprom =3D  i2c_new_device(i2c_adap, &ot1300_i2c_eeprom);
}


What would be the next steps to fix my issues?

--
Christian Gmeiner, MSc
