From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Q: i2c block write emulation / handling of i2c message size
 constraints  of a bus ?
Date: Sat, 27 Oct 2012 17:50:30 +0200
Message-ID: <20121027175030.0474249b@endymion.delvare>
References: <508BECFE.2010302@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <508BECFE.2010302-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank =?ISO-8859-1?B?U2No5GZlcg==?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Sat, 27 Oct 2012 17:17:34 +0300, Frank Sch=E4fer wrote:
> the i2c interface of my device is capable of writing 2 bytes (reg +
> data) and reading a single data byte only.

Are you talking about an I2C master (controller) here, or a slave
device?

> A block read/write emulation function would have to do an i2c write (=
to
> increase the register) followed by either an i2c read or write for ea=
ch
> data byte.
> The question is now: does it make sense to emulate block operations f=
or
> the i2c/smbus layer in this case ?
> I'm not sure if an i2c read through the smbus/i2c subsystem should
> really trigger multiple low level i2c reads/writes...

No, that would be bad. There's no single way to emulate a transaction
using smaller transactions. Different slaves will react differently
(some have a notion of "current address", with or without
auto-increment, some don't.) Plus, in a multi-master environment,
splitting a transaction into small chunks is not safe. So doing that
transparently at the bus driver level would be plain wrong.

What could be done (this has been discussed earlier and is already
implemented in individual drivers) is provide helper functions reading
blocks in a best-effort mode. The caller's expectations would be
different from the regular block read functions. These helper functions
would be in neutral ground to avoid any improper assumption.

> What's the right error code to return from the drivers master_xfer
> function if the message length is not supported ? -EMSGSIZE ?

-EOPNOTSUPP, per Documentation/i2c/fault-codes.

Note that ideally, the slave driver should check the bus functionality
and not try transactions which aren't supported. So returning
-EOPNOTSUPP normally never happens.

--=20
Jean Delvare
