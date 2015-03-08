From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c_imc: New driver for Intel's iMC, found on LGA2011 chips
Date: Sun, 8 Mar 2015 12:55:58 -0700
Message-ID: <CALCETrVv1_b2TH-jXkOYUVeJ812mOFz5HvfH-b1WuaHPP_tadw@mail.gmail.com>
References: <cover.1425695891.git.luto@amacapital.net> <13443f0542fb447a4c0e558a5f6077c6a76a6e95.1425695891.git.luto@amacapital.net>
 <54FB0D7D.8060402@roeck-us.net> <CALCETrUwwhFS5H+dwpOyxqnr24pSmZt460i-CwUb0bt=VCOfMw@mail.gmail.com>
 <54FC6D2B.3060307@roeck-us.net> <CALCETrUYwvF6cbmGy4zU-HNYe7xamw61+7nuryN0KaRdS7i24A@mail.gmail.com>
 <54FCA807.7080505@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54FCA807.7080505-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Boaz Harrosh <boaz-/8YdC2HfS5554TAoqtyWWQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alun Evans <alun-eX+YDEU5biwsV2N9l4h3zg@public.gmane.org>, Robert Elliott <Elliott-VXdhtT5mjnY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Mar 8, 2015 at 12:50 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> On 03/08/2015 12:30 PM, Andy Lutomirski wrote:
> [ ... ]
>
>>>
>>>> One other question: from my reading of the spec, it should be possible
>>>> to
>>>> augment this driver to expose a temporate sensor subdevice that shows
>>>> recent cached temperatures from HW DIMM measurements.  They would be
>>>> redundant with the jc42 outputs, but it would be safe to use them even
>>>> on
>>>> systems without safe SMBUS arbitration.  Should I do that as a followup
>>>> later on?
>>>>
>>>
>>> Without thinking too much about it, this should be a separate driver,
>>> and I think it might actually be more valuable (since less risky)
>>> than this entire patch set.
>>
>>
>> The main problem there is that they'll fight over the PCI ids.
>>
> That is why we have mfd drivers. While that most likely won't be a
> solution here (and I don't suggest it), you can use the same idea.
> If can not be instantiated as pci driver, the alternative would be
> to instantiate it as platform driver and let it get its pci
> information from the parent device.
>

Hmm.  It could make sense to have an Intel chipset driver that
instantiates sub-devices for thermal monitoring, smbus, and EDAC.  It
might be a bit of a cleanup for sb-edac, too.

Anyway, this isn't currently necessary.  Let's deal with it when we get there.

--Andy
