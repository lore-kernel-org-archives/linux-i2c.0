From: Yadi <yadi.hu@windriver.com>
Subject: Re: [PATCH] i2c-eg20t: use dynamically registered adapter number
Date: Fri, 2 Sep 2016 17:44:51 +0800
Message-ID: <57C94A13.20007@windriver.com>
References: <1471943158-21377-1-git-send-email-yadi.hu@windriver.com>
 <20160826173019.1f939ce5@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:59246 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbcIBJpt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Sep 2016 05:45:49 -0400
In-Reply-To: <20160826173019.1f939ce5@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2016年08月26日 23:30, Jean Delvare wrote:
> Hi Yadi,
>
> On Tue, 23 Aug 2016 17:05:58 +0800, Yadi Hu wrote:
>> From: Hu Yadi <Yadi.hu@windriver.com>
>>
>> The eg20t driver uses i2c_add_numbered_adapter() to register adapter:
>>
>>      pch_adap->nr = i;
>>      ret = i2c_add_numbered_adapter(pch_adap);
>>
>> Variable i is assigned to 0, it means that i2c_eg20t is the first adapter
>> by default. if another adapter registers before eg20t, above code return
>> error for index conflict:
>>
>>      i2c_eg20t 0000:05:0c.2: pch_i2c_probe :i2c_add_adapter[ch:0] FAILED
>>      i2c_eg20t: probe of 0000:05:0c.2 failed with error -16
>>
>> So, we can replace i2c_add_numbered_adapter() with i2c_add_adapter()
>> interface.since it dynamically allocates the index number.
> This does the exact opposite of:
>
> commit 07e8a51ff68353e01d795cceafbac9f54c49132b
> Author: Feng Tang <feng.tang@intel.com>
> Date:   Thu Jan 12 15:38:02 2012 +0800
>
>      i2c-eg20t: use i2c_add_numbered_adapter to get a fixed bus number
>
> So my understanding is that you are not supposed to register another
> i2c bus before the eg20t buses. What is the conflicting driver? Is it
> creating the buses with static number or not?
I am using one Kontron M2M, on which both i2c-eg20t and i2c-kempld are 
used simultaneously.
since kempld always is firstly initialized and configured to register 
dynamically, it always occupied the first bus-id. i.e. 0.
consequently, eg20t will complain to fail to register for no space for 
"0" i2c-bus.


>
> Looking at
>
> commit 03bde7c31a360f814ca42101d60563b1b803dca1
> Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Date:   Thu Mar 12 17:17:59 2015 +0100
>
>      i2c: busses with dynamic ids should start after fixed ids for DT
>
> it could be that you need to set some OF attribute to reserve i2c bus
> numbers <= 1 for static usage. Assuming you use OF. Or is it automatic,
> Wolfram?
>
> If not, it may make sense to add a helper function exposing
> __i2c_first_dynamic_bus_num to drivers (something like
> i2c_is_dynamic_bus_num().) After all, i2c_add_numbered_adapter() mostly
> makes sense if static i2c device definitions exist. If not,
> i2c_add_adapter() is just as good. So something like:
>
> 	if (i2c_is_dynamic_bus_num(i))
> 		ret = i2c_add_adapter(pch_adap);
> 	else {
> 		pch_adap->nr = i;
> 		ret = i2c_add_numbered_adapter(pch_adap);
> 	}
>
> may make sense. Unless someone has a better idea.

I totally agree with you and send off V2 patch soon per your suggestion.


Yadi
>
>> Signed-off-by: Hu Yadi <Yadi.hu@windriver.com>
>> ---
>>   drivers/i2c/busses/i2c-eg20t.c |    3 +--
>>   1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
>> index 7a51ddc..2f4c2af 100644
>> --- a/drivers/i2c/busses/i2c-eg20t.c
>> +++ b/drivers/i2c/busses/i2c-eg20t.c
>> @@ -913,8 +913,7 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
>>   
>>   		pch_i2c_init(&adap_info->pch_data[i]);
>>   
>> -		pch_adap->nr = i;
>> -		ret = i2c_add_numbered_adapter(pch_adap);
>> +               ret = i2c_add_adapter(pch_adap);
> Coding style is wrong here. Please use tabs, as ./scripts/checkpatch.pl
> tells you. Always check your patches with this script before you post
> them, thanks.
>
>>   		if (ret) {
>>   			pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
>>   			goto err_add_adapter;
>
