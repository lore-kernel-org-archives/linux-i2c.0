From: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Subject: Re: [PATCH v3] i2c: Add support for NXP PCA984x family.
Date: Tue, 12 Dec 2017 13:06:42 +0100
Message-ID: <2acdb52a-c669-631d-2ef2-ab0da2899e00@cern.ch>
References: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
 <20171211165811.5806-1-adrian.fiergolski@cern.ch>
 <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0059.outbound.protection.outlook.com ([104.47.1.59]:42880
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750853AbdLLMG4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 07:06:56 -0500
In-Reply-To: <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
Content-Language: en-GB
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
Cc: giometti@enneenne.com, giometti@linux.it

On 11.12.2017 at 20:14, Peter Rosin wrote:
>
>> a newer PCA984x family of the I2C switches and multiplexers from NXP.
>> In probe function, the patch supports device ID function, introduced in the
>> new family, and checks it against configuration provided by the
>> devicetree. Moreover, it also performs software reset which is now
>> available for the new devices.
>> The reset of the code remains common with the legacy PCA954x devices.
>>
>> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
>> ---
>> Apply Peter's and Rodolfo's comments.
>> Add missing part in pca984x_family_probe which checks deviceID.
>>
>> Peter addressing your main comments:
>>
>>  Quoting the PCA9848 manual: "The Software Reset Call allows all the devices in
>>  the I2C-bus to be reset to the power-up state value through a specific formatted
>>  I2C-bus command. To be performed correctly, it implies that the I2C-bus is
>>  functional and that there is no device hanging the bus."
>>  This call should reset the multiplexer and all devices which are below it in the
>>  I2C address space tree to the default state.
> Yes, I read all that in the datasheet, but why do *you* need it? Because
> it is wrong to do it in this driver. It is doubly wrong to do it
> unconditionally. I was asking so that I could help you find a solution
> for your problem, because it is simply not acceptable to add a bus-wide
> reset to a random driver.
In a normal run scenario, I don't need it. I can imagine it may be a
problem, if the module
is suddenly unloaded and loaded: the mux remains set to some not default
bus and
the module is not aware of it. However, I agree then the bus could be
reset somewhere
at higher level.
>>  The manufacturer ID and device ID checks in pca984x_family_probe ensures that
>>  we actually communicate with a device we intended to (according to the
>>  devicetree) and that communication with this device works properly (this device
>>  ID and manufacturer ID can be seen as a fixed pattern).
> Yes yes yes, but do you actually need it? Because it complicates the driver
> for little gain (in my opinion).
Well, yes... I want to be sure that the driver is actually able to serve
the device which is going
to be assigned to it. The best, of course, would be if I2C could
enumerate itself (like PCIe), but
as it's not a case and we need to rely on devicetree, I understand the
driver should do "maximum"
to cross-check the static configuration with the actual hardware.
Moreover, in case of a configuration problem, one will be able to trace it
immediately.
By default, the driver performs a dummy access anyway. Since new chips
come with those ID
registers, I think it's reasonable to do something useful.

>>  +
>> +	/* Get device ID */
>> +	device_id_raw.block[0] = 3;  /* read 3 bytes */
>> +	if (i2c_smbus_xfer(client->adapter, DEVICE_ID_ADDRESS, client->flags,
>> +			   I2C_SMBUS_READ,  client->addr << 1,
>> +			   I2C_SMBUS_I2C_BLOCK_DATA, &device_id_raw)) {
>>
> Whooa, I managed to miss this last time... Why are you not using the
> i2c_smbus_read_i2c_block_data helper? (and even if you have some good
> reason to open-code this, you seem to have some seriously confused
> arguments, so if those are indeed correct you need to document what
> the hell is going on)
>
The deviceID access is described in paragraph 6.2.2 of the manual
(https://www.nxp.com/docs/en/data-sheet/PCA9846.pdf).
The fixed DEVICE_ID_ADDRESS (0x7C) is used as address. The
i2c_smbus_read_i2c_block_data function uses
address of a client (client->addr).

Cheers,
Adrian
