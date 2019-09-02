From: <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH v3 5/9] i2c: at91: add support for digital filtering
Date: Mon, 2 Sep 2019 08:54:06 +0000
Message-ID: <d461426b-50ac-bf6c-79e0-71e17a63400e@microchip.com>
References: <1562678049-17581-1-git-send-email-eugen.hristev@microchip.com>
 <1562678049-17581-6-git-send-email-eugen.hristev@microchip.com>
 <20190831121308.GB1032@ninjato> <20190831121751.GC1032@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831121751.GC1032@ninjato>
Content-Language: en-US
Content-ID: <6F1F9E0097244B4784028B912D065ADD@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, pierre-yves.mordret@st.com, Ludovic.Desroches@microchip.com, robh+dt@kernel.org, linux-i2c@vger.kernel.org, peda@axentia.se, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 31.08.2019 15:17, Wolfram Sang wrote:
>=20
>>> +	dev->enable_dig_filt =3D of_property_read_bool(pdev->dev.of_node,
>>> +						     "i2c-dig-filter");
>>> +
>>
>> What do you think of the idea to introduce 'flags' to struct i2c_timings
>> and parse the bindings in the core, too? Then you'd have sth like:
>>
>> 	if (t->flags & I2C_TIMINGS_ANALOG_FILTER)
>>
>> Would that be useful for you?
>=20
> Forgot to say, we can also implement this incrementally to make sure
> your patches land in 5.4 in case you are currently busy with sth else.
>=20

Hi Wolfram,

Your idea looks good but I would prefer to have it as a separate=20
enhancement patch, after this series gets in.
As things are now, this series/patches do just the filtering part. We=20
can then move all the optional 'flags' as another change.
So yes, we can do this incrementally.

Thanks !
Eugen

>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
