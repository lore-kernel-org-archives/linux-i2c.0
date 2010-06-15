From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 6/8]i2c:i2c_core Fix warning: variable 'dummy' set but
  not used
Date: Tue, 15 Jun 2010 09:20:39 -0700
Message-ID: <4C17A857.8030306@caviumnetworks.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>	<1276547208-26569-7-git-send-email-justinmattock@gmail.com>	<20100614225315.2bae9e37@hyperion.delvare>	<4C169F19.1040608@gmail.com> <20100615134039.6ccfc17a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100615134039.6ccfc17a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Daney <david.s.daney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/15/2010 04:40 AM, Jean Delvare wrote:
> Hi David,
>
> On Mon, 14 Jun 2010 14:28:57 -0700, David Daney wrote:
>> On 06/14/2010 01:53 PM, Jean Delvare wrote:
>>> Hi Justin,
>>>
>>> On Mon, 14 Jun 2010 13:26:46 -0700, Justin P. Mattock wrote:
>>>> could be a right solution, could be wrong
>>>> here is the warning:
>>>>     CC      drivers/i2c/i2c-core.o
>>>> drivers/i2c/i2c-core.c: In function 'i2c_register_adapter':
>>>> drivers/i2c/i2c-core.c:757:15: warning: variable 'dummy' set but not used
>>>>
>>>>    Signed-off-by: Justin P. Mattock<justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>
>>>> ---
>>>>    drivers/i2c/i2c-core.c |    2 ++
>>>>    1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>>> index 1cca263..79c6c26 100644
>>>> --- a/drivers/i2c/i2c-core.c
>>>> +++ b/drivers/i2c/i2c-core.c
>>>> @@ -794,6 +794,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>>>>    	mutex_lock(&core_lock);
>>>>    	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
>>>>    				 __process_new_adapter);
>>>> +	if(!dummy)
>>>> +		dummy = 0;
>>>
>>> One word: scripts/checkpatch.pl
>>>
>>> In other news, the above is just plain wrong. First we force people to
>>> read the result of bus_for_each_drv() and then when they do and don't
>>> need the value, gcc complains, so we add one more layer of useless
>>> code, which developers and possibly tools will later wonder and
>>> complain about? I can easily imagine that a static code analyzer would
>>> spot the above code as being a potential bug.
>>>
>>> Let's stop this madness now please.
>>>
>>> Either __must_check goes away from bus_for_each_drv() and from every
>>> other function which raises this problem, or we must disable that new
>>> type of warning gcc 4.6.0 generates. Depends which warnings we value
>>> more, as we can't sanely have both.
>>>
>>
>> That is the crux of the whole thing.  Putting in crap to get rid of the
>> __must_check warning someone obviously wanted to provoke is just plain
>> wrong.
>
> __process_new_adapter() calls i2c_do_add_adapter() which always returns
> 0. Why should I check the return value of bus_for_each_drv() when I
> know it will always be 0 by construction?
>
> Also note that the same function is also called through
> bus_for_each_dev() somewhere else in i2c-core, and there is no warning
> there because bus_for_each_dev() is not marked __must_check. How
> consistent is this? If bus_for_each_dev() is OK without __must_check,
> then I can't see why bus_for_each_drv() wouldn't be.
>

Well, I would advocate removing the __must_check then.


David Daney
