From: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] eeprom: add non-cached sysfs read access to EEPROM data
Date: Thu, 3 Sep 2009 11:42:53 -0700
Message-ID: <fc21faff0909031142k35749556q3d79b72b034def44@mail.gmail.com>
References: <20090901231500.AA737254211@localhost>
	 <20090902103034.15f13e4d@hyperion.delvare>
	 <fc21faff0909021245k44e27206t65a268470065431a@mail.gmail.com>
	 <20090902221651.10b13a5b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090902221651.10b13a5b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

OK, fine. I'll look into extending "at24" instead.

The only reason I was going with "eeprom" driver here is that it
worked just fine (with this diff) for my needs in 2.6.25. And, I
thought maybe someone else in the community can benefit from cache
bypass as well.

-- Petri

On Wed, Sep 2, 2009 at 1:16 PM, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Wed, 2 Sep 2009 12:45:21 -0700, Petri Gynther wrote:
>> In 2.6.25, I used this patch successfully for read-only access to some
>> SFP EEPROMs:
>> - 0x50 - vendor/part info (caching OK)
>> - 0x51 - real-time diagnostics data (caching not OK)
>>
>> I only care about read-only access to these EEPROMs. And, actually, I
>> don't want to provide write access at all.
>>
>> In 2.6.31, I'd like to continue using this same legacy driver for SFP
>> EEPROM access, with the option of bypassing the cache.
>
> This is not going to happen, sorry. "eeprom" is a legacy driver and we
> certainly don't want to enhance it in any way. The "at24" driver is
> much easier to extend as it was designed that way from the ground up.
> You can add a SFP EEPROM type to it (whatever it is) and have the
> driver automatically set the access to read-only and the caching
> strategy for each part of the EEPROM.
>
> I'm curious, why do you insist on using the eeprom driver?
>
> --
> Jean Delvare
>
