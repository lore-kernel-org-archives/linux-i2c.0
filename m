From: Matthias Urlichs <matthias-+qxcz+fHsVSELgA04lAiVw@public.gmane.org>
Subject: Re: State of arbitration and i2c_gpio?
Date: Tue, 17 Jul 2012 08:55:45 +0200
Message-ID: <20120717065544.GF11678@smurf.noris.de>
References: <loom.20120710T223443-322@post.gmane.org>
 <20120716225827.3425f4f8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120716225827.3425f4f8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Jean Delvare:
> If both pins can trigger an interrupt
> when their level changes, we could use this feature

I'm reasonably sure, thinking about this, that safe multimaster without
interrupts on the data line (so that you can watch for Start and Stop
conditions) is basically impossible. Not if you want your computer to d=
o
anything while it waits for the bus transaction to finish, that is.

> Note that "one and a half clock period" is not something which
> evaluates to a number. You have no idea at what frequency the other
> master, if it exists, would be driving the bus. And the I2C
> specification does not specify a minimum operating frequency, so in
> theory you'd have to wait... forever. To solve this problem, SMBus
> specifies a 50 =C2=B5s maximum bus idle time (which corresponds to a =
10 kHz
> clock, the minimum allowed under SMBus.) I suppose this is a sane
> setting in practice even for I2C controllers.

It does evaluate to a number if we assume that there's no good reason f=
or
the Clock line to be High for much longer than 5=C2=B5S, unless the bus=
 is idle
of course.

Needless to say, there might be a number of *bad* reasons for that =E2=80=
=A6

> At the other end of the
> spectrum, we have to deal with the maximum I2C frequency, 400 kHz in
> our context. This means you can't have more than 1.25 =C2=B5s between=
 polls.

Just wait until somebody implements Hs mode. :-P

> In all cases we'll certainly want to let adapters tell whether they a=
re
> operating on a multi-master bus or not, so that the whole thing can b=
e
> disabled when not needed.

They'll certainly notice that the first time they lose arbitration.

--=20
-- Matthias Urlichs
