From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RFC: proposal for new i2c.h macro to initialize i2c address lists
	on the fly
Date: Sun, 7 Jun 2009 09:30:50 -0400
Message-ID: <9e4733910906070630i1ffcb821xb912f5ea662c7bef@mail.gmail.com>
References: <200906061500.49338.hverkuil@xs4all.nl>
	 <9e4733910906061520o7b0b2858wf4530cf672b1adc9@mail.gmail.com>
	 <200906070835.46989.hverkuil@xs4all.nl>
	 <9e4733910906070625i74477c9ma422b061eb61449d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e4733910906070625i74477c9ma422b061eb61449d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Jun 7, 2009 at 9:25 AM, Jon Smirl<jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Sun, Jun 7, 2009 at 2:35 AM, Hans Verkuil<hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org> wrot=
e:
>> On Sunday 07 June 2009 00:20:26 Jon Smirl wrote:
>>> On Sat, Jun 6, 2009 at 9:00 AM, Hans Verkuil<hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org> wr=
ote:
>>> > Hi all,
>>> >
>>> > For video4linux we sometimes need to probe for a single i2c addre=
ss.
>>> > Normally you would do it like this:
>>>
>>> Why does video4linux need to probe to find i2c devices? Can't the
>>> address be determined by knowing the PCI ID of the board?
>>
>> There are two reasons we need to probe: it is either because when th=
e board
>> was added no one bothered to record which chip was on what address (=
this
>> happened in particular with old drivers like bttv) or because there =
is
>> simply no other way to determine the presence or absence of an i2c d=
evice.
>
> Unrecorded boards could be handled by adding a printk at driver init
> time asking people to email you the needed information. Then remove
> the printks as soon as you get the answer.
>
>>
>> E.g. there are three versions of one card: without upd64083 (Y/C sep=
aration
>> device) and upd64031a (ghost reduction device), with only the upd640=
31a and
>> one with both. Since they all have the same PCI ID the only way to
>> determine the model is to probe.
>
> Did they happen to change the subsystem device_id? There are two pair=
s
> of PCI IDs on each card. Most of the time the subsystem vendor/device
> isn't set.

Example using lspci -vvv -nn

This is an Intel ICH8 but Dell as set in a subsystem id if 1028:01db
to indicate their custom use of the generic part.

00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus
Controller [8086:283e] (rev 02)
	Subsystem: Dell Device [1028:01db]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at dffdab00 (32-bit, non-prefetchable) [size=3D256]
	Region 4: I/O ports at ece0 [size=3D32]
	Kernel modules: i2c-i801




>
> Getting rid of the probes altogether is the most reliable solution.
> There is probably a way to identify these boards more specifically
> that you haven't discovered yet. =A0PCI subsystem device ID is worth
> checking.
>
>>
>> Regards,
>>
>> =A0 =A0 =A0 =A0Hans
>>
>>>
>>> > static const unsigned short addrs[] =3D {
>>> > =A0 =A0 =A0 =A0addr, I2C_CLIENT_END
>>> > };
>>> >
>>> > client =3D i2c_new_probed_device(adapter, &info, addrs);
>>> >
>>> > This is a bit awkward and I came up with this macro:
>>> >
>>> > #define V4L2_I2C_ADDRS(addr, addrs...) \
>>> > =A0 =A0 =A0 =A0((const unsigned short []){ addr, ## addrs, I2C_CL=
IENT_END })
>>> >
>>> > This can construct a list of one or more i2c addresses on the fly=
=2E But
>>> > this is something that really belongs in i2c.h, renamed to I2C_AD=
DRS.
>>> >
>>> > With this macro we can just do:
>>> >
>>> > client =3D i2c_new_probed_device(adapter, &info, I2C_ADDRS(addr))=
;
>>> >
>>> > Comments?
>>> >
>>> > Regards,
>>> >
>>> > =A0 =A0 =A0 =A0Hans
>>> >
>>> > --
>>> > Hans Verkuil - video4linux developer - sponsored by TANDBERG Tele=
com
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe linux-i=
2c" in
>>> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>>
>>
>> --
>> Hans Verkuil - video4linux developer - sponsored by TANDBERG Telecom
>>
>
>
>
> --
> Jon Smirl
> jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>



--=20
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
