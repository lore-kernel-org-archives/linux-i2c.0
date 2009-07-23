From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Thu, 23 Jul 2009 17:19:22 +0200
Message-ID: <ac3eb2510907230819g1b8edf63g42ffc4c87dbc0cb5@mail.gmail.com>
References: <20090426103025.4525edd3@hyperion.delvare> <20090504124341.42405e79@hyperion.delvare>
	<ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
	<20090704191431.3d352d0b@hyperion.delvare> <ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
	<20090705225616.1d4817e7@hyperion.delvare> <ac3eb2510907051434i4ee351cbk3db17b50c7e7618b@mail.gmail.com>
	<20090722210753.35802816@hyperion.delvare> <1248296688.2065.4.camel@yio.site>
	<20090723160259.78a10e37@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090723160259.78a10e37-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 23, 2009 at 16:02, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Wed, 22 Jul 2009 23:04:48 +0200, Kay Sievers wrote:

>> + =C2=A0 =C2=A0 return sysfs_remove_link(cls->kobj, dev_name(dev));
>
> I don't think you need the "return" here, as sysfs_remove_link return=
s
> void.

=46ixed. Thanks.

> Other than that (and in practice even with that) your patch works jus=
t
> fine for me. Thanks! Unfortunately it doesn't provide perfect
> compatibility, [...] to add this device link (pointing to "..") tempo=
rarily
> or would that be too confusing?

I think that's ok, if it solves a real problem. The entire idea of _a_
"device" link is pretty flawed, and the reason we ripped all the
"struct class_device" devices out.

> Another thing we have to discuss is the compatibility option. For now
> I've made it i2c-specific and enabled by default:
>
> config I2C_COMPAT
> =C2=A0 =C2=A0 =C2=A0 =C2=A0boolean "Enable compatibility bits for old=
 user-space"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default y
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here if you intend to run lm-=
sensors 3.1.1 or older.
>
> But this means a lot of ifdefs in my code (6). With a system-wide
> option, we could provide empty stubs I could get rid of them. OTOH, I=
t
> is easier to control the lifetime, and change the default value, of a
> subsystem specific option. So I'm not too sure what do to.

I'm not sure too. I think it's fine to have it per-subsytem, as only
the subsystem knows for how long it is needed, and it can probably be
dropped some day.

> Maybe it
> depends on how many subsystems will need the compatibility layer... D=
o
> you have an opinion?

I don't know of any other subsytem needing that, I've seen some just
moving things around without taking care about that. :)

Thanks,
Kay
