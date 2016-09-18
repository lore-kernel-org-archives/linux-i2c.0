From: Yadi <yadi.hu@windriver.com>
Subject: Re: RESEND:i2c-eg20t: fix race between i2c init and interrupt enable
Date: Sun, 18 Sep 2016 10:55:14 +0800
Message-ID: <738c387b-2a7e-19fb-d9d9-034426ce3b49@windriver.com>
References: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
 <20160916200456.GA2216@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:60530 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755345AbcIRCz2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 17 Sep 2016 22:55:28 -0400
In-Reply-To: <20160916200456.GA2216@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org



在 2016/9/17 4:04, Wolfram Sang 写道:
>> after testing last patch, replacing request_irq() location is not a
>> good idea,it might produce a little time windows ,in which the interrupts
>> occurring inside  will be omitted.
>>
>> the new patch adds a check point on interrupt handler in case field
>> 'pch_base_address' has not been initialed.
> What about using two for-loops in probe like this pseudo code?
>
> for (all_channels)
> 	do_initialization
>
> request_irq()
>
> for (all_channels)
> 	register_adapter
>
>
> This seems to me the correct order and most readable solution.
if we use two for-loops, we would have to put  pch_i2c_init on the 
second loop in order to avoid littel interval, in which the interrupts 
occuring inside will be omitted.
it seems to me so uncomfortable. how do you like it?

for (all_channels)
	do_initialization

request_irq()

for (all_channels) {
	 pch_i2c_init  /* Enable interrupts at end of function*/
	 register_adapter
}

Yadi
