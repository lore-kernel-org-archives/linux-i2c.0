From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Mon, 07 Mar 2016 22:47:55 +0530
Message-ID: <56DDB7C3.50307@gmail.com>
References: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com> <20160307165733.GA20093@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34430 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbcCGRSF (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 12:18:05 -0500
In-Reply-To: <20160307165733.GA20093@kroah.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Monday 07 March 2016 10:27 PM, Greg KH wrote:
> On Mon, Mar 07, 2016 at 05:19:17PM +0530, Sudip Mukherjee wrote:
>> The variable p is a data structure which is used by the driver core
>> internally and it is not expected that busses will be directly accessing
>> these driver core internal only data.
>>
>> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>> ---
>>
>> Reference of Greg's comment about it at:
>> https://lkml.org/lkml/2016/3/5/171
>>
>>   drivers/i2c/i2c-core.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 2949ab3..2f31fb5 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -73,6 +73,7 @@ static struct device_type i2c_client_type;
>>   static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
>>
>>   static struct static_key i2c_trace_msg = STATIC_KEY_INIT_FALSE;
>> +static bool is_registered;
>>
>>   void i2c_transfer_trace_reg(void)
>>   {
>> @@ -1529,7 +1530,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>>   	int res = 0;
>>
>>   	/* Can't register until after driver model init */
>> -	if (unlikely(WARN_ON(!i2c_bus_type.p))) {
>> +	if (unlikely(WARN_ON(!is_registered))) {
>>   		res = -EAGAIN;
>>   		goto out_list;
>>   	}
>
> Minor nit, likely/unlikely should only be used on very "hot paths" where
> the difference if it is not included can be measured.  the "register a
> device" path is not "hot" at all.

I can submit a patch afterwards to remove the "unlikely" if that is ok 
with Wolfram.

regards
sudip
