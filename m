From: Yadi <yadi.hu@windriver.com>
Subject: Re: RESEND:i2c-eg20t: fix race between i2c init and interrupt enable
Date: Wed, 14 Sep 2016 15:49:46 +0800
Message-ID: <57D9011A.9080300@windriver.com>
References: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
 <20160914072809.GA1417@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:53365 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761594AbcINHut (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Sep 2016 03:50:49 -0400
In-Reply-To: <20160914072809.GA1417@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org

On 2016年09月14日 15:28, Wolfram Sang wrote:
>> after testing last patch, replacing request_irq() location is not a
>> good idea,it might produce a little time windows ,in which the interrupts
>> occurring inside  will be omitted.
> To give you a little feedback: I think I liked the previous patch
> better, but need the weekend to think about it.
>
> Thanks,
>
>     Wolfram
>
thanks your feedback.


Yadi
