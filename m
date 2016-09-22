From: Yadi <yadi.hu@windriver.com>
Subject: Re: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Thu, 22 Sep 2016 09:04:06 +0800
Message-ID: <57E32E06.8080803@windriver.com>
References: <1474195951-7238-1-git-send-email-yadi.hu@windriver.com>
 <1474195951-7238-2-git-send-email-yadi.hu@windriver.com>
 <20160921161608.GB1432@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:33532 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbcIVBEx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 21:04:53 -0400
In-Reply-To: <20160921161608.GB1432@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org

On 2016年09月22日 00:16, Wolfram Sang wrote:
> On Sun, Sep 18, 2016 at 06:52:31PM +0800, Yadi Hu wrote:
>> From: "Yadi.hu" <yadi.hu@windriver.com>
>>
>> the eg20t driver call request_irq() function before the pch_base_address,
>> base address of i2c controller's register, is assigned an effective value.
>>
>> there is one possible scenario that an interrupt which isn't inside eg20t
>> arrives immediately after request_irq() is executed when i2c controller
>> shares an interrupt number with others. since the interrupt handler
>> pch_i2c_handler() has already active as shared action, it will be called
>> and read its own register to determine if this interrupt is from itself.
>>
>> At that moment, since base address of i2c registers is not remapped
>> in kernel space yet,so the INT handler will access an illegal address
>> and then a error occurs.
>>
>> Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
> Applied to for-next, thanks!
>
> Please make sure "V3" also appears in the patch subject since patch
> management tools pick this up. "-v <nr>" in recent git versions makes
> this super easy.

Got it, I will resend the patch with V3 tag.


Yadi
