From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH 01/10] i2c-mux: add common core data for every mux instance
Date: Tue, 05 Jan 2016 10:05:17 +0100
Message-ID: <568B874D.8020205@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se> <1451920215-29167-2-git-send-email-peda@lysator.liu.se> <568A919E.8040006@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568A919E.8040006@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On 2016-01-04 16:37, Guenter Roeck wrote:
> On 01/04/2016 07:10 AM, Peter Rosin wrote:
>> From: Peter Rosin <peda@axentia.se>
>>
>> The initial core mux structure starts off small with only the parent
>> adapter pointer, which all muxes have, and a priv pointer for mux
>> driver private data.
>>
>> Add i2c_mux_alloc function to unify the creation of a mux.
>>
>> Where appropriate, pass around the mux core structure instead of the
>> parent adapter or the driver private data.
>>
>> Remove the parent adapter pointer from the driver private data for all
>> mux drivers.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>   drivers/i2c/i2c-mux.c                      | 35 ++++++++++++++++++++++++-----
>>   drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 24 +++++++++++---------
>>   drivers/i2c/muxes/i2c-mux-gpio.c           | 20 +++++++++--------
>>   drivers/i2c/muxes/i2c-mux-pca9541.c        | 36 ++++++++++++++++--------------
>>   drivers/i2c/muxes/i2c-mux-pca954x.c        | 22 +++++++++++++-----
>>   drivers/i2c/muxes/i2c-mux-pinctrl.c        | 24 +++++++++++---------
>>   drivers/i2c/muxes/i2c-mux-reg.c            | 25 ++++++++++++---------
>>   include/linux/i2c-mux.h                    | 14 +++++++++++-
>>   8 files changed, 129 insertions(+), 71 deletions(-)
>>

*snip*

>> +struct i2c_mux_core *i2c_mux_alloc(struct device *dev, int sizeof_priv)
>> +{
>> +    struct i2c_mux_core *muxc;
>> +
>> +    muxc = devm_kzalloc(dev, sizeof(*muxc), GFP_KERNEL);
>> +    if (!muxc)
>> +        return NULL;
>> +    if (sizeof_priv) {
>> +        muxc->priv = devm_kzalloc(dev, sizeof_priv, GFP_KERNEL);
>> +        if (!muxc->priv)
>> +            goto fail;
>> +    }
> 
> Why not just allocate sizeof(*muxc) + sizeof_priv in a single operation
> and then assign muxc->priv to muxc + 1 if sizeof_priv > 0 ?

Why indeed, good suggestion.

*snip*

>> @@ -134,13 +134,14 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
>>           return -EINVAL;
>>       }
>>
>> -    arb = devm_kzalloc(dev, sizeof(*arb), GFP_KERNEL);
>> -    if (!arb) {
>> -        dev_err(dev, "Cannot allocate i2c_arbitrator_data\n");
>> +    muxc = i2c_mux_alloc(dev, sizeof(*arb));
>> +    if (!muxc) {
>> +        dev_err(dev, "Cannot allocate i2c_mux_core structure\n");
> 
> Unnecessary error message.
> 

Right, I'll remove that (and the others just like it).

I'll see if I can cook up a v2 that also converts the i2c muxes elsewhere in
drivers/ that I wasn't aware of.

Cheers,
Peter
