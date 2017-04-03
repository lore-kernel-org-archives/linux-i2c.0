From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c/muxes/i2c-mux-ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Mon, 3 Apr 2017 16:20:53 +0200
Message-ID: <dcc59f26-6dec-dbf1-22d9-b681daf788a2@axentia.se>
References: <1490782541-7832-1-git-send-email-michael.hennerich@analog.com>
 <0d4c068f-d909-64be-421d-4500da7ebd4c@axentia.se>
 <3c61461e-493c-4562-90c9-f30766591de2@axentia.se>
 <f871f082-3acd-7a28-25c7-dd77d8286ae6@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <f871f082-3acd-7a28-25c7-dd77d8286ae6@analog.com>
Sender: linux-gpio-owner@vger.kernel.org
To: michael.hennerich@analog.com, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2017-04-03 15:36, Michael Hennerich wrote:
> On 03.04.2017 14:03, Peter Rosin wrote:
>> On 2017-03-31 17:29, Peter Rosin wrote:
>>> Hi!
>>>
>>> Sorry for my incremental reviewing...
>>>
>>
>> Another incremental...
>>
>>> On 2017-03-29 12:15, michael.hennerich@analog.com wrote:
>>>> +
>>>> +	/* Now create an adapter for each channel */
>>>> +	for (num = 0; num < data->chip->nchans; num++) {
>>>> +		ret = i2c_mux_add_adapter(muxc, 0, num, 0);
>>>> +		if (ret) {
>>>> +			dev_err(&client->dev,
>>>> +				"failed to register multiplexed adapter %d\n",
>>>> +				num);
>>
>> Just a heads up, I submitted a series to remove a bunch of dev_err calls
>> when i2c_mux_add_adapter fails. See https://lkml.org/lkml/2017/4/3/115
>>
>> You can remove this one as well.
>>
>> And please use a subject of the form:
>> i2c: mux: ltc4306: <message>
> ok - no problem.

You managed to drop the spaces after the new colons in the subject.

And maybe there is a problem, because I don't see any reaction to any of
the review comments I made in https://lkml.org/lkml/2017/3/31/525

Was that on purpose? Sure, the gpio "jury" is still out on the bigger
question so maybe you're waiting for that, but there were a few nitpicks
as well. Anyway, sorry again for failing to compile all comments up front.

> I sent out a new patch. Per Rob's request, I split out the dt-bindings 
> into a separate patch.

Thanks. I think(?) it is customary to have the bindings first, and then
implement that "specification" in followup patches. No big deal though...

Cheers,
peda

