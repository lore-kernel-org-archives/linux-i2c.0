From: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] eeprom: add non-cached sysfs read access to EEPROM data
Date: Wed, 2 Sep 2009 12:28:00 -0700
Message-ID: <fc21faff0909021228y13279df5tb7642338601a1df0@mail.gmail.com>
References: <20090901231500.AA737254211@localhost>
	 <20090901233948.GA3828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090901233948.GA3828-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Greg,

It is up to the userspace app to decide whether to use cached
("eeprom") or non-cached ("eeprom-nc") sysfs interface.

Example: SFP module
It exposes two 256-byte EEPROM(-like) devices at 0x50 and 0x51.
0x50 is static vendor/part info and can be cached.
0x51 is real-time diagnostic data and cannot be cached.

Unfortunately, 0x51 does not have any identifying bits telling us that
it is real-time data.
(If it did, it would be easy to check and remember this when 0x51 is probed.)

-- Petri

On Tue, Sep 1, 2009 at 4:39 PM, Greg KH<greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Sep 01, 2009 at 04:15:00PM -0700, Petri Gynther wrote:
>> Add "eeprom-nc" sysfs attribute to provide non-cached read access
>> to EEPROM data. This is needed because some EEPROM-like devices
>> contain constantly changing real-time diagnostic data that cannot
>> be cached in kernel memory.
>
> How are we going to know which attribute to use?
>
> For all new sysfs attributes, you have to add a Documentation/ABI/ file
> as well, care to do that here?
>
> thanks,
>
> greg k-h
>
