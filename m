From: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Thu, 10 Apr 2014 15:15:54 -0400
Message-ID: <5346EDEA.3070704@redhat.com>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>  <1397061392.5276.11.camel@x230> <53457D0D.7020805@redhat.com> <1397063381.5276.17.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397063381.5276.17.camel@x230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 04/09/2014 01:09 PM, Matthew Garrett wrote:
> On Wed, 2014-04-09 at 13:02 -0400, Prarit Bhargava wrote:
>>
>> On 04/09/2014 12:36 PM, Matthew Garrett wrote:
>>> On Wed, 2014-04-09 at 12:22 -0400, Prarit Bhargava wrote:
>>>> RFC and a work in progress ... I need to go through and do a bunch of error
>>>> condition checking, more testing, etc.  I'm just throwing this out there to see
>>>> if anyone has any major concerns about doing something like this.
>>>
>>> This isn't really a good approach. These aren't standardised ACPI
>>> methods, so you have no guarantee that they exist. The fact that a
>>
>> I've looked at the ACPI dump across six different systems (3 different vendors,
>> and an intel whitebox), and the data appears to be identical.  Could Intel
>> change these?  Yes, of course they could, but that's no different from any other
>> undocumented driver in the kernel.
> 
> Not really. These are an internal implementation detail, not an exported
> interface. We try to write drivers for exported interfaces, even if
> they're not documented.

Aren't the methods the exported interface?  I'm obviously missing something :)

> 
>>> method with one of these names exists is no guarantee that it has the
>>> same behaviour as the ones on your board. There's no guarantee that
>>> you're not racing against the firmware.
>>>
>>
>> I think there is -- AFAICT the operations are serialized; if they aren't that is
>> an associated risk.  Hopefully someone from Intel will lend a hand here and let
>> me know if I'm doing something horrible ;)
> 
> Imagine an i2c chip with indexed register access. What stops:
> 
> CPU0 (i2c):		CPU1 (ACPI):
> SBWB register address
> 			SBWB register address
> SBRB register value
> 			SBRB register value
> 
> and CPU0 getting back the wrong value?

I thought that the "Serialized" keyword in the methods specifically indicate
that this cannot happen.

/me could be confused but from the ACPI spec:

SerializeRule is optional and is a flag that defines whether the method is
serialized or not and is one of the following: Serialized or NotSerialized. A
method that is serialized cannot be reentered by additional threads. If not
specified, the default is NotSerialized.

P.
