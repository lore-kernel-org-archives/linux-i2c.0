From: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 09 Apr 2014 13:55:30 -0400
Message-ID: <53458992.4060003@redhat.com>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>  <1397061392.5276.11.camel@x230> <53457D0D.7020805@redhat.com>  <1397063381.5276.17.camel@x230> <5345849F.6070909@redhat.com> <1397065034.5276.19.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397065034.5276.19.camel@x230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 04/09/2014 01:37 PM, Matthew Garrett wrote:
> On Wed, 2014-04-09 at 13:34 -0400, Prarit Bhargava wrote:
>> On 04/09/2014 01:09 PM, Matthew Garrett wrote:
>>> Imagine an i2c chip with indexed register access. What stops:
>>>
>>> CPU0 (i2c):		CPU1 (ACPI):
>>> SBWB register address
>>> 			SBWB register address
>>> SBRB register value
>>> 			SBRB register value
>>>
>>
>> Your example is no different from what we've told people to do right now when
>> they see the ACPI resource conflict message and use a kernel parameter to
>> override the error condition.  I'm not disputing that this could be a problem --
>> see my previous comment about hoping that someone @ Intel will let us know if
>> we're doing something horrible.
> 
> Right. It's dangerous, which is why we forbid it by default. How do we
> benefit from having a driver that's no safer?

We have yet to see where the existing case exhibits the behaviour of a race.  In
fact, AFAICT, all we've seen is stability.  So it's no safer?  Yep.  It's as
equally not racy as the existing workaround.

P.

> 
