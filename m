From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] i2c: Enable Cadence driver for ARM64
Date: Tue, 27 Oct 2015 07:14:42 +0900
Message-ID: <562EA5D2.5030503@osg.samsung.com>
References: <893f828f3ac665d80746589af3617dc462315329.1445868589.git.michal.simek@xilinx.com>
 <20151026143236.GK597@x1> <20151026144425.GA5588@katana>
 <20151026150048.GO597@x1> <562E416B.8@osg.samsung.com>
 <20151026164559.GP597@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53270 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbbJZWOt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 26 Oct 2015 18:14:49 -0400
In-Reply-To: <20151026164559.GP597@x1>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, Andrew Bresticker <abrestic@chromium.org>, David Box <david.e.box@linux.intel.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Joachim Eastwood <manabian@gmail.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>

Hello Lee,

On 10/27/2015 01:45 AM, Lee Jones wrote:
> On Tue, 27 Oct 2015, Javier Martinez Canillas wrote:
> 
>> Hello,
>>
>> On 10/27/2015 12:00 AM, Lee Jones wrote:
>>> On Mon, 26 Oct 2015, Wolfram Sang wrote:
>>>> On Mon, Oct 26, 2015 at 02:32:36PM +0000, Lee Jones wrote:
>>>>> Regarding your address list -- it's too big.  Most of your addressees
>>>>> don't care about this patch.  Please be more selective when sending
>>>>> patches to people, most of us have enough (relevant) mail as it is.
>>>>
>>>> Probably more effective than to write every user of get_maintainer.pl:
>>>> Patch it to not use git history by default and win the fight ;)
>>>
>>
>> Agreed, coincidentally I was telling people today that get_maintainers.pl
>> only provides a suggestion and that it should not be followed blindly.
>>
>>> Geert wrote to Joe today.  Let's see if he can improve things.
>>>
>>
>> What about something like the following patch until Joe writes a more
>> smarter git fallback version?
>>
>> From d6dc34810d24f33afb3c158d519966c1b6167a2f Mon Sep 17 00:00:00 2001
>> From: Javier Martinez Canillas <javier@osg.samsung.com>
>> Date: Mon, 26 Oct 2015 23:46:52 +0900
>> Subject: [RFC PATCH] get_maintainer: Don't fallback to git by default
>>
>> The get_maintainer.pl script could be used to get a list of people that
>> has to be in the copy list when posting patches for a given file but it
>> defaults to git fallback so the list returned isn't really relevant and
>> submitters are posting patches to random developers that just happened
>> to touch that file in the past.
>>
>> Disable git fallback so get_maintainer.pl only returns the information
>> that is in MAINTAINERS by default.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>  scripts/get_maintainer.pl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Works for me.  Although you should have used get_maintainer.pl and
> CC'ed Joe. ;)
>

hehe, yes. I first wanted to share with Wolfram and you to see if
that is what you were thinking about and that is why I didn't add
Joe and marked the patch as RFC.

I posted it as a proper patch now and also added a Suggested-by
tag from Wolfram.
 
> I never did this before -- it was both odd and fun:
> 
>   $ ./scripts/get_maintainer.pl -f scripts/get_maintainer.pl 
>   Joe Perches <joe@perches.com> (maintainer:GET_MAINTAINER SCRIPT)
>

Fun indeed.

[0]: https://patchwork.kernel.org/patch/7492371/

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
