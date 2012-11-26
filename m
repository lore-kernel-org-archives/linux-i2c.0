From: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 26 Nov 2012 23:00:17 +0000
Message-ID: <50B3F481.7060500@pcserviceselectronics.co.uk>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org> <50B20670.5070509@pcserviceselectronics.co.uk> <CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com> <50B35642.7030104@pcserviceselectronics.co.uk> <CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA@mail.gmail.com> <20121126202003.GA3384@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121126202003.GA3384-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Uwe Kleine-K=F6nig wrote:
> Hello Viresh,
>=20
> On Mon, Nov 26, 2012 at 06:21:25PM +0530, Viresh Kumar wrote:
>> On 26 November 2012 17:15, Paul Carpenter
>> <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
>>> Unless you know why the bus is stuck, how can you reset reminder th=
is
>>> method ONLY works if SCL is high and SDA probably was low and the s=
lave
>>> device is what is stuck in wrong state. NOTE SCL and SDA high can b=
e
>>> considered as BUS IDLE or having passed SDA =3D 1 waiting next cloc=
k edge
>>> or state transition without other state information.
=2E...

>>> In over 10 years of using I2C in various forms the only times I hav=
e
>>> seen bus stuck or device in wrong state
>>>
>>> 1/ Some code changed a bus switch when Bus was NOT idle
>>>         i.e mid transaction
> not sure what you mean here. Does it include a (SoC i.e. i2c master)
> reset while the bus is not idle? That's the problem I was faced with
> some time ago.

In this case the I2C master was in an ASIC undergoing manufacturing tes=
t
and the system controlling the tests and monitoring results had an
EEPROM and EEPROM emulator only one could be switched in at any time.
At current production rates the particular EEPROM will run out of
allowable write cycles in a day and become unreliable for calibrated
test system. Hence the EEPROM emulator, manufacturer wanted to be able
to switch the i2c bus in use but did not synchronise the switching to
bus idle so two devices would lock up, one the EEPROM halfway through
transaction and the emulator because it got out of sync garbage.

Despite the FPGA having the software programmable functions to switch
correctly, they were not used.

Anything more than that and "I would have to shoot you afterwards" :-)

>>> 2/ Bit-banged I2C software was wrong incomplete transaction
>>> 3/ Short on bus
>>> 4/ Faulty device
>>> 5/ Faulty design so 1 and 0 thresholds were compromised
> I can add:
> 6/ device does clock stretching which is not detected/supported by th=
e
>    bus master
> 7/ clock frequency too high for a device

Yep those can happen as well but I tend to deal mainly with embedded
systems so all clock speeds and clock stretching are none before hand.

> In reply to a more detailed problem report that should be addressed b=
y
> this series on spear-devel I asked a few questions to rule out 6/ and
> 7/. I cannot find it in an public accessible archive though. It's abo=
ut
> a sta529 codec. When switching sample rates the codec then holds down
> SDA. After an additional clock pulse the device and bus are OK again.

I mainly see clock stretching issues, but try to design them out by
different devices or controllers.

> Best regards
> Uwe
>=20


--=20
Paul Carpenter          | paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
<http://www.pcserviceselectronics.co.uk/>    PC Services
<http://www.pcserviceselectronics.co.uk/fonts/> Timing Diagram Font
<http://www.gnuh8.org.uk/>  GNU H8 - compiler & Renesas H8/H8S/H8 Tiny
<http://www.badweb.org.uk/> For those web sites you hate
