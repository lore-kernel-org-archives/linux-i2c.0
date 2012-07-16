From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: State of arbitration and i2c_gpio?
Date: Mon, 16 Jul 2012 22:58:27 +0200
Message-ID: <20120716225827.3425f4f8@endymion.delvare>
References: <loom.20120710T223443-322@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20120710T223443-322-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Urlichs <matthias-+qxcz+fHsVSELgA04lAiVw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hallo Matthias,

On Mon, 16 Jul 2012 15:15:29 +0000 (UTC), Matthias Urlichs wrote:
> I'd like to ask whether anybody is working on adding arbitration supp=
ort to
> i2c_algo_bit.c. The code still has the old "FIXME do arbitration here=
" comments,
> added five years ago when the I=C2=B2C was imported into Linux 2.3.34=
pre1. :-/

Not that I am aware of.

> If not, and I'm going to have to do that myself =E2=80=A6 my main que=
stion is, even
> before I get to that -- how do I even detect that the bus is idle? Tu=
rn
> interrupts off and busy-loop-check that both SCL and SDA stay high fo=
r at least
> one and a half clock periods?

I was staring at this very FIXME comment in i2c-algo-bit a few weeks
ago and my thoughts were along the lines of "can this be implemented at
all?" We can't monitor SCL and SDA continuously with a pure software
implementation. We can do best effort, but the closer to perfection we
want to be, the more expensive. If both pins can trigger an interrupt
when their level changes, we could use this feature, but OTOH we
certainly don't want to receive interrupts the rest of the time, so
we'd have to repeatedly enable/disable these interrupts. If we don't
have such interrupts then indeed busy polling (or close to that) is the
only way I can think of.

Note that "one and a half clock period" is not something which
evaluates to a number. You have no idea at what frequency the other
master, if it exists, would be driving the bus. And the I2C
specification does not specify a minimum operating frequency, so in
theory you'd have to wait... forever. To solve this problem, SMBus
specifies a 50 =C2=B5s maximum bus idle time (which corresponds to a 10=
 kHz
clock, the minimum allowed under SMBus.) I suppose this is a sane
setting in practice even for I2C controllers. At the other end of the
spectrum, we have to deal with the maximum I2C frequency, 400 kHz in
our context. This means you can't have more than 1.25 =C2=B5s between p=
olls.
Not sure we can actually guarantee that...

In all cases we'll certainly want to let adapters tell whether they are
operating on a multi-master bus or not, so that the whole thing can be
disabled when not needed.

--=20
Jean Delvare
