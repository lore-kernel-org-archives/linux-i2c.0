From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8]reiserfs:stree.c Fix variable set but not used.
Date: Mon, 14 Jun 2010 17:01:06 -0700
Message-ID: <4C16C2C2.6000503@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-2-git-send-email-justinmattock@gmail.com> <4C1699AA.3000900@gmail.com> <4C169D71.90800@gmail.com> <4C16A372.6020604@gmail.com> <4C16B236.7080506@gmail.com> <tkrat.d7bea45e7dbad972@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <tkrat.d7bea45e7dbad972-MtYdepGKPcBMYopoZt5u/LNAH6kLmebB@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Richter <stefanr-MtYdepGKPcBMYopoZt5u/LNAH6kLmebB@public.gmane.org>
Cc: Edward Shishkin <edward.shishkin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/14/2010 04:07 PM, Stefan Richter wrote:
> On 14 Jun, Justin P. Mattock wrote:
>> On 06/14/2010 02:47 PM, Edward Shishkin wrote:
>>> Whitespaces should be removed.
>>> I recommend quilt package for managing patches:
>>> "quilt refresh --strip-trailing-whitespace" is your friend..
>>
>> o.k. I resent this.. fixed the whitespace(hopefully)
>> and add your Acked to it.
>> as for quilt I'll have to look into that..
>> (using a lfs system, so if the sourcecode is easy
>> to deal with(build), then it's a good but if it becomes
>> a nightmare maybe not!!).
>
> Since you appear to generate the patches with git, you can use "git diff
> --check [...]" for some basic whitespace checks (additions of trailing
> space, additions of space before tab).  For more extensive checks, try
> "git diff [...] | scripts/checkpatch.pl -".  Check this before you
> commit.  If you committed already, "git commit --amend [-a] [...]" lets
> you alter the very last commit of course.


Thanks for the info on this, copied it
down in my book of commands...

Justin P. Mattock
