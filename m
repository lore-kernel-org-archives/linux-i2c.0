From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 2/5] i2c: mux: pca954x: Make use of device properties
Date: Fri, 6 Mar 2020 12:48:14 +0100
Message-ID: <b19fb2ed-054a-3fc5-41d4-6ecf3ae1597b@axentia.se>
References: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
 <20200305155352.39095-2-andriy.shevchenko@linux.intel.com>
 <cf0cf14f-4e43-2a9c-63ed-f5f03ea7b114@axentia.se>
 <20200306095413.GQ1224808@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr60134.outbound.protection.outlook.com ([40.107.6.134]:52045
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbgCFLtD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Mar 2020 06:49:03 -0500
In-Reply-To: <20200306095413.GQ1224808@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Javier Martinez Canillas <javierm@redhat.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>



On 2020-03-06 10:54, Andy Shevchenko wrote:
> On Thu, Mar 05, 2020 at 09:05:56PM +0000, Peter Rosin wrote:
>> On 2020-03-05 16:53, Andy Shevchenko wrote:
>>> Device property API allows to gather device resources from different sources,
>>> such as ACPI. Convert the drivers to unleash the power of device property API.
> 
> ...
> 
>>>  static const struct i2c_device_id pca954x_id[] = {
>>> -	{ "pca9540", pca_9540 },
>>> -	{ "pca9542", pca_9542 },
>>> -	{ "pca9543", pca_9543 },
>>> -	{ "pca9544", pca_9544 },
>>> -	{ "pca9545", pca_9545 },
>>> -	{ "pca9546", pca_9546 },
>>> -	{ "pca9547", pca_9547 },
>>> -	{ "pca9548", pca_9548 },
>>> -	{ "pca9846", pca_9846 },
>>> -	{ "pca9847", pca_9847 },
>>> -	{ "pca9848", pca_9848 },
>>> -	{ "pca9849", pca_9849 },
>>> +	{ "pca9540", .driver_data = (kernel_ulong_t)&chips[pca_9540] },
>>> +	{ "pca9542", .driver_data = (kernel_ulong_t)&chips[pca_9542] },
>>> +	{ "pca9543", .driver_data = (kernel_ulong_t)&chips[pca_9543] },
>>> +	{ "pca9544", .driver_data = (kernel_ulong_t)&chips[pca_9544] },
>>> +	{ "pca9545", .driver_data = (kernel_ulong_t)&chips[pca_9545] },
>>> +	{ "pca9546", .driver_data = (kernel_ulong_t)&chips[pca_9546] },
>>> +	{ "pca9547", .driver_data = (kernel_ulong_t)&chips[pca_9547] },
>>> +	{ "pca9548", .driver_data = (kernel_ulong_t)&chips[pca_9548] },
>>> +	{ "pca9846", .driver_data = (kernel_ulong_t)&chips[pca_9846] },
>>> +	{ "pca9847", .driver_data = (kernel_ulong_t)&chips[pca_9847] },
>>> +	{ "pca9848", .driver_data = (kernel_ulong_t)&chips[pca_9848] },
>>> +	{ "pca9849", .driver_data = (kernel_ulong_t)&chips[pca_9849] },
>>
>> It feels odd/wrong to specifically name .driver_data when .name is not there.
>> None or both...
> 
> I will add .name as well.
> 
>>> +	data->chip = device_get_match_data(dev);
>>>  	if (!data->chip)
>>>  		data->chip = &chips[id->driver_data];
>>
>> These two lines no longer make any sence.
> 
> Please elaborate.
> 
> IIRC Javier explained once that I²C ID table is still good to have to allow
> enumeration from user space.

id->driver_data is no longer an integer index into chips[]. So, for the I2C
ID table case, either device_get_match_data returns the .driver_data as-is
from the pca954x_id array, or it returns NULL (I don't know which it is).
In the first case, if (!data->chip) ...; is useless dead code. In the latter
case, it should be

	if (!data->chip)
		data->chip = (whatever-type-chip-is *)id->driver_data;

(If it's this latter case, I get the feeling that changing the .driver_data
of pca954x_id is an orthogonal change that has little to do with using
device properties instead of of-specifics.)

Cheers,
Peter
