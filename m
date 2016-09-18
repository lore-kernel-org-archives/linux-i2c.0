From: Yadi <yadi.hu@windriver.com>
Subject: Re: RESEND:i2c-eg20t: fix race between i2c init and interrupt enable
Date: Sun, 18 Sep 2016 16:51:14 +0800
Message-ID: <57DE5582.3020902@windriver.com>
References: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
 <20160916200456.GA2216@katana>
 <738c387b-2a7e-19fb-d9d9-034426ce3b49@windriver.com>
 <20160918075326.GA1412@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57711 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753739AbcIRIva (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 18 Sep 2016 04:51:30 -0400
In-Reply-To: <20160918075326.GA1412@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org

On 2016年09月18日 15:53, Wolfram Sang wrote:
>> it seems to me so uncomfortable. how do you like it?
>>
>> for (all_channels)
>> 	do_initialization
>>
>> request_irq()
>>
>> for (all_channels) {
>> 	 pch_i2c_init  /* Enable interrupts at end of function*/
>> 	 register_adapter
>> }
> Thanks for the correction. This would be still my preferred solution.
>
ok, I have no objection and will resend patch V3 per your solution.

Yadi
