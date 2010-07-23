From: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Single-wire Serial Bus Interface for Qualcomm MSM
 chipsets
Date: Fri, 23 Jul 2010 12:32:33 -0600
Message-ID: <4C49E041.8070009@codeaurora.org>
References: <1279734768-8436-1-git-send-email-kheitke@codeaurora.org> <4C496C58.1080806@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C496C58.1080806-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Daniel_Gl=F6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Daniel Gl=F6ckner wrote:
> On 07/21/2010 07:52 PM, Kenneth Heitke wrote:
>> Unlike I2C, SSBI is a point-to-point connection, and therefore there=
 is no
>> need to specify a slave device address. The SSBI implementation
>> overrides the slave device address to be a device register address
>> instead.  This restricts the client drivers from using the SMBus
>> communication APIs unless they update the address field (addr) of th=
e
>> i2c_client structure prior to every SMBus function call.
>=20
>=20
>> +static int
>> +i2c_ssbi_write_bytes(struct i2c_ssbi_dev *ssbi, struct i2c_msg *msg=
)
>> +{
>> +	int ret =3D 0;
>> +	u8 *buf =3D msg->buf;
>> +	u16 len =3D msg->len;
>> +	u16 addr =3D msg->addr;
>> +
>> +	if (ssbi->controller_type =3D=3D MSM_SBI_CTRL_SSBI2) {
>> +		u32 mode2 =3D readl(ssbi->base + SSBI2_MODE2);
>> +		writel(SSBI_MODE2_REG_ADDR_15_8(mode2, addr),
>> +				ssbi->base + SSBI2_MODE2);
>> +	}
>> +
>> +	while (len) {
>=20
> Where do you set the address if controller_type =3D=3D MSM_SBI_CTRL_S=
SBI?
>=20
>   Daniel
>=20
>=20

The SSBI_MODE2_REG_ADDR register contains the upper 8-bits of the=20
address which is only supported by SSBI 2.0.  The lower 8 address bits=20
are written as part of the SSBI_CMD_WRITE macro which is common for bot=
h=20
of the controller types.

--=20
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.
