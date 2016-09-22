From: Yadi <yadi.hu@windriver.com>
Subject: Re: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Thu, 22 Sep 2016 09:19:15 +0800
Message-ID: <57E33193.7010403@windriver.com>
References: <1474195951-7238-1-git-send-email-yadi.hu@windriver.com>
 <1474195951-7238-2-git-send-email-yadi.hu@windriver.com>
 <20160921161608.GB1432@katana> <20160921161846.GC1432@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:57216 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755086AbcIVBT6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Sep 2016 21:19:58 -0400
In-Reply-To: <20160921161846.GC1432@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org

On 2016年09月22日 00:18, Wolfram Sang wrote:
> On Wed, Sep 21, 2016 at 06:16:09PM +0200, Wolfram Sang wrote:
>> On Sun, Sep 18, 2016 at 06:52:31PM +0800, Yadi Hu wrote:
>>> From: "Yadi.hu" <yadi.hu@windriver.com>
>>>
>>> the eg20t driver call request_irq() function before the pch_base_address,
>>> base address of i2c controller's register, is assigned an effective value.
>>>
>>> there is one possible scenario that an interrupt which isn't inside eg20t
>>> arrives immediately after request_irq() is executed when i2c controller
>>> shares an interrupt number with others. since the interrupt handler
>>> pch_i2c_handler() has already active as shared action, it will be called
>>> and read its own register to determine if this interrupt is from itself.
>>>
>>> At that moment, since base address of i2c registers is not remapped
>>> in kernel space yet,so the INT handler will access an illegal address
>>> and then a error occurs.
>>>
>>> Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
>> Applied to for-next, thanks!
> I meant: applied to for-current!
one quick and stupid question, what's different between for-current and 
for-next branch?

Yadi
>
