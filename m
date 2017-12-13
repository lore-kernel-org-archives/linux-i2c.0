From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3] i2c: Add support for NXP PCA984x family.
Date: Wed, 13 Dec 2017 10:39:14 +0100
Message-ID: <f02a4d93-fe18-c913-bdaf-e2c9f4ab22eb@axentia.se>
References: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
 <20171211165811.5806-1-adrian.fiergolski@cern.ch>
 <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
 <2acdb52a-c669-631d-2ef2-ab0da2899e00@cern.ch>
 <cb42475b-eacb-d059-2ee5-f2a57cf29159@axentia.se>
 <c7842a62-980d-b220-aa42-51cbb5398c5b@cern.ch>
 <5cbfd97a-146b-8851-c63a-f2f60da33f5b@axentia.se>
 <f170bbe5-7acb-e133-23f6-62690dd61891@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0110.outbound.protection.outlook.com ([104.47.2.110]:45281
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751479AbdLMJjW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Dec 2017 04:39:22 -0500
In-Reply-To: <f170bbe5-7acb-e133-23f6-62690dd61891@cern.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>, linux-i2c@vger.kernel.org

On 2017-12-13 09:47, Adrian Fiergolski wrote:
> On 12.12.2017 at 20:03, Peter Rosin wrote:
>> [Adding Wolfram]
>>
>> On 2017-12-12 18:14, Adrian Fiergolski wrote:
>>> On 12.12.2017 at 16:25, Peter Rosin wrote:
>>>> On 2017-12-12 13:06, Adrian Fiergolski wrote:
>>>>> In a normal run scenario, I don't need it. I can imagine it may be a
>>>>> problem, if the module
>>>>> is suddenly unloaded and loaded: the mux remains set to some not default
>>>>> bus and
>>>>> the module is not aware of it. However, I agree then the bus could be
>>>>> reset somewhere
>>>>> at higher level.
>>>> Think about what happens if you have more than one chip on some i2c bus
>>>> that uses this reset mechanism. First you instantiate one of the drivers
>>>> and both chips are reset. Then you carry on with careful configuration
>>>> of that first chip. Then you instantiate the driver for the other chip
>>>> and all you careful configuration of the first chip is lost as it is
>>>> reset a second time. So, you just can't reset everything on the bus in
>>>> any random driver, that has to be done on some other level.
>>> That's all true. However, we are discussing an I2C mux/switch which is a
>>> root
>>> of an I2C sub-tree. It is initialized first, so the SOFTWARE_RESET command
>>> would reset only mux/switch and all its nodes. The command would be followed
>>> by the configuration of all its nodes, which anyway can't be performed
>>> earlier.
>> Have a look at Documentation/i2c/i2c-topology and think again.
> And... ?

If you have a topology like this (use a fixed-width font):

          .-- deviceA
          |
i2c-root--+          deviceB
          |         /
          '--pca984x
                    \
                     deviceC

and linux for some reason starts with instantiating the driver for deviceA,
and after that instantiates the pca984x driver, then you obviously have a
problem if deviceA reacts to a general call to reset done by the probe in
the pca984x driver.

Or if you have this:

                            deviceA
                           /
                    pca984x
                   /       \
i2c-root----pca984x         deviceB
                   \
                    deviceC

then the driver for the first level pca984x device is instantiated first,
but the general call to reset when the second level pca984x device is
instantiated will trash the already configured first level pca984x
device.

Cheers,
Peter
