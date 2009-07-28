From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Tue, 28 Jul 2009 14:47:55 +0200
Message-ID: <20090728144755.69d328d4@hyperion.delvare>
References: <20090426103025.4525edd3@hyperion.delvare>
 <20090504124341.42405e79@hyperion.delvare>
 <ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
 <20090704191431.3d352d0b@hyperion.delvare>
 <ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
 <20090705225616.1d4817e7@hyperion.delvare>
 <ac3eb2510907051434i4ee351cbk3db17b50c7e7618b@mail.gmail.com>
 <20090722210753.35802816@hyperion.delvare>
 <1248296688.2065.4.camel@yio.site>
 <20090723160259.78a10e37@hyperion.delvare>
 <ac3eb2510907230819g1b8edf63g42ffc4c87dbc0cb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ac3eb2510907230819g1b8edf63g42ffc4c87dbc0cb5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kay,

On Thu, 23 Jul 2009 17:19:22 +0200, Kay Sievers wrote:
> On Thu, Jul 23, 2009 at 16:02, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote=
:
> > I don't think you need the "return" here, as sysfs_remove_link retu=
rns
> > void.
>=20
> Fixed. Thanks.

What's the merge timeline for this patch?

> > Other than that (and in practice even with that) your patch works j=
ust
> > fine for me. Thanks! Unfortunately it doesn't provide perfect
> > compatibility, [...] to add this device link (pointing to "..") tem=
porarily
> > or would that be too confusing?
>=20
> I think that's ok, if it solves a real problem. The entire idea of _a=
_
> "device" link is pretty flawed, and the reason we ripped all the
> "struct class_device" devices out.

OK, I've added the "device" link and now compatibility works perfectly.
I'll post the updated patch series soon, if you want to take a look.

Would it make sense to move the "device" link creation into
class_compat_create_link()? I suspect other users of a compatibility
class may need it as well.

> > Another thing we have to discuss is the compatibility option. For n=
ow
> > I've made it i2c-specific and enabled by default:
> >
> > config I2C_COMPAT
> > =A0 =A0 =A0 =A0boolean "Enable compatibility bits for old user-spac=
e"
> > =A0 =A0 =A0 =A0default y
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0Say Y here if you intend to run lm-sensors 3.1.1=
 or older.
> >
> > But this means a lot of ifdefs in my code (6). With a system-wide
> > option, we could provide empty stubs I could get rid of them. OTOH,=
 It
> > is easier to control the lifetime, and change the default value, of=
 a
> > subsystem specific option. So I'm not too sure what do to.
>=20
> I'm not sure too. I think it's fine to have it per-subsytem, as only
> the subsystem knows for how long it is needed, and it can probably be
> dropped some day.

OK, fine with me.

--=20
Jean Delvare
