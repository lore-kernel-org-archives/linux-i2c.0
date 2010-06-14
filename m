From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8]reiserfs:stree.c Fix variable set but not used.
Date: Mon, 14 Jun 2010 15:50:30 -0700
Message-ID: <4C16B236.7080506@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-2-git-send-email-justinmattock@gmail.com> <4C1699AA.3000900@gmail.com> <4C169D71.90800@gmail.com> <4C16A372.6020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C16A372.6020604-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Edward Shishkin <edward.shishkin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/14/2010 02:47 PM, Edward Shishkin wrote:
> Justin P. Mattock wrote:
>> On 06/14/2010 02:05 PM, Edward Shishkin wrote:
>>> Justin P. Mattock wrote:
>>>> Not sure if this is correct or not.
>>>> the below patch gets rid of this warning message
>>>> produced by gcc 4.6.0
>>>>
>>>> fs/reiserfs/stree.c: In function 'search_by_key':
>>>> fs/reiserfs/stree.c:602:6: warning: variable
>>>> 'right_neighbor_of_leaf_node' set but not used
>>>>
>>>> Signed-off-by: Justin P. Mattock <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> Acked-by: Edward Shishkin <edward.shishkin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>
>> o.k.!!
>> what about the whitespace issue?
>
> Whitespaces should be removed.
> I recommend quilt package for managing patches:
> "quilt refresh --strip-trailing-whitespace" is your friend..
>
> Thanks,
> Edward.
>

o.k. I resent this.. fixed the whitespace(hopefully)
and add your Acked to it.
as for quilt I'll have to look into that..
(using a lfs system, so if the sourcecode is easy
to deal with(build), then it's a good but if it becomes
a nightmare maybe not!!).


Justin P. Mattock
