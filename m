From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3] i2c: Add support for NXP PCA984x family.
Date: Tue, 12 Dec 2017 20:03:35 +0100
Message-ID: <5cbfd97a-146b-8851-c63a-f2f60da33f5b@axentia.se>
References: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
 <20171211165811.5806-1-adrian.fiergolski@cern.ch>
 <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
 <2acdb52a-c669-631d-2ef2-ab0da2899e00@cern.ch>
 <cb42475b-eacb-d059-2ee5-f2a57cf29159@axentia.se>
 <c7842a62-980d-b220-aa42-51cbb5398c5b@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0127.outbound.protection.outlook.com ([104.47.2.127]:56717
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752253AbdLLTDm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 14:03:42 -0500
In-Reply-To: <c7842a62-980d-b220-aa42-51cbb5398c5b@cern.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

[Adding Wolfram]

On 2017-12-12 18:14, Adrian Fiergolski wrote:
> On 12.12.2017 at 16:25, Peter Rosin wrote:
>> On 2017-12-12 13:06, Adrian Fiergolski wrote:
>>> In a normal run scenario, I don't need it. I can imagine it may be a
>>> problem, if the module
>>> is suddenly unloaded and loaded: the mux remains set to some not default
>>> bus and
>>> the module is not aware of it. However, I agree then the bus could be
>>> reset somewhere
>>> at higher level.
>> Think about what happens if you have more than one chip on some i2c bus
>> that uses this reset mechanism. First you instantiate one of the drivers
>> and both chips are reset. Then you carry on with careful configuration
>> of that first chip. Then you instantiate the driver for the other chip
>> and all you careful configuration of the first chip is lost as it is
>> reset a second time. So, you just can't reset everything on the bus in
>> any random driver, that has to be done on some other level.
> That's all true. However, we are discussing an I2C mux/switch which is a
> root
> of an I2C sub-tree. It is initialized first, so the SOFTWARE_RESET command
> would reset only mux/switch and all its nodes. The command would be followed
> by the configuration of all its nodes, which anyway can't be performed
> earlier.

Have a look at Documentation/i2c/i2c-topology and think again.

>>> Well, yes... I want to be sure that the driver is actually able to serve
>>> the device which is going
>>> to be assigned to it. The best, of course, would be if I2C could
>>> enumerate itself (like PCIe), but
>>> as it's not a case and we need to rely on devicetree, I understand the
>>> driver should do "maximum"
>>> to cross-check the static configuration with the actual hardware.
>>> Moreover, in case of a configuration problem, one will be able to trace it
>>> immediately.
>>> By default, the driver performs a dummy access anyway. Since new chips
>>> come with those ID
>>> registers, I think it's reasonable to do something useful.
>> Sure, there are benefits, but is it worth it?
> As we perform anyway a dummy access, we suffer anyway I2C bus delay
> which will be, in case of PCA984x family, in the same order of magnitude
> (1 vs 3 words access). On another hand, one extra call doesn't change
> significantly, in my opinion, the code complexity.

The cost I'm concerned about isn't the time it takes to probe, the
concern is code. Given that I don't believe the code to check the
manufacturer/device using the special 0x7c address belongs in this
file at all, it seems like the best plan is to...

>>> The deviceID access is described in paragraph 6.2.2 of the manual
>>> (https://www.nxp.com/docs/en/data-sheet/PCA9846.pdf).
>>> The fixed DEVICE_ID_ADDRESS (0x7C) is used as address. The
>>> i2c_smbus_read_i2c_block_data function uses
>>> address of a client (client->addr).
>> Ahh, ok, I see what's going on. I think this should be a helper
>> function in the i2c core that returns the manufacturer, the device id
>> and the revision fields, thus eliminating the need to do bit-fiddling
>> in every driver that needs this info.
>>
>> And there should be a common "database" of manufacturers. It would be
>> a disservice to everybody to have that info scattered all over the
>> place.
> So how would we like to proceed? We keep for a time being
> an i2c_smbus_xfer call and in parallel start implementation of
> a new helper function in I2C core which would substitute this
> call in the future?

...simply skip it until someone has implemented support for it in the
I2C core. You could be the one to do that. Or not, if you don't feel
that you want to.

Wolfram, do you have an opinion on the device id check using the
0x7c address?

Cheers,
Peter
