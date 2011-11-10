From: "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: RE: 10-bit address support
Date: Thu, 10 Nov 2011 08:38:35 -0800
Message-ID: <B6A520E9CD57404AAFC0831E4FB39541AE68602AE6@IRVEXCHCCR02.corp.ad.broadcom.com>
References: <20111110160739.540cda37@endymion.delvare>
 <B6A520E9CD57404AAFC0831E4FB39541AE68602AD7@IRVEXCHCCR02.corp.ad.broadcom.com>
 <20111110173300.3f75d2db@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111110173300.3f75d2db-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
> Sent: Thursday, November 10, 2011 11:33 AM
> To: Jeffrey (Sheng-Hui) Chu
> Cc: Linux I2C
> Subject: Re: 10-bit address support
> 
> On Thu, 10 Nov 2011 07:58:35 -0800, Jeffrey (Sheng-Hui) Chu wrote:
> >
> >
> > > -----Original Message-----
> > > From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
> > > Sent: Thursday, November 10, 2011 10:08 AM
> > > To: Linux I2C
> > > Cc: Jeffrey (Sheng-Hui) Chu
> > > Subject: 10-bit address support
> > >
> > > Hi all,
> > >
> > > After Sheng-Hui's fix to i2c-algo-bit, it would seem that we are almost
> > > there with 10-bit slave address support. There's one remaining thing
> > > that worries me though: the 7-bit and 10-bit address spaces overlap.
> > > From Documentation/i2c/ten-bit-addresses:
> > >
> > > "The sets of addresses do not intersect: the 7 bit address 0x10 is not
> > > the same as the 10 bit address 0x10 (though a single device could
> > > respond to both of them)."
> >
> > From my understanding of the spec, there is no overlap.
> > The 10-bit client at 0x10 will be addressed by the following address
> sequence:
> > 0Xf0 0X10 <data-out>  or 0xf0 0x10 <restart> 0xf1<data-in>
> >
> > The 7-bit client at 0x10 will be addressed by the following address
> sequence:
> > 0x20 <data-out>  or 0x21 <data-in>
> >
> > 0xf0 is equivalent to 7-bit address of 0x78 which is a reserved address in 7-
> bit space.  A compliant 7-bit client should not use or respond to this address.
> 
> what you wrote above is completely exact, but is also completely
> unrelated to what I explained. The overlapping that currently exists is
> in the device names inside the kernel. It's a pure software issue.
> 
> > Don't need to do any workaround. IMHO
> 
> I'm certain we do.
> 
> --
> Jean Delvare
You're right.  It's my misunderstanding.

Regards,

-Jeffrey
