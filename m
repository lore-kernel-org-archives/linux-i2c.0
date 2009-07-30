From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Thu, 30 Jul 2009 11:12:05 -0400
Message-ID: <ac3eb2510907300812q2d848108ofe1d25801f7b990f@mail.gmail.com>
References: <20090426103025.4525edd3@hyperion.delvare> <20090704191431.3d352d0b@hyperion.delvare>
	<ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
	<20090705225616.1d4817e7@hyperion.delvare> <ac3eb2510907051434i4ee351cbk3db17b50c7e7618b@mail.gmail.com>
	<20090722210753.35802816@hyperion.delvare> <1248296688.2065.4.camel@yio.site>
	<20090723160259.78a10e37@hyperion.delvare> <ac3eb2510907230819g1b8edf63g42ffc4c87dbc0cb5@mail.gmail.com>
	<20090728144755.69d328d4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090728144755.69d328d4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 28, 2009 at 08:47, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>
> What's the merge timeline for this patch?

I just did it in the moment you asked, there are no other users so
far. Just submit it with your changes that need it, if Greg is ok with
that?

>> > Other than that (and in practice even with that) your patch works just
>> > fine for me. Thanks! Unfortunately it doesn't provide perfect
>> > compatibility, [...] to add this device link (pointing to "..") temporarily
>> > or would that be too confusing?
>>
>> I think that's ok, if it solves a real problem. The entire idea of _a_
>> "device" link is pretty flawed, and the reason we ripped all the
>> "struct class_device" devices out.
>
> OK, I've added the "device" link and now compatibility works perfectly.
> I'll post the updated patch series soon, if you want to take a look.

Sounds great.

> Would it make sense to move the "device" link creation into
> class_compat_create_link()? I suspect other users of a compatibility
> class may need it as well.

Might make sense, as long as it's not the built-in default.

Sometimes we need to insert devices into the devpath, and then the
"device" link does not point to the direct parent, but the next one.
So it would need to take another device parameter, if we do that, and
also accept NULL, if no such link is really needed.

The "device" link itself is a pretty broken concept, and should be
avoided wherever possible, so it should be as optional as we can do
it. :)

Thanks,
Kay
