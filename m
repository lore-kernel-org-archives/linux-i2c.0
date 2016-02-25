From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
Date: Thu, 25 Feb 2016 14:32:11 -0500
Message-ID: <CAC=U0a0FR8u3=zYU7xDW4dJxbwFUY4RHxMdK9zoEHdXcWyNDPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36559 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645AbcBYTcS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 25 Feb 2016 14:32:18 -0500
Received: by mail-wm0-f49.google.com with SMTP id g62so44006893wme.1
        for <linux-i2c@vger.kernel.org>; Thu, 25 Feb 2016 11:32:12 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list.pdl@broadcom.com, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>

> We want the size of the struct, not of a pointer to it. To be future proof,
> just dereference the pointer to get the desired type.

Thanks for catching and fixing this.

>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>

Kamal
