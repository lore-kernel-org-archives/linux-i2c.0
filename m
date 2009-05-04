From: =?GB2312?B?0sHU8w==?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pxa i2c unit busy caused unrecoverable phone hang problem
Date: Mon, 4 May 2009 11:16:53 +0800
Message-ID: <fd6b62c10905032016o60892475t222a17c7c28148db@mail.gmail.com>
References: <fd6b62c10904270057w610239dflfd228f949c0649b2@mail.gmail.com>
	<20090427120810.20af38b8@hyperion.delvare> <49F58A01.6060401@compulab.co.il>
	<fd6b62c10904270641p1dc6d86awc271dcc10a1f6b0@mail.gmail.com>
	<fd6b62c10904270832w54c77fb3kdff9981d949ff54b@mail.gmail.com>
	<20090503223351.GC5750@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090503223351.GC5750-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, yi.ru-SckdOjWYlhYAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben Dooks,

Thanks very much for your excellent reply.  ;-)

2009/5/4 Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:
> On Mon, Apr 27, 2009 at 11:32:26PM +0800, ?????? wrote:
>> Hi,
>>
>> As a compromise,we hope make the phone system free to run even the i=
2c
>> subsystem become busy already.Then there maybe time to choose some
>> useful way to solve that. The console can not input when phone hang
>> now.
>>
>> So we try to make the sleep time in i2c layer long enough,but the
>> result not well,because there are many threads waiting for i2c bus
>> operation.The key threads such as serial console could not get chanc=
e
>> to run,or cannot interact with user timely.
>>
>> Anyone could give a hand about this?
>
> Generally, if you're increasing sleep times, then you've either got
> an electrical issue with the bus, or there is a device on there which
> is causing the bus to be slowed down.
>
> Firstly, electrical issues:
>
> 1) Verify by measuring the clock pulses on the bus that it is
> =A0 running at the rate you expcet it to be. It can be very
> =A0 embarasing stating that your bus is 100KHz, when your hardware
> =A0 engineer's scope is saying 100Hz.
>
> 2) Are the rise times on either of SCL or SCA excessive? The bus
> =A0 relies on something pulling these lines inactive, and if there
> =A0 is either insufficient pull-up resitance (4.7 - 10K for 100KHz
> =A0 is iirc recommend) or too much capacitance then the bus can be
> =A0 held up waiting for these signals to reach inactive after they
> =A0 have been asserted
>
> 3) Are all the chips soldered on correctly and in the correct
> =A0 orientation?
>
> 4) Has the board been tested and known to work?
>

Yeah,it works most of the time.And i2c unit become busy very random.

> 5) Get a logic analyser and watch the traffic, look for how long
> =A0 it takes to complete a transaction and how often they are being
> =A0 issued.
>
>

I would ask our hardware engineers for help about your other good sugge=
stions.

> Another issue is are there any 'soft' devices on the bus, such as
> a power management microcontroller. If there are any devices that
> have (or have to) have firmware to work, do they have the correct
> firmware and has this firmware been verified to work?

No,we donot.
>
> My last real PXA work was ~2.6.9, but it was working fine then. I
> currently don't have any PXA devices with working kernels to do
> any testing of a current kernel.
Thanks again.  :-)

--Yize

>
>> Thanks in advance again.
>>
>> --Yize
>>
>> 2009/4/27 ?????? <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >
>> > thanks your reply ,Jean and Mike
>> >
>> > Winston Churchill ??- "The best argument against democracy is a fi=
ve-minute conversation with the average voter."
>> >
>> > 2009/4/27 Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>> >>
>> >>
>> >> Jean Delvare wrote:
>> >> > On Mon, 27 Apr 2009 15:57:45 +0800, ?????? wrote:
>> >> >> We use Marvell's pxaXXX chip,and the i2c unit often become BUS=
Y status .As
>> >> >> normal operation,the Unit-Busy will become free quickly,but so=
metimes
>> >> >> UNIT-BUSY forever.For there are very frequent i2c operations,t=
he cell-phone
>> >> >> become hang soon,nothing could be done but remove the battery =
and reboot.
>> >> >>
>> >> >> So could you give a suggestion? ??Is there any useful way to p=
rotect from
>> >> >> entering this abnormal UNIT-BUSY i2c status or recover from th=
at?
>> >>
>> >> PXA I2C controller often reports BUSY when one of the I2C lines a=
re held low.
>> >> Verify you have proper pull-ups and that devices connected to I2C=
 bus behave in
>> >> a sane way.
>> >
>> > Yes,we do.The unrecoverable problem is UNIT-BUSY,we still be confu=
sed by the root cause.Now we guess there are two types of answers:
>> >
>> > 1) Another master left I2C busy in abnormal status after operation
>> > 2) Protocol conflict violation caused by messages transfer,such as=
 the?? too large?? message or wrong operation.Most of the time,I2C work=
s fine.
>> >
>> > We thought there would be some reset mechasim in that bad situatio=
n,but not.
>> > There are many threads waiting for the mutex lock while the curren=
t operating one is trying,trying,and trying,,,but I2C Unit Busy block a=
ll.
>> >
>> > -- Yize
>> >>
>> >> > I don't know anything about PXA platforms, there's nothing I ca=
n do for
>> >> > you, sorry.
>> >> >
>> >>
>> >> --
>> >> Sincerely yours,
>> >> Mike.
>> >>
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>
> =A0'a smiley only costs 4 bytes'
>
