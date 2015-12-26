From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: i2c-core: One function call less in acpi_i2c_space_handler()
 after error detection
Date: Sat, 26 Dec 2015 20:30:29 +0100
Message-ID: <567EEAD5.4060108@users.sourceforge.net>
References: <201512261449.pmBxYtq3%fengguang.wu@intel.com>
 <567E3CF3.10606@users.sourceforge.net> <20151226074859.GA905@tetsubishi>
 <567E553B.5080005@users.sourceforge.net> <20151226184152.GA882@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:64262 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbbLZTag (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 26 Dec 2015 14:30:36 -0500
In-Reply-To: <20151226184152.GA882@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

>> I would appreciate if an unnecessary function call can be avoided here
>> so that the affected exception handling can become also a bit more efficient.
> 
> Simpler code is easier to maintain.

There are different opinions available around the desired simplicity.


> See your patch, you didn't get it correctly at your first try.

I wonder myself about the circumstances on how my incomplete update suggestion
did happen.


> Also, this is not a hot path,

I'm curious if approaches around better exception handling can eventually become
a "hot topic".


> so I see it as a micro-optimization

I can agree to this view for this function implementation.

 
> also adding complexity.

There are the usual software development trade-offs.


> I don't favor that.

Thanks for your constructive feedback.

Is an identifier like "free_client" a bit nicer (according to the Linux coding
style recommendations) than the short jump label "err" in the discussed use case?

Regards,
Markus
