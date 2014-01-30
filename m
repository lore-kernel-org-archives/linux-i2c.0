From: Josh Boyer <jwboyer-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Subject: Re: kernfs oops with i915+i2c_core in 3.14 merge window
Date: Thu, 30 Jan 2014 15:57:09 -0500
Message-ID: <CA+5PVA6RXSwaSYnc7fdL84DbzXyXqwt=fgD6SMMec0X20n-Atw@mail.gmail.com>
References: <CA+5PVA4Oj7XOZSEYqXGE7ZPVVK1oEHEc-w_DniCediWGVhrmhQ@mail.gmail.com>
	<20140130190513.GB16260@htj.dyndns.org>
	<CA+5PVA6jobif4fNJdFKtWvSdPbnhioKPOj4kD=V8-_m0C4AFmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+5PVA6jobif4fNJdFKtWvSdPbnhioKPOj4kD=V8-_m0C4AFmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, DRI mailing list <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 30, 2014 at 2:20 PM, Josh Boyer <jwboyer-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org> wrote:
> On Thu, Jan 30, 2014 at 2:05 PM, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Thu, Jan 30, 2014 at 02:03:18PM -0500, Josh Boyer wrote:
>>> Hi All,
>>>
>>> I'm seeing the oops below on my MacBookPro 10,2 machine using i915
>>> graphics.  It's after the DRM merge for 3.14 ( v3.13-10094-g9b0cd30) ,
>>> but we seem to have one report[1] of this happening well before that,
>>> in v3.13-3260-g03d11a0 as well.  Does anyone have a clue what is going
>>> on here?
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1055105
>>
>> Should be fixed by the following patch which is already queued.
>>
>>  http://lkml.kernel.org/g/20140129170403.GJ30842-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org
>
> Oh, excellent!  I'll throw that into a build and test it here.  Thanks
> for the quick reply, Tejun.

FWIW, my test build with that patch does seem to solve the problem.
Thanks again.

josh
