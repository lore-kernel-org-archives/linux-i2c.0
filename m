From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
Date: Tue, 29 Sep 2015 12:14:45 +0200
Message-ID: <560A6495.1000606@redhat.com>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl> <20150927165303.GI31209@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934223AbbI2KOt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 29 Sep 2015 06:14:49 -0400
In-Reply-To: <20150927165303.GI31209@lunn.ch>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Olliver Schinagl <oliver+list@schinagl.nl>
Cc: Wolfram Sang <wsa@the-dreams.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 27-09-15 18:53, Andrew Lunn wrote:
> On Sun, Sep 27, 2015 at 06:05:35PM +0200, Olliver Schinagl wrote:
>> Hey Hans,
>>
>> On 27-09-15 16:57, Hans de Goede wrote:
>>> According to the datasheets to n factor for dividing the tclk is
>>> 2 to the power n on Allwinner SoCs, not 2 to the power n + 1 as it is
>>> on other mv64xxx implementations.
>> Ah!
>
> Just to be sure, i checked Kirkwood, Armada XP and Armada 370
> datasheets. They all say n+1.

Thanks.

>>> +	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
>>> +	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
>
> Rather than have to extend this list every so often, how about adding
> a helper of_device_is_compatible_vendor(), so you can just have:
>
>>> +	if (of_device_is_compatible_vendor(np, "allwinner")

I agree that if such a helper would already exist it would be a good
idea to use it, but it seems overkill to just at it for this.

Regards,

Hans
