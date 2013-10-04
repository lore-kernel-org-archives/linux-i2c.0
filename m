From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH v2 2/3] i2c: xilinx: Set tx direction in write operation
Date: Fri, 04 Oct 2013 15:38:01 +0200
Message-ID: <524EC4B9.7000202@monstr.eu>
References: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1380550490.git.michal.simek@xilinx.com> <57a4f5352ce6f03bde7aafe8b880f91b52994379.1380550490.git.michal.simek@xilinx.com> <20131004054636.GC3194@katana> <524E902D.8030809@monstr.eu> <20131004115517.GA2994@katana> <524EB090.2070708@metafoo.de> <524EBDF6.1070605@monstr.eu> <524EC4DC.1020708@metafoo.de>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="92qlV6EmdIdkOk0U6kKAV5KMilO5dC16L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524EC4DC.1020708-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kedareswara rao Appana <appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, "Steven A. Falco" <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--92qlV6EmdIdkOk0U6kKAV5KMilO5dC16L
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/04/2013 03:38 PM, Lars-Peter Clausen wrote:
> On 10/04/2013 03:09 PM, Michal Simek wrote:
>>
>>
>> On 10/04/2013 02:12 PM, Lars-Peter Clausen wrote:
>>> On 10/04/2013 01:55 PM, Wolfram Sang wrote:
>>>> On Fri, Oct 04, 2013 at 11:53:49AM +0200, Michal Simek wrote:
>>>>> On 10/04/2013 07:46 AM, Wolfram Sang wrote:
>>>>>>
>>>>>>> +	cr =3D xiic_getreg32(i2c, XIIC_CR_REG_OFFSET);
>>>>>>> +	cr |=3D XIIC_CR_DIR_IS_TX_MASK;
>>>>>>> +	xiic_setreg32(i2c, XIIC_CR_REG_OFFSET, cr);
>>>>>>> +
>>>>>>
>>>>>> Is there no need to clear the bit again when receiving?
>>>>>
>>>>> This bit is cleared in xiic_xfer() -> xiic_start_xfer() ->xiic_rein=
it()
>>>>>
>>>>> xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, XIIC_CR_TX_FIFO_RESET_MASK);
>>>>
>>>> A bit implicit, but OK.
>>>>
>>>>>> And did
>>>>>> transferring ever work if this bit was never set before?
>>>>>
>>>>> I really don't know. We have switched from old driver to this new m=
ainline one
>>>>> and based on our eeprom testing we have found that this bit hasn't =
been setup properly.
>>>>>
>>>>> It is described here.
>>>>> http://www.xilinx.com/support/documentation/ip_documentation/axi_ii=
c/v1_02_a/axi_iic_ds756.pdf
>>>>> page 28 - step 3.
>>>>>
>>>>> IIC Master Transmitter with a Repeated Start
>>>>> 1. Write the IIC device address to the TX_FIFO.
>>>>> 2. Write data to TX_FIFO.
>>>>> 3. Write to Control Register (CR) to set MSMS =3D 1 and TX =3D 1.
>>>>> 4. Continue writing data to TX_FIFO.
>>>>> 5. Wait for transmit FIFO empty interrupt. This implies the IIC has=
 throttled the bus.
>>>>> 6. Write to CR to set RSTA =3D 1.
>>>>
>>>> Repeated start is not happening in the driver as well, or am I
>>>> overlooking something?
>>>>
>>>>> 7. Write IIC device address to TX_FIFO.
>>>>> 8. Write all data except last byte to TX_FIFO.
>>>>> 9. Wait for transmit FIFO empty interrupt. This implies the IIC has=
 throttled the bus.
>>>>> 10. Write to CR to set MSMS =3D 0. The IIC generates a stop conditi=
on at the end of the last byte.
>>>>> 11. Write last byte of data to TX_FIFO.
>>>>
>>>> CCing more people who worked on the driver in the past and might hav=
e
>>>> experiences
>>>
>>> The current version works fine here. The driver uses whats described =
in the
>>> datasheet as "dynamic controller logic flow" and not the "standard
>>> controller logic flow". The sequence Michal mentioned above is from t=
he
>>> "standard controller logic flow" section.
>>
>> Does this change break "dynamic controller logic flow"?
>=20
> Not sure, but I would assume that the bit is ignored in this mode. But =
I
> don't think the patch should be applied since this step is not in the
> sequence of steps that should be done.

Kedar: Can you please look at both these modes and provide feedback?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--92qlV6EmdIdkOk0U6kKAV5KMilO5dC16L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJOxLkACgkQykllyylKDCG3RwCffeoOTzjdHB+3ujMXj4RcwANm
/UQAnAv5E+XTXF0wUPrPz9H6UQFBG1W4
=//BY
-----END PGP SIGNATURE-----

--92qlV6EmdIdkOk0U6kKAV5KMilO5dC16L--
