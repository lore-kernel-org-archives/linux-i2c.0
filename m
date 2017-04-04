From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] i2c/muxes/i2c-mux-ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Tue, 4 Apr 2017 08:32:22 +0200
Message-ID: <5a320a13-1d61-a643-fc40-791b4d588d9a@analog.com>
References: <1490782541-7832-1-git-send-email-michael.hennerich@analog.com>
 <0d4c068f-d909-64be-421d-4500da7ebd4c@axentia.se>
 <3c61461e-493c-4562-90c9-f30766591de2@axentia.se>
 <f871f082-3acd-7a28-25c7-dd77d8286ae6@analog.com>
 <dcc59f26-6dec-dbf1-22d9-b681daf788a2@axentia.se>
Reply-To: <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dcc59f26-6dec-dbf1-22d9-b681daf788a2-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03.04.2017 16:20, Peter Rosin wrote:
> On 2017-04-03 15:36, Michael Hennerich wrote:
>> On 03.04.2017 14:03, Peter Rosin wrote:
>>> On 2017-03-31 17:29, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> Sorry for my incremental reviewing...
>>>>
>>>
>>> Another incremental...
>>>
>>>> On 2017-03-29 12:15, michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org wrote:
>>>>> +
>>>>> +	/* Now create an adapter for each channel */
>>>>> +	for (num = 0; num < data->chip->nchans; num++) {
>>>>> +		ret = i2c_mux_add_adapter(muxc, 0, num, 0);
>>>>> +		if (ret) {
>>>>> +			dev_err(&client->dev,
>>>>> +				"failed to register multiplexed adapter %d\n",
>>>>> +				num);
>>>
>>> Just a heads up, I submitted a series to remove a bunch of dev_err calls
>>> when i2c_mux_add_adapter fails. See https://lkml.org/lkml/2017/4/3/115
>>>
>>> You can remove this one as well.
>>>
>>> And please use a subject of the form:
>>> i2c: mux: ltc4306: <message>
>> ok - no problem.
>
> You managed to drop the spaces after the new colons in the subject.
>
> And maybe there is a problem, because I don't see any reaction to any of
> the review comments I made in https://lkml.org/lkml/2017/3/31/525
>
> Was that on purpose? Sure, the gpio "jury" is still out on the bigger
> question so maybe you're waiting for that, but there were a few nitpicks
> as well. Anyway, sorry again for failing to compile all comments up front.

Hi Peter,

sorry - this was not on purpose. I simply missed your second to last 
incremental review. I fix the subject now finally.

Thanks for your patience.

>
>> I sent out a new patch. Per Rob's request, I split out the dt-bindings
>> into a separate patch.
>
> Thanks. I think(?) it is customary to have the bindings first, and then
> implement that "specification" in followup patches. No big deal though...
>
> Cheers,
> peda
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
