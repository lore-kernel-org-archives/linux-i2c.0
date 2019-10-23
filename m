From: <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH v5 0/9] i2c: add support for filters
Date: Wed, 23 Oct 2019 11:01:40 +0000
Message-ID: <c1f5c3f0-860e-e86a-5658-49e2100225a9@microchip.com>
References: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
 <c17182ac-67dd-d11f-5daf-066bf446b969@microchip.com>
 <20191021140515.GC26782@ninjato>
 <f5bd0c1f-9a72-6661-146b-ef5de77e31ff@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f5bd0c1f-9a72-6661-146b-ef5de77e31ff@axentia.se>
Content-Language: en-US
Content-ID: <B3A0FB639092C0468D6D620D672A992D@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se, wsa@the-dreams.de
Cc: mark.rutland@arm.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com, robh+dt@kernel.org, Nicolas.Ferre@microchip.com
List-Id: linux-i2c@vger.kernel.org



On 21.10.2019 18:23, Peter Rosin wrote:

>=20
> On 2019-10-21 16:05, Wolfram Sang wrote:
>> On Mon, Oct 07, 2019 at 07:53:21AM +0000, Eugen.Hristev@microchip.com wr=
ote:
>>>
>>>
>>> On 11.09.2019 11:24, Eugen Hristev - M18282 wrote:
>>>> From: Eugen Hristev <eugen.hristev@microchip.com>
>>>>
>>>> Hello,
>>>>
>>>> This series adds support for analog and digital filters for i2c contro=
llers
>>>>
>>>> This series is based on the series:
>>>> [PATCH v2 0/9] i2c: at91: filters support for at91 SoCs
>>>> and later
>>>> [PATCH v4 0/9] i2c: add support for filters
>>>> and enhanced to add the bindings for all controllers plus an extra bin=
dings
>>>> for the width of the spikes in nanoseconds (digital filters) and cut-o=
ff
>>>> frequency (analog filters)
>>>>
>>>> First, bindings are created for
>>>> 'i2c-analog-filter'
>>>> 'i2c-digital-filter'
>>>> 'i2c-digital-filter-width-ns'
>>>> 'i2c-analog-filter-cutoff-frequency'
>>>>
>>>> The support is added in the i2c core to retrieve filter width/cutoff f=
requency
>>>> and add it to the timings structure.
>>>> Next, the at91 driver is enhanced for supporting digital filter, advan=
ced
>>>> digital filter (with selectable spike width) and the analog filter.
>>>>
>>>> Finally the device tree for two boards are modified to make use of the
>>>> new properties.
>>>>
>>>> This series is the result of the comments on the ML in the direction
>>>> requested: to make the bindings globally available for i2c drivers.
>>>>
>>>> Changes in v5:
>>>> - renamed i2c-filter-width-ns to i2c-digital-filter-width-ns as this
>>>> is applicable only to digital filter
>>>> - created new binding i2c-digital-filter-width-ns for analog filters.
>>>
>>> Hello Wolfram and Peter,
>>>
>>> Are you happy with the changes in this version? I haven't heard from yo=
u
>>> since this latest update.
>>> I am interested to know if anymore changes are required or maybe we can
>>> move further with this support.
>>
>> So, I had a look now and I am happy. I will give Peter one more day to
>> comment, otherwise I'll apply it tomorrow.
>=20
> I had another read-through and only found one nit which is in a separate
> message. You can add
>=20
> Reviewed-by: Peter Rosin <peda@axentia.se>
>=20
> for the whole series.

Hello Peter and Wolfram,

Thanks for reviewing.
Send another version of the patch with the nit ?
Or how would you like to proceed ?

Thanks,
Eugen

>=20
> Cheers,
> Peter
>=20
>> Thanks for your patience and keeping at it!
>>
>=20
>=20
>=20
