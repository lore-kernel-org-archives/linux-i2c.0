From: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [linux-pm] [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Wed, 6 Apr 2011 16:08:32 -0700
Message-ID: <BANLkTikApnXBtP7c=QLEvM9ye=_YZiSSqw@mail.gmail.com>
References: <20110406095240.410b4e7e@endymion.delvare> <Pine.LNX.4.44L0.1104061043220.1907-100000@iolanthe.rowland.org>
 <20110406223123.GA5297@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110406223123.GA5297-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 6, 2011 at 3:31 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
>
>> Neither is the case. =A0For these subsystems, the PM dependencies _a=
re_
>> known.
>
> ...
>
>> Now, I have no idea what the situation is with regard to I2C...
>
> You definitely don't know *anything* about the relationships for I2C,
> especially in embedded systems.
>

Would it be okay to enable this on a per-device basis where it is
known to be safe?

I started out doing it like this,  but I didn't like the way the patch =
looked
because it ended up having to call this function twice -- once on the i=
2c
master device and once on it's client devices (and actually a third tim=
e
because it had another struct dev for the industrial IO device).  So,
that seemed pretty ugly.

Also, it didn't seem to match the usage of device_enable_async_suspend(=
)
in other parts of the kernel where it was used on whole subsystems.

Sonny
