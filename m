From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Designware patches
Date: Mon, 20 Jun 2016 11:07:32 +0300
Message-ID: <6ddfd64d-8c9a-8b10-bea5-ff2165b83e00@linux.intel.com>
References: <20160619170800.GB2933@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30514 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbcFTIHf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 20 Jun 2016 04:07:35 -0400
In-Reply-To: <20160619170800.GB2933@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

On 06/19/2016 08:08 PM, Wolfram Sang wrote:
> Hi Jarkko and everyone,
>
> there are a bunch of patches pending for the designware driver and I am
> a bit lost e.g. if a series is superseding another series by taking a
> different approach, if there are contradicting series, or what would be
> a good order to pick them. May I ask for some assistance here? The list
> of patches can be seen here:
>
> http://patchwork.ozlabs.org/project/linux-i2c/list/?submitter=&state=&q=design&archive=&delegate=
>
> I'd suggest I apply patches whenever they get acked- or rev-by tags. Or
> drop them when someone says so in a reply to the patch. Does that sound
> like a plan?
>
Yeah, there has been some activity recently. So far I don't remember we 
have any urgent fixes pending. Acked and reviewed patches are easy this 
time: they are independent and there are no contradicting patches so 
should be safe to apply.

Lucas De Marchi's patch seems to be still problematic for  	Christian.

Jisheng Zhang's and Ulf Hansson's sets are both around CLK and PM. 
Hinting there are things needs to be changed. I quess Jisheng's patches 
had some opens and left floating. Ulf's recent set is under discussion.

-- 
Jarkko
