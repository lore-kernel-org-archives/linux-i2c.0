From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] i2c_imc: New driver for Intel's iMC, found on LGA2011
 chips
Date: Sun, 08 Mar 2015 12:50:31 -0700
Message-ID: <54FCA807.7080505@roeck-us.net>
References: <cover.1425695891.git.luto@amacapital.net> <13443f0542fb447a4c0e558a5f6077c6a76a6e95.1425695891.git.luto@amacapital.net> <54FB0D7D.8060402@roeck-us.net> <CALCETrUwwhFS5H+dwpOyxqnr24pSmZt460i-CwUb0bt=VCOfMw@mail.gmail.com> <54FC6D2B.3060307@roeck-us.net> <CALCETrUYwvF6cbmGy4zU-HNYe7xamw61+7nuryN0KaRdS7i24A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrUYwvF6cbmGy4zU-HNYe7xamw61+7nuryN0KaRdS7i24A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jean Delvare <khali@linux-fr.org>, Boaz Harrosh <boaz@plexistor.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rui Wang <ruiv.wang@gmail.com>, Alun Evans <alun@badgerous.net>, Robert Elliott <Elliott@hp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Tony Luck <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 03/08/2015 12:30 PM, Andy Lutomirski wrote:
[ ... ]

>>
>>> One other question: from my reading of the spec, it should be possible to
>>> augment this driver to expose a temporate sensor subdevice that shows
>>> recent cached temperatures from HW DIMM measurements.  They would be
>>> redundant with the jc42 outputs, but it would be safe to use them even on
>>> systems without safe SMBUS arbitration.  Should I do that as a followup
>>> later on?
>>>
>>
>> Without thinking too much about it, this should be a separate driver,
>> and I think it might actually be more valuable (since less risky)
>> than this entire patch set.
>
> The main problem there is that they'll fight over the PCI ids.
>
That is why we have mfd drivers. While that most likely won't be a
solution here (and I don't suggest it), you can use the same idea.
If can not be instantiated as pci driver, the alternative would be
to instantiate it as platform driver and let it get its pci
information from the parent device.

Guenter
