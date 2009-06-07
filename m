From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: RFC: proposal for new i2c.h macro to initialize i2c address lists  on the fly
Date: Sun, 7 Jun 2009 15:38:07 +0200
Message-ID: <200906071538.07268.hverkuil@xs4all.nl>
References: <200906061500.49338.hverkuil@xs4all.nl> <9e4733910906070625i74477c9ma422b061eb61449d@mail.gmail.com> <9e4733910906070630i1ffcb821xb912f5ea662c7bef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e4733910906070630i1ffcb821xb912f5ea662c7bef-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 07 June 2009 15:30:50 Jon Smirl wrote:
> On Sun, Jun 7, 2009 at 9:25 AM, Jon Smirl<jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Sun, Jun 7, 2009 at 2:35 AM, Hans Verkuil<hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org> wr=
ote:
> >> On Sunday 07 June 2009 00:20:26 Jon Smirl wrote:
> >>> On Sat, Jun 6, 2009 at 9:00 AM, Hans Verkuil<hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>=20
wrote:
> >>> > Hi all,
> >>> >
> >>> > For video4linux we sometimes need to probe for a single i2c
> >>> > address. Normally you would do it like this:
> >>>
> >>> Why does video4linux need to probe to find i2c devices? Can't the
> >>> address be determined by knowing the PCI ID of the board?
> >>
> >> There are two reasons we need to probe: it is either because when =
the
> >> board was added no one bothered to record which chip was on what
> >> address (this happened in particular with old drivers like bttv) o=
r
> >> because there is simply no other way to determine the presence or
> >> absence of an i2c device.
> >
> > Unrecorded boards could be handled by adding a printk at driver ini=
t
> > time asking people to email you the needed information. Then remove
> > the printks as soon as you get the answer.

It's rather unfeasible when you are dealing with dozens and dozens of c=
ards.=20
We also know that there are variants of these cards out there where the=
y=20
changed audio chips or tuner chips without changing anything. It's not =
a=20
big deal, that's why we have the i2c probing to solve these cases. Newe=
r=20
drivers try to avoid probing wherever possible, of course.

> >> E.g. there are three versions of one card: without upd64083 (Y/C
> >> separation device) and upd64031a (ghost reduction device), with on=
ly
> >> the upd64031a and one with both. Since they all have the same PCI =
ID
> >> the only way to determine the model is to probe.
> >
> > Did they happen to change the subsystem device_id? There are two pa=
irs
> > of PCI IDs on each card. Most of the time the subsystem vendor/devi=
ce
> > isn't set.

No, it's all the same. This is very common for the cheaper cards. They =
take=20
a reference design, modify it and never bother to change the IDs.

Regards,

	Hans

>
> Example using lspci -vvv -nn
>
> This is an Intel ICH8 but Dell as set in a subsystem id if 1028:01db
> to indicate their custom use of the generic part.
>
> 00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus
> Controller [8086:283e] (rev 02)
> 	Subsystem: Dell Device [1028:01db]
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin C routed to IRQ 10
> 	Region 0: Memory at dffdab00 (32-bit, non-prefetchable) [size=3D256]
> 	Region 4: I/O ports at ece0 [size=3D32]
> 	Kernel modules: i2c-i801
>
> > Getting rid of the probes altogether is the most reliable solution.
> > There is probably a way to identify these boards more specifically
> > that you haven't discovered yet. =A0PCI subsystem device ID is wort=
h
> > checking.
> >
> >> Regards,
> >>
> >> =A0 =A0 =A0 =A0Hans
> >>
> >>> > static const unsigned short addrs[] =3D {
> >>> > =A0 =A0 =A0 =A0addr, I2C_CLIENT_END
> >>> > };
> >>> >
> >>> > client =3D i2c_new_probed_device(adapter, &info, addrs);
> >>> >
> >>> > This is a bit awkward and I came up with this macro:
> >>> >
> >>> > #define V4L2_I2C_ADDRS(addr, addrs...) \
> >>> > =A0 =A0 =A0 =A0((const unsigned short []){ addr, ## addrs, I2C_=
CLIENT_END
> >>> > })
> >>> >
> >>> > This can construct a list of one or more i2c addresses on the f=
ly.
> >>> > But this is something that really belongs in i2c.h, renamed to
> >>> > I2C_ADDRS.
> >>> >
> >>> > With this macro we can just do:
> >>> >
> >>> > client =3D i2c_new_probed_device(adapter, &info, I2C_ADDRS(addr=
));
> >>> >
> >>> > Comments?
> >>> >
> >>> > Regards,
> >>> >
> >>> > =A0 =A0 =A0 =A0Hans
> >>> >
> >>> > --
> >>> > Hans Verkuil - video4linux developer - sponsored by TANDBERG
> >>> > Telecom --
> >>> > To unsubscribe from this list: send the line "unsubscribe
> >>> > linux-i2c" in the body of a message to majordomo-u79uwXL29TaqPxH82wqD4g@public.gmane.org=
g
> >>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
> >>
> >> --
> >> Hans Verkuil - video4linux developer - sponsored by TANDBERG Telec=
om
> >
> > --
> > Jon Smirl
> > jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org



--=20
Hans Verkuil - video4linux developer - sponsored by TANDBERG Telecom
