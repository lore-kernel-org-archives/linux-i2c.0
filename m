From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 49/73] i2c: i801: Do not add ICH_RES_IO_SMI
 for the iTCO_wdt device
Date: Sun, 29 Mar 2020 16:07:17 -0400
Message-ID: <20200329200717.GD4189@sasha-vm>
References: <20200318205337.16279-1-sashal@kernel.org>
 <20200318205337.16279-49-sashal@kernel.org>
 <20200319073021.wh2b7kumxgbj5wkf@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgC2UHT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 29 Mar 2020 16:07:19 -0400
Content-Disposition: inline
In-Reply-To: <20200319073021.wh2b7kumxgbj5wkf@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Martin Volf <martin.volf.42@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org

On Thu, Mar 19, 2020 at 08:30:21AM +0100, Wolfram Sang wrote:
>
>> [wsa: complete fix needs all of http://patchwork.ozlabs.org/project/linux-i2c/list/?series=160959&state=*]
>
>Please take care of the line above if you want to backport. I don't
>think the dependencies are suitable for stable, so they don't have the
>stable tag.

I'll drop it, thanks!

-- 
Thanks,
Sasha
