From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
Date: Tue, 1 Mar 2016 11:14:51 -0500
Message-ID: <CAC=U0a0sq4F4YLiJ7W57ZBktpWkGjUHLcTScoZ0v_Lxoth5=Nw@mail.gmail.com>
References: <CAC=U0a0FR8u3=zYU7xDW4dJxbwFUY4RHxMdK9zoEHdXcWyNDPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33470 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbcCAQOw (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Mar 2016 11:14:52 -0500
Received: by mail-wm0-f51.google.com with SMTP id l68so42631002wml.0
        for <linux-i2c@vger.kernel.org>; Tue, 01 Mar 2016 08:14:52 -0800 (PST)
In-Reply-To: <CAC=U0a0FR8u3=zYU7xDW4dJxbwFUY4RHxMdK9zoEHdXcWyNDPg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list.pdl@broadcom.com, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>

Wolfram,

I found a minor checkpatch issue with the change while applying the
patch to my local branch.

WARNING: line over 80 characters
#11: FILE: drivers/i2c/busses/i2c-brcmstb.c:589:
+       dev->bsc_regmap = devm_kzalloc(&pdev->dev,
sizeof(*dev->bsc_regmap), GFP_KERNEL);

Kamal

On Thu, Feb 25, 2016 at 2:32 PM, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>> We want the size of the struct, not of a pointer to it. To be future proof,
>> just dereference the pointer to get the desired type.
>
> Thanks for catching and fixing this.
>
>>
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>
> Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
>
> Kamal
