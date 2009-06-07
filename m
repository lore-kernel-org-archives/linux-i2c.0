From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: RFC: proposal for new i2c.h macro to initialize i2c address lists  on the fly
Date: Sun, 7 Jun 2009 08:35:46 +0200
Message-ID: <200906070835.46989.hverkuil@xs4all.nl>
References: <200906061500.49338.hverkuil@xs4all.nl> <9e4733910906061520o7b0b2858wf4530cf672b1adc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <9e4733910906061520o7b0b2858wf4530cf672b1adc9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 07 June 2009 00:20:26 Jon Smirl wrote:
> On Sat, Jun 6, 2009 at 9:00 AM, Hans Verkuil<hverkuil@xs4all.nl> wrot=
e:
> > Hi all,
> >
> > For video4linux we sometimes need to probe for a single i2c address=
=2E
> > Normally you would do it like this:
>
> Why does video4linux need to probe to find i2c devices? Can't the
> address be determined by knowing the PCI ID of the board?

There are two reasons we need to probe: it is either because when the b=
oard=20
was added no one bothered to record which chip was on what address (thi=
s=20
happened in particular with old drivers like bttv) or because there is=20
simply no other way to determine the presence or absence of an i2c devi=
ce.=20

E.g. there are three versions of one card: without upd64083 (Y/C separa=
tion=20
device) and upd64031a (ghost reduction device), with only the upd64031a=
 and=20
one with both. Since they all have the same PCI ID the only way to=20
determine the model is to probe.

Regards,

	Hans

>
> > static const unsigned short addrs[] =3D {
> > =A0 =A0 =A0 =A0addr, I2C_CLIENT_END
> > };
> >
> > client =3D i2c_new_probed_device(adapter, &info, addrs);
> >
> > This is a bit awkward and I came up with this macro:
> >
> > #define V4L2_I2C_ADDRS(addr, addrs...) \
> > =A0 =A0 =A0 =A0((const unsigned short []){ addr, ## addrs, I2C_CLIE=
NT_END })
> >
> > This can construct a list of one or more i2c addresses on the fly. =
But
> > this is something that really belongs in i2c.h, renamed to I2C_ADDR=
S.
> >
> > With this macro we can just do:
> >
> > client =3D i2c_new_probed_device(adapter, &info, I2C_ADDRS(addr));
> >
> > Comments?
> >
> > Regards,
> >
> > =A0 =A0 =A0 =A0Hans
> >
> > --
> > Hans Verkuil - video4linux developer - sponsored by TANDBERG Teleco=
m
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l



--=20
Hans Verkuil - video4linux developer - sponsored by TANDBERG Telecom
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
