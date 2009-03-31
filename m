From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
Date: Tue, 31 Mar 2009 09:44:55 -0600
Message-ID: <fa686aa40903310844j11a85fb6w3558923e12670ba9@mail.gmail.com>
References: <20090331125028.066613801@denx.de>
	 <20090331125451.600446749@denx.de>
	 <20090331133953.GB3044@pengutronix.de>
	 <49D21EF1.9050200@grandegger.com>
	 <20090331135629.GC3044@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090331135629.GC3044-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2009/3/31 Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
>
>> >> -
>> >> - =A0mpc_i2c_setclock(i2c);
>> >> +
>> >> + =A0if (set_clock)
>> >> + =A0 =A0 =A0 =A0 =A0mpc_i2c_setclock(i2c);
>> >
>> > Can't we drop 'set_clock' with something like this here?
>> >
>> > + =A0 if (!of_get_property(op->node, "fsl,preserve-clocking", NULL=
)) {
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 if (of_get_property(op->node, "dfsrr", NULL)=
)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->flags |=3D FSL_I2C_DEV_=
SEPARATE_DFSRR;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 if (of_device_is_compatible(op->node, "fsl,m=
pc5200-i2c") ||
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_device_is_compatible(op->node, "m=
pc5200-i2c"))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->flags |=3D FSL_I2C_DEV_=
CLOCK_5200;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 mpc_i2c_setclock(i2c);
>> > + =A0 }
>>
>> No, because the I2C registers are not yet mapped.
>
> Sorry, I used misleading words :) With 'here' I meant 'at this
> position', i.e. insert my above block where mpc_i2c_setclock was used
> anyway.

I agree.  The extra flag makes the flow more complex.  The code block
should be moved down.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
