From: "till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org" <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add possibility for user-defined
	(i2c-)devices for bus-drivers.
Date: Wed, 14 Nov 2012 20:22:34 +0100
Message-ID: <1352920954.19432.2.camel@Nokia-N900>
References: <1352829968-4908-1-git-send-email-holler@ahsoftware.de>
	 <20121113195533.6db71716@endymion.delvare> <50A2AC28.7050304@ahsoftware.de>
	 <20121113220835.111a178a@endymion.delvare> <50A2BAA2.6090009@ahsoftware.de>
	 <20121113224246.768bf734@endymion.delvare> <50A2DA0C.3090507@ahsoftware.de>
	 <20121114104050.79df8cd9@endymion.delvare>
	  <50A390CC.9000208@ahsoftware.de>
Reply-To: "till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org" <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A390CC.9000208-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Content-ID: <1352920953.19432.1.camel@Nokia-N900>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

i have seen i2c chips going nuts because some probing actually affected=
 the chips state. So i fully agree with Jean here.

I2C just isn't meant to be used for hot plugging. And so isn't the i2c-=
tiny-usb. It's more a hacking and testing device and is e.g. very conve=
nient to test i2c client drivers or to test some new i2c hardware. But =
i have never had a need for this before user land was available. And on=
ce it is you can really do any magic you want using e.g. udev and sysfs=
=2E

Also if you really need some chip to be available at boot time, then us=
b isn't for you. Usb can take pretty long to enumerate etc and you can =
never be sure when exactly a device shows up on the usb bus. You'd thus=
 additionally need some means of blocking the entire boot process if yo=
u want to enforce that. E.g. the kernel can wait for boot disks to appe=
ar for exactly this reason. But it wouldn't make much sense to delay th=
e boot for less cruicial things. Boot time is a critical thing and only=
 the most important things are supposed to have a negative impact on th=
at.

If you wan't an i2c device to be available at boot time, then you might=
 consider to connect it to some non-volatile i2c bus. I am pretty sure =
the raspberry pi has one.

Regards,
  Till

--=20
Dr. Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
----- Urspr=C3=BCngliche Mitteilung -----
> Hello,
>=20
> Am 14.11.2012 10:40, schrieb Jean Delvare:
>=20
> > > It isn't possible to do such, because the only ID available for
> > > i2c-busses is given them at runtime. So people have to live with =
that
> > > imho artificially problem, if they use my patch. I don't have any
> > > other solution until the numbering is predictable. But I assume y=
ou
> > > already know all that, otherwise you wouldn't have mentioned it.
> >=20
> > The problem is inherent to external, hot-plug I2C adapters. You can=
't
> > predict their bus number, and actually you can't even always predic=
t
> > their name. In the case of usb-tiny-i2c, you may be able to look-up=
 the
> > bus number from the adapter name, but you won't be able to always
> > differentiate between two adapters, if they are connected to paired=
 USB
> > ports.
> >=20
> > This is a design issue with the i2c-tiny-usb hardware in the first
> > place. If it is needed to differentiate between adapters, their wou=
ld
> > need to be a locally unique ID in every adapter, which the kernel c=
an
> > query. I suppose this was not deemed necessary at design time, as m=
ost
> > people will only connect one such adapter at a time to their system=
=2E
>=20
> Actually many of the available USB devices (e.g. many usb-serials) do=
n't=20
> offer a unique ID by themself. That isn't just a problem of the=20
> i2c-tiny-usb. But in contrast to other solutions, it shouldn't be ver=
y=20
> hard to give those adapters a unique ID. As the whole SUB solution is=
=20
> just software (and open source), one likely just would to write some=20
> small piece of additional code.
>=20
> > I have already experienced this and yes, it is a pain. But I would
> > think that a system designed without a RTC in the first place has
> > another way of getting its time correct at boot time, for example N=
TP.
> > As I understand it the RTC chip is only there to set the system tim=
e at
> > boot, right, the actual timekeeping during run-time is still done b=
y
> > the CPU?
>=20
> Whatever those people which want to us it decide. If I didn't want to=
=20
> help other people by offering them some small documentation about how=
 to=20
> build such theirself, I wouldn't have taken the usual and almost=20
> unavoidable pain trying feed some silly patches into the kernel. ;)
>=20
> Anyway, maybe Till Harbaum will like that solution and won't get bloc=
ked=20
> by you. And maybe in some years we will see how many other bus-driver=
s=20
> have adopted the same solution. In fact the in-driver solution was my=
=20
> first one and I've thought others might be interested too, so I've mo=
ved=20
> the few lines from the driver itself into the i2c-core before I sent =
the=20
> patches. Unfortunately a waste of time.
>=20
> Regards,
>=20
> Alexander
>=20
