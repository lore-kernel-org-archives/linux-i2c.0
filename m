From: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [linux-pm] [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Wed, 6 Apr 2011 23:45:34 -0700
Message-ID: <BANLkTi=t03WEB70D0YH29JEQei=wJU5Gig@mail.gmail.com>
References: <20110406095240.410b4e7e@endymion.delvare> <20110406223123.GA5297@opensource.wolfsonmicro.com>
 <BANLkTikApnXBtP7c=QLEvM9ye=_YZiSSqw@mail.gmail.com> <201104070722.44771.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201104070722.44771.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 6, 2011 at 10:22 PM, Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> On Thursday, April 07, 2011, Sonny Rao wrote:
>> On Wed, Apr 6, 2011 at 3:31 PM, Mark Brown
>> <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>> > On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
>> >
>> >> Neither is the case. =A0For these subsystems, the PM dependencies=
 _are_
>> >> known.
>> >
>> > ...
>> >
>> >> Now, I have no idea what the situation is with regard to I2C...
>> >
>> > You definitely don't know *anything* about the relationships for I=
2C,
>> > especially in embedded systems.
>> >
>>
>> Would it be okay to enable this on a per-device basis where it is
>> known to be safe?
>
> Yes.

Ok, I'll probably submit a patch for the specific case of the slow
light sensor to the IIO
guys later on, and if I find cases where we get wins on other I2C
heavy platforms
(like ARM netbooks) I'll send those out as device-specific changes as w=
ell.

<snip>

> It is used by subsystems where dependencies between devices are known=
 to
> generally follow the structure of the device hierarchy within the ker=
nel
> (i.e. they are well-defined buses with well-defined parents and child=
ren).

Ok, thanks for the explanation!

Sonny
