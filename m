From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 2/2] i2c: npcm: Add Nuvoton NPCM I2C controller driver
Date: Tue, 25 Feb 2020 11:30:22 -0800
Message-ID: <CAFd5g47z8Lo1usLRDLL32Pw8LB40+bpcbnJdcvW5ffoVhKM-uA@mail.gmail.com>
References: <20191121095350.158689-1-tali.perry1@gmail.com>
 <20191121095350.158689-3-tali.perry1@gmail.com> <20191125151618.GE2412@kunai>
 <CAHb3i=tGTcu2q15E5CL_od1rDgRDyx=ygoGSCu88AfBrnFn71w@mail.gmail.com> <CAHb3i=s+u1gHXwi7j7V_N-c8f8n7c1XB3QhkY8EAJuv6PA5GNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHb3i=s+u1gHXwi7j7V_N-c8f8n7c1XB3QhkY8EAJuv6PA5GNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tali Perry <tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nancy Yuen <yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Patrick Venture <venture-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Benjamin Fair <benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Avi Fishman <avifishman70-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, syniurge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 26, 2019 at 1:23 AM Tali Perry <tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi Wolfram,
>
> Thanks for your comments.
>
> The NPCM7XX BMC I2C\SMB controller HW module supports both SMB and I2C.
> It's main features are:
> 1. Supports Fast-Mode (400 KHz clock) I2C and Fast-Mode-plus (1 MHz clock=
) I2C
> 2. Supports the =E2=80=98fairness=E2=80=99 arbitration protocol defined b=
y the MCTP
> SMBus/I2C Transport Binding Specification v1.0.0
> 3. 32KB packets : this is an I2C spec limitation. The HW has no limit
> on packets size. It has a 16 bytes FIFO which can be reloaded over and
> over.
> 4. w\o size byte (for SMB block protocol).
> 5. Both master and slave. It can also replace modes in run time
> (requirement for IPMB and MCTP).
> 6. Bus timing is selected to support both specs.
>
> Originally the HW spec stated SMB everywhere .

Alright, so it sounds like the HW supports I2C and also has SMBus
specific support?

> Should I rename the SMB to I2C all over the driver?

If the HW supports general I2C; then yes, you should use the I2C
naming scheme. If you have SMBus specific support for some things, it
might be helpful to tag on smb in the name for only those
functions/data structures.

Also, please don't top-post.

> On Tue, Nov 26, 2019 at 8:47 AM Tali Perry <tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Hi Wolfram,
> >
> > Thanks for your comments.
> >
> > The NPCM7XX BMC I2C\SMB controller HW module supports both SMB and I2C.
> > It's main features are:
> > 1. Supports Fast-Mode (400 KHz clock) I2C and Fast-Mode-plus (1 MHz clo=
ck) I2C
> > 2. Supports the =E2=80=98fairness=E2=80=99 arbitration protocol defined=
 by the MCTP SMBus/I2C Transport Binding Specification v1.0.0
> > 3. 32KB packets : this is an I2C spec limitation. The HW has no limit o=
n packets size. It has a 16 bytes FIFO which can be reloaded over and over.
> > 4. w\o size byte (for SMB block protocol).
> > 5. Both master and slave. It can also replace modes in run time (requir=
ement for IPMB and MCTP).
> > 6. Bus timing is selected to support both specs.
> >
> > Originally the HW spec stated SMB everywhere .
> >
> > Should I rename the SMB to I2C all over the driver?

And please don't reiterate yourself like this; it can confuse the conversat=
ion.

> > On Mon, Nov 25, 2019 at 5:16 PM Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >>
> >> On Thu, Nov 21, 2019 at 11:53:50AM +0200, Tali Perry wrote:
> >> > Add Nuvoton NPCM BMC i2c controller driver.
> >> >
> >> > Signed-off-by: Tali Perry <tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> Looking at all this SMB_* naming of the registers and also the quirks,
> >> this looks more like an SMBUS controller to me?
> >>
> >> > +     // currently I2C slave IF only supports single byte operations=
.
> >> > +     // in order to utilyze the npcm HW FIFO, the driver will ask f=
or 16bytes
> >> > +     // at a time, pack them in buffer, and then transmit them all =
together
> >> > +     // to the FIFO and onward to the bus .
> >> > +     // NACK on read will be once reached to bus->adap->quirks->max=
_read_len
> >> > +     // sending a NACK whever the backend requests for it is not su=
pported.
> >>
> >> This for example...
> >>
> >> > +static const struct i2c_adapter_quirks npcm_i2c_quirks =3D {
> >> > +     .max_read_len =3D 32768,
> >> > +     .max_write_len =3D 32768,
> >> > +     .max_num_msgs =3D 2,
> >> > +     .flags =3D I2C_AQ_COMB_WRITE_THEN_READ
> >> > +};
> >>
> >> ... and this. Like SMBus with the only exception of being able to send
> >> 32K in a row. Or?
> >>
