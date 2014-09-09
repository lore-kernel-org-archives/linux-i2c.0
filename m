From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mxs: fixed PIO NACK error instead of timeout
Date: Tue, 09 Sep 2014 17:05:24 +0200
Message-ID: <540F1734.6090700@elproma.com.pl>
References: <540DEFA6.9030600@elproma.com.pl> <201409091448.40115.marex@denx.de> <540EFC41.9070106@elproma.com.pl> <201409091559.24900.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201409091559.24900.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


W dniu 2014-09-09 15:59, Marek Vasut pisze:
> On Tuesday, September 09, 2014 at 03:10:25 PM, Janusz U=C5=BCycki wro=
te:
>> W dniu 2014-09-09 14:48, Marek Vasut pisze:
>>>>> Shouldn't this check be used only after the 'SELECT' command ?
>>>> It looks |||mxs_i2c_isr()| for DMA transfer does not differentiate
>>>> commands also
>>>> and does not mask irqs for each command.
>>>>
>>>> |STAT_GOT_A_NAK|  is a separate bit.|CTRL1_NO_SLAVE_ACK_IRQ can be=
 set
>>>>
>>>> both after SELECT and WRITE command. Should we differentiate?
>>> What about writes that take long time, will checking this bit not b=
reak
>>> them ? (like programming a slow eeprom or such)
>> No, master clock speed (SCL) decides here.
>> If slave does not confirm I2C address  (SELECT) using ACK
>> any timeout doesn't help.
> The SELECT case is OK in that aspect. But I was talking about WRITEs.
>
>> RUN bit is not deasserted.
>> The same thing is for WRITE cmd. Each byte has to be acked
>> otherwise STAT_GOT_A_NAK is set.
> OK
>
>> If it is too fast a slave has possibility to inform by setting SCL l=
ow.
> Do you mean clock stretching ?
Yes, I didn't notice it is the same.
>> However I haven't seen any driver which supports the method.
>>
>>>> |Checking CTRL1_NO_SLAVE_ACK_IRQ |bit for SELECT command will incr=
ease
>>>>
>>>> code size only
>>>> without special profit. Current PIO implementation also gathers al=
l
>>>> errors together and reads them on the end by
>>>> mxs_i2c_pio_check_error_state(). Probably
>>>> mxs_i2c_pio_check_error_state() call or
>>>> enabling interrupt masks for PIO could be better than
>>>> direct |CTRL1_NO_SLAVE_ACK_IRQ |bit checking for clear code.
>>>> It also could support multimaster for PIO (MASTER_LOSS).
>>> Actually, the PIO is explicitly IRQ-less and is used only for
>>> transferring very short amounts of data.
>> Yes but error service could be more common probably.
> Feel free to prepare a patch please!
On the moment the fix is enough for me. I did need i2cdetect to work.
I looked on 2.6.35 FSL BSP. There both DMA and PIO mode use status inte=
rrupt
and cmd_complete. It was changed to speed up?

best regards
Janusz
