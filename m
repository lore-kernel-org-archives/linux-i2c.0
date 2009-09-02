From: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] eeprom: add non-cached sysfs read access to EEPROM data
Date: Wed, 2 Sep 2009 12:45:21 -0700
Message-ID: <fc21faff0909021245k44e27206t65a268470065431a@mail.gmail.com>
References: <20090901231500.AA737254211@localhost>
	 <20090902103034.15f13e4d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090902103034.15f13e4d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean,

In 2.6.25, I used this patch successfully for read-only access to some
SFP EEPROMs:
- 0x50 - vendor/part info (caching OK)
- 0x51 - real-time diagnostics data (caching not OK)

I only care about read-only access to these EEPROMs. And, actually, I
don't want to provide write access at all.

In 2.6.31, I'd like to continue using this same legacy driver for SFP
EEPROM access, with the option of bypassing the cache.

-- Petri

On Wed, Sep 2, 2009 at 1:30 AM, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Petri,
>
> On Tue, =A01 Sep 2009 16:15:00 -0700 (PDT), Petri Gynther wrote:
>> Add "eeprom-nc" sysfs attribute to provide non-cached read access
>> to EEPROM data. This is needed because some EEPROM-like devices
>> contain constantly changing real-time diagnostic data that cannot
>> be cached in kernel memory.
>>
>> Signed-off-by: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> ---
>> =A0drivers/misc/eeprom/eeprom.c | =A0 30 +++++++++++++++++++++++++++=
---
>> =A01 files changed, 27 insertions(+), 3 deletions(-)
>
> You are using the wrong driver for the task. The "eeprom" driver is a
> legacy driver solely meant for SPD and EDID EEPROMs, and these do nev=
er
> change, thus the caching mechanism. Please look at the new "at24"
> driver for accessing any other EEPROM type.
>
> --
> Jean Delvare
>
