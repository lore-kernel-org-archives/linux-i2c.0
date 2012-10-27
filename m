From: =?ISO-8859-1?Q?Frank_Sch=E4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Q: i2c block write emulation / handling of i2c message size constraints
  of a bus ?
Date: Sat, 27 Oct 2012 18:41:19 +0300
Message-ID: <508C009F.30107@googlemail.com>
References: <508BECFE.2010302@googlemail.com> <20121027175030.0474249b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121027175030.0474249b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Am 27.10.2012 18:50, schrieb Jean Delvare:
> Hi Frank,
>
> On Sat, 27 Oct 2012 17:17:34 +0300, Frank Sch=E4fer wrote:
>> the i2c interface of my device is capable of writing 2 bytes (reg +
>> data) and reading a single data byte only.
> Are you talking about an I2C master (controller) here, or a slave
> device?

It's an em2765 USB-video-bridge with an OV2640 sensor slave.
The i2c transfer functions I'm currently working on are not yet in the
em28xx driver.

I don't know yet if it is a general bus limitation or a client limitiat=
ion.
The procedures are based on reverse-engineering work and the OV2640 is
the only device we have seen so far.
Maybe it has something to do with the fact that the OV2640 uses SCCB.

>
>> A block read/write emulation function would have to do an i2c write =
(to
>> increase the register) followed by either an i2c read or write for e=
ach
>> data byte.
>> The question is now: does it make sense to emulate block operations =
for
>> the i2c/smbus layer in this case ?
>> I'm not sure if an i2c read through the smbus/i2c subsystem should
>> really trigger multiple low level i2c reads/writes...
> No, that would be bad. There's no single way to emulate a transaction
> using smaller transactions. Different slaves will react differently
> (some have a notion of "current address", with or without
> auto-increment, some don't.) Plus, in a multi-master environment,
> splitting a transaction into small chunks is not safe. So doing that
> transparently at the bus driver level would be plain wrong.

Ok, thanks, that's what I expected.

> What could be done (this has been discussed earlier and is already
> implemented in individual drivers) is provide helper functions readin=
g
> blocks in a best-effort mode. The caller's expectations would be
> different from the regular block read functions. These helper functio=
ns
> would be in neutral ground to avoid any improper assumption.

Yes, emulating block reads/writes internally (the em28xx driver in this
case) is not the problem.
My question was if it makes sense to export the emulation through the
i2c subsystem.

>
>> What's the right error code to return from the drivers master_xfer
>> function if the message length is not supported ? -EMSGSIZE ?
> -EOPNOTSUPP, per Documentation/i2c/fault-codes.
>
> Note that ideally, the slave driver should check the bus functionalit=
y
> and not try transactions which aren't supported. So returning
> -EOPNOTSUPP normally never happens.

What are the correct functionality flags to use in this case ?
I2C_FUNC_I2C | I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_WORD_DAT=
A ?

Regards,
=46rank
