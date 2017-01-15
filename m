From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC 1/4] x86/platform/intel/iosf_mbi: Add a mutex for punit
 access
Date: Sun, 15 Jan 2017 12:10:25 +0100
Message-ID: <dbcd01b3-c917-1d65-ace4-664e5df1cd45@redhat.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-2-hdegoede@redhat.com>
 <20170102141242.GY31595@intel.com>
 <2ecf7b65-98aa-696b-f399-1f2d15d0ea65@redhat.com>
 <20170113092644.GD31595@intel.com>
 <a213718a-b4e9-09a0-a97f-69eb5e892151@redhat.com>
 <20170113163005.GK31595@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750824AbdAOLK3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 15 Jan 2017 06:10:29 -0500
In-Reply-To: <20170113163005.GK31595@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, tagorereddy <tagore.chandan@gmail.com>

Hi,

On 13-01-17 17:30, Ville Syrjälä wrote:
> On Fri, Jan 13, 2017 at 05:06:52PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 01/13/2017 10:26 AM, Ville Syrjälä wrote:
>>> On Mon, Jan 02, 2017 at 03:21:13PM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 02-01-17 15:12, Ville Syrjälä wrote:
>>>>> On Sun, Jan 01, 2017 at 09:14:00PM +0100, Hans de Goede wrote:
>>>>>> The punit on baytrail / cherrytrail systems is not only accessed through
>>>>>> the iosf_mbi functions, but also by the i915 code. Add a mutex to protect
>>>>>> the punit against simultaneous accesses and 2 functions to lock / unlock
>>>>>> this mutex.
>>>>>
>>>>> I'm not sure which part of punit you're actually trying to protect
>>>>> here. Some specific registers?
>>>>
>>>> The theory I'm going by is that for certain actions / certain requests
>>>> we send to the punit, the punit needs to access the (axp288) pmic, to
>>>> change (or enable / disable) certain voltages.
>>>
>>> At least for cpu/display/gt voltages that shouldn't really be the case.
>>> The vcc/vnn/vgg rails are controlled via svid, not i2c.
>>
>> Are you sure? The ax288 pmic does not have a svid interface, only
>> an i2c interface, and AFAICT its buck DCDC converters are used to
>> feed all of these.
>
> Yes, looks like you're right. I guess someone didn't want to spend three
> pins for svid.
>
>>
>>> It also feels quite hand wavy since the punit could do whatever at
>>> any time AFAIK. Eg. if there's some thermal event or something the
>>> punit might kick into action. So trying to protect this from the OS
>>> side might not be able to avoid these problems entirely. It feels like
>>> there really should be some kind of shared hardware/firmware mutex
>>> with the punit to arbitrate access to the i2c bus.
>>
>> Right, and there is such a mutex (which only gets used on systems
>> with an axp288 pmic...) and we are taking this mutex before starting
>> an i2c transaction on the pmic i2c bus. But this does not seem to be
>> enough. It seems the the punit does not check the mutex before
>> certain OS / host triggered actions. I guess it expects the host to
>> do this itself.
>>
>> Please see my new (non RFC) version of this series I've posted.
>>
>> There are at least 2 problems when relying solely on the punit
>> pmic i2c bus sempaphore:
>>
>> 1) CPU C1 <-> C6 transations happening while the pmic i2c bus
>> is being accessed by the host cause the system to hang
>> 2) i915 (runtime) suspend resume fails every other attempt
>> with timeouts when trying to get a forcewake lock inn i915,
>> often followed by a system freeze shortly after this.
>
> Hmm. But forcewake works at other times?

It depends on the workload, I believe the forcewake timeouts are
caused by e.g. the axp288 fuel-gauge driver directly accessing
the pmic i2c bus at the same time as the i915 driver is doing a
forcewake. So in essence this is race and as such not 100%
reproducible. With my workload (Fedora 25 with gnome3) full suspend
+ resume is a good way to reproduce. The bug reporter
(tagorereddy) in:

https://bugzilla.kernel.org/show_bug.cgi?id=155241

Is seeing this during normal use when using a kde / plasma desktop.

Some history, this problem started surfacing when I fixed the
i2c punit semaphore code in i2c-designware-baytrail.c to actually
work on cht, before that systems with an axp288 any attempt to
access the i2c bus by e.g. the axp288_fuel_gauge driver would result
in -ETIMEOUT as the code would fail to acquire the punit i2c bus
semaphore, this i2c-designware-baytrail.c cht bug has so far protected
users against the described race (*).

tagorereddy then tried my patches to get battery monitoring working
on his cht device. Then he reported back in the above bug that he
was getting forcewake timeouts + system hangs. I only noticed I could
reproduce them myself on resume later (which was quite useful in
actually developing the proposed fix).

 > That seems quite strange.
> Runtime suspend itself shouldn't really do much, and if we're still
> poking at the the hw then we haven't really even suspended anything
> yet, so having failing forcewake doesn't sounds at all good.

Sorry, I'm actually seeing these on a (full not runtime) resume,
not suspend, it seems that at resume my setup has the ideal
circumstances to hit the race.

Regards,

Hans


*) Note as described in the cover letter of the non RFC version of
this patch-set:

https://www.spinics.net/lists/dri-devel/msg128896.html

Disabling access to the pmic i2c bus (as the fixed bug does) is
not a workable solution:

"Unfortunately that will cause some major issues on affected devices:
-No battery monitoring
-No "AC" plugged in monitoring
-If booted with a normal USB-A -> micro-USB cable, or no cable, plugged
  in and then the user replaces the cable with an otg USB-host cable /
  adapter, the id-pin shorting will enable a 5v boost convertor, but we
  need to disable the pmic's USB-Vbus path otherwise it will start drawing
  current from the boost convertor, leading to aprox 300mA of extra
  battery drain, this is done by the axp288_charger driver, which needs
  direct i2c access to the pmic bus"
