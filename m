From: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Thu, 7 Apr 2011 01:19:59 -0700
Message-ID: <BANLkTikDc6QhtK6F5VTX4iCkT0CAiXvztg@mail.gmail.com>
References: <20110406095240.410b4e7e@endymion.delvare> <Pine.LNX.4.44L0.1104061043220.1907-100000@iolanthe.rowland.org>
 <20110406223123.GA5297@opensource.wolfsonmicro.com> <20110407095513.4c0b708e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110407095513.4c0b708e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 7, 2011 at 12:55 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi Mark,
>
> On Thu, 7 Apr 2011 07:31:24 +0900, Mark Brown wrote:
>> On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
>>
>> > Neither is the case. =A0For these subsystems, the PM dependencies =
_are_
>> > known.
>>
>> ...
>>
>> > Now, I have no idea what the situation is with regard to I2C...
>>
>> You definitely don't know *anything* about the relationships for I2C=
,
>> especially in embedded systems.
>
> Can you please elaborate? The i2c subsystem uses a standard
> parent-children relationship. It seems fairly similar to USB for
> example. The only special case I can think of is with bus multiplexin=
g,
> but it would be easy enough to switch off async suspend/resume in thi=
s
> case.
>
> Sonny, I would expect you to obtain the time saving by only switching
> the i2c client device to async suspend/resume. wasn't it the case? i2=
c
> bus device suspend/resume shouldn't matter, as the operation should b=
e
> handled by the hardware (e.g. PCI) layer.

I tried that first, and it looked like the client resume wouldn't start=
 on the
async thread until the kernel resumed the i2c master which was
happening very late for some reason.  Maybe this was just a fluke of
the device ordering, but enabling it for both master and client allowed
the device resume to consistently happen much earlier.

Sonny
