From: Yadi <yadi.hu@windriver.com>
Subject: Re: [PATCH] i2c-eg20t: use dynamically registered adapter number
Date: Mon, 19 Sep 2016 11:25:58 +0800
Message-ID: <57DF5AC6.4050504@windriver.com>
References: <1471943158-21377-1-git-send-email-yadi.hu@windriver.com>
 <20160826173019.1f939ce5@endymion> <20160917214912.GA4395@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:62953 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936454AbcISD0Q (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 18 Sep 2016 23:26:16 -0400
In-Reply-To: <20160917214912.GA4395@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org

On 2016年09月18日 05:49, Wolfram Sang wrote:
>>> The eg20t driver uses i2c_add_numbered_adapter() to register adapter:
>>>
>>>      pch_adap->nr = i;
>>>      ret = i2c_add_numbered_adapter(pch_adap);
>>>
>>> Variable i is assigned to 0, it means that i2c_eg20t is the first adapter
>>> by default. if another adapter registers before eg20t, above code return
>>> error for index conflict:
>>>
>>>      i2c_eg20t 0000:05:0c.2: pch_i2c_probe :i2c_add_adapter[ch:0] FAILED
>>>      i2c_eg20t: probe of 0000:05:0c.2 failed with error -16
>>>
>>> So, we can replace i2c_add_numbered_adapter() with i2c_add_adapter()
>>> interface.since it dynamically allocates the index number.
>> This does the exact opposite of:
>>
>> commit 07e8a51ff68353e01d795cceafbac9f54c49132b
>> Author: Feng Tang <feng.tang@intel.com>
>> Date:   Thu Jan 12 15:38:02 2012 +0800
>>
>>      i2c-eg20t: use i2c_add_numbered_adapter to get a fixed bus number
> We have the same problem with i2c-pasemi:
> http://www.spinics.net/lists/linux-i2c/msg25761.html
>
> PCI + i2c_add_numbered_adapter + another device adding i2c busses
>
> And we cannot simply change back to i2c_add_adapter() because it will
> regress on those systems which originally wanted to have
> i2c_add_numbered_adapter().

I think the is one totally different issue with  i2c-pasemi, in which  
PCI device prior to probed  occupied bus number supposed to be used by 
i2c-pasemi.

For my case, i2c-kempld register dynamically  itself by default, 
consequently it would occupied i2c bus 0 and cause to fails for adding 
new i2c bus with i2c_add_number_adpater(0).
although  i2c-kempld provide variable 'i2c_bus' to control bus 
assignment,  it isso inconvenient we have to manually modify it to avoid 
possible conflict. so the reasonable solution looks like:

i2c-kempld.c

i2c->adap.nr = i2c_bus;

         if (i2c_bus >= -1)  /* using pci id to register if default=-1 
for dynamic assignment*/
             i2c->adap.n = pdev->id;
         ret = i2c_add_numbered_adapter(&i2c->adap);


how do you like it?

Yadi


>
>> Looking at
>>
>> commit 03bde7c31a360f814ca42101d60563b1b803dca1
>> Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Date:   Thu Mar 12 17:17:59 2015 +0100
>>
>>      i2c: busses with dynamic ids should start after fixed ids for DT
>>
>> it could be that you need to set some OF attribute to reserve i2c bus
>> numbers <= 1 for static usage. Assuming you use OF. Or is it automatic,
>> Wolfram?
> No, you need to define an alias in the devicetree. I don't think this
> platform is a DT user, though?
>
>> If not, it may make sense to add a helper function exposing
>> __i2c_first_dynamic_bus_num to drivers (something like
>> i2c_is_dynamic_bus_num().) After all, i2c_add_numbered_adapter() mostly
>> makes sense if static i2c device definitions exist. If not,
>> i2c_add_adapter() is just as good. So something like:
>>
>> 	if (i2c_is_dynamic_bus_num(i))
>> 		ret = i2c_add_adapter(pch_adap);
>> 	else {
>> 		pch_adap->nr = i;
>> 		ret = i2c_add_numbered_adapter(pch_adap);
>> 	}
>>
>> may make sense. Unless someone has a better idea.
> Interesting idea. Need to think about it some more. I didn't have a
> proper solution so far...
>
> Thanks,
>
>     Wolfram
>
