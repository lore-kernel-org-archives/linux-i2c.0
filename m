From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] i2c: enable i2c device to suspend/resume asynchronously
Date: Thu, 24 Sep 2015 14:27:58 +0800
Message-ID: <560397EE.1020308@linux.intel.com>
References: <55D206C3.1080204@linux.intel.com> <55DB35AC.3080701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30462 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbbIXG2A (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 24 Sep 2015 02:28:00 -0400
In-Reply-To: <55DB35AC.3080701@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi,

I have resent this patch with updated commit message - "[PATCH v2] i2c: enable i2c device to suspend/resume asynchronously".


Thanks,
Zhonghui

On 2015/8/24 23:18, Fu, Zhonghui wrote:
> Hi,
>
> Any comments are welcome.
>
>
> Thanks,
> Zhonghui
>
>
>
> On 2015/8/18 0:07, Fu, Zhonghui wrote:
>> Enable i2c device to suspend/resume asynchronously. This can improve
>> system suspend/resume speed.
>>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> ---
>>  drivers/i2c/i2c-core.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index c83e4d1..6587681 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -987,6 +987,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>>  	client->dev.of_node = info->of_node;
>>  	client->dev.fwnode = info->fwnode;
>>  
>> +	device_enable_async_suspend(&client->dev);
>>  	i2c_dev_set_name(adap, client);
>>  	status = device_register(&client->dev);
>>  	if (status)
>> -- 1.7.1
>>
