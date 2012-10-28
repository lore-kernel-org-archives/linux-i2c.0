From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Q: i2c block write emulation / handling of i2c message size
 constraints   of a bus ?
Date: Sun, 28 Oct 2012 13:03:01 +0100
Message-ID: <20121028130301.64f032ff@endymion.delvare>
References: <508BECFE.2010302@googlemail.com>
	<20121027175030.0474249b@endymion.delvare>
	<508C009F.30107@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <508C009F.30107-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank =?ISO-8859-1?B?U2No5GZlcg==?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Sat, 27 Oct 2012 18:41:19 +0300, Frank Sch=E4fer wrote:
> Am 27.10.2012 18:50, schrieb Jean Delvare:
> > On Sat, 27 Oct 2012 17:17:34 +0300, Frank Sch=E4fer wrote:
> >> the i2c interface of my device is capable of writing 2 bytes (reg =
+
> >> data) and reading a single data byte only.
> > Are you talking about an I2C master (controller) here, or a slave
> > device?
>=20
> It's an em2765 USB-video-bridge with an OV2640 sensor slave.
> The i2c transfer functions I'm currently working on are not yet in th=
e
> em28xx driver.
>=20
> I don't know yet if it is a general bus limitation or a client limiti=
ation.
> The procedures are based on reverse-engineering work and the OV2640 i=
s
> the only device we have seen so far.
> Maybe it has something to do with the fact that the OV2640 uses SCCB.

Yes SCCB is apparently very limited in terms of supported transaction
types. Plus it diverges from the equivalent SMBus transactions in the
details. Note that we do have support for SCCB since kernel v3.6
(commit d47726c52122d64253ae56e0fafdb7d0b954e97c by Laurent Pinchart.)

> (...)
> Yes, emulating block reads/writes internally (the em28xx driver in th=
is
> case) is not the problem.
> My question was if it makes sense to export the emulation through the
> i2c subsystem.

If you do, you'll have to make it flexible enough that it can be used
by other drivers, such as at24 and eeprom.

> >> What's the right error code to return from the drivers master_xfer
> >> function if the message length is not supported ? -EMSGSIZE ?
> > -EOPNOTSUPP, per Documentation/i2c/fault-codes.
> >
> > Note that ideally, the slave driver should check the bus functional=
ity
> > and not try transactions which aren't supported. So returning
> > -EOPNOTSUPP normally never happens.
>=20
> What are the correct functionality flags to use in this case ?
> I2C_FUNC_I2C | I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_WORD_D=
ATA ?

If your controller is limited then I2C_FUNC_I2C is most certainly
wrong. From what you described, I'd say:

I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA

This doesn't match what Laurent said about SCCB 4 months ago though:

"The read transaction transmits 2 2-byte messages (addr/w, reg,
followed by addr/r, data)."

You can take a look at Documentation/i2c/smbus-protocol to match
transactions to function names (and from there to I2C_FUNC flags.)

--=20
Jean Delvare
