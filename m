From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
Date: Sun, 8 Apr 2018 12:28:53 +0200
Message-ID: <fe039693-385a-9379-1257-22b79fbc13ea@axentia.se>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <20180408073435.i5nq2ngx2fslaz6a@katana>
 <336870c2-b6fb-3933-708f-67036bd6668a@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <336870c2-b6fb-3933-708f-67036bd6668a@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Sorry for replying to self...

On 2018-04-08 11:08, Peter Rosin wrote:
> On 2018-04-08 09:34, Wolfram Sang wrote:
>> Hi,
>>
>> On Mon, Mar 19, 2018 at 09:10:58AM -0700, Guenter Roeck wrote:
>>> Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
>>> I2C device id") added a function to return the standard I2C device ID.
>>> Use that function to verify the device ID of a given device.
>>
>> I am very open to these patches, just...
>>
>>>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> RFC:
>>> - Compile tested only
>>
>> ... I would really like to have them tested. After that happened, Peter
>> and I can figure out who should apply them for seamless upstreaming.
>>
>>> - Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
>>>   against all parts from a given manufacturer ?
>>
>> Can't we just add it when we need it?

Is it really reasonable to verify just the manufacturer? I don't see the
use case? I mean, we can never know if the verified manufacturer will
release unexpected chips further down the line.

>>> +		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
>>> +			real_id.manufacturer_id, real_id.part_id,
>>> +			real_id.die_revision);
>>> +		return -ENODEV;
>>
>> I wonder about the ERR loglevel. ENODEV is not an error, I'd think?
> 
> Well, in this case someone has said that I2C addr <xyz> is a <uvw> device,
> but when verifying the actual device at that addr, that's not what is
> found. Hence, I think an error is appropriate? On the other hand, a driver
> that can handle different kinds of devices might not want the error. But
> for that case, maybe the driver should be using i2c_get_device_id() and
> figure out the details by itself?

Maybe it should just be -EINVAL, and that's your real objection?

Cheers,
Peter
