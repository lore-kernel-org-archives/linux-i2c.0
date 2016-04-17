From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] i2c: exynos5: Fix possible ABBA deadlock by keeping I2C
 clock prepared
Date: Sat, 16 Apr 2016 20:40:44 -0400
Message-ID: <5712DB8C.70505@osg.samsung.com>
References: <1460757887-18128-1-git-send-email-javier@osg.samsung.com>
 <CANAwSgSgjpqhnXmfpVdOPDDN+=36n_sbR+hVJGouBoKMahYGwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:48608 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbcDQAkz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Apr 2016 20:40:55 -0400
In-Reply-To: <CANAwSgSgjpqhnXmfpVdOPDDN+=36n_sbR+hVJGouBoKMahYGwA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Paul Osmialowski <p.osmialowsk@samsung.com>, Kukjin Kim <kgene@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-i2c@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hello Anand,

On 04/16/2016 08:15 AM, Anand Moon wrote:

[snip]

>>
> 
> Thanks for fixing this bug. I also tried the same thing on clk, but
> missed the return on failed.
> 
> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
>

Thanks a lot for your testing and review.
 
> Best Regards
> -Anand Moon
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
