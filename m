From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-sh_mobile device tree support
Date: Fri, 30 Mar 2012 17:53:35 +0900
Message-ID: <CANqRtoTERUznk7xYr5qHMP4X5cVbvUw9vLZ5X-6YFkmVf69m4Q@mail.gmail.com>
References: <20120330084402.19597.63655.sendpatchset@w520>
	<20120330084744.GF26543@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120330084744.GF26543-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 30, 2012 at 5:47 PM, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org> wrote=
:
> On Fri, Mar 30, 2012 at 05:44:02PM +0900, Magnus Damm wrote:
>> +static const struct of_device_id sh_mobile_i2c_dt_ids[] __devinitco=
nst =3D {
>> + =A0 =A0 { .compatible =3D "renesas,rmobile-iic", },
>> + =A0 =A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
>> +
> Given that this block predates R-Mobile, using the rmobile naming her=
e is
> pretty dubious. I suppose you can have it as an alias, though.

Sure, but creating new code based an old naming conventions seem rather=
 odd too.

Of course, if you think it is cramping your SH device tree style then
we can easily add a "renesas-shmobile-iic" entry as well.

Cheers,

/ magnus
