From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] i2c-cht-wc: Add locking to interrupt / smbus_xfer
 functions
Date: Mon, 14 Aug 2017 22:55:07 +0200
Message-ID: <d5e73f83-90dd-6bf2-c682-2d8da849fc49@redhat.com>
References: <20170814201726.21045-1-hdegoede@redhat.com>
 <20170814201726.21045-2-hdegoede@redhat.com>
 <1502742959.25945.3.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbdHNUzJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 16:55:09 -0400
In-Reply-To: <1502742959.25945.3.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi,

On 14-08-17 22:35, Andy Shevchenko wrote:
> On Mon, 2017-08-14 at 22:17 +0200, Hans de Goede wrote:
>> Although unlikely without locking the smbux_xfer function may miss
>> the nack flag and further fixes in this patch-set add some more
>> complex constructions which need protection.
>   
>> -	if (read_write == I2C_SMBUS_READ) {
>> +	ret = 0;
>> +	mutex_lock(&adap->adap_lock);
>> +	if (adap->nack)
>> +		ret = -EIO;
>> +	else if (read_write == I2C_SMBUS_READ) {
>>   		ret = regmap_read(adap->regmap, CHT_WC_I2C_RDDATA,
>> &reg);
>> -		if (ret)
>> -			return ret;
>> -
> 
>>   		data->byte = reg;
> 
> Can this be moved out to keep logic the same (don't dirt data on error)?

Setting data on error is not really a problem and this gets
fixed in the next patch in the series where the reading
of the data moves to the irq-handler.

Regards,

Hans
