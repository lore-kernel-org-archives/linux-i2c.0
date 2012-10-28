From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: Q: i2c block write emulation / handling of i2c message size constraints   of a bus ?
Date: Sun, 28 Oct 2012 16:11:27 +0100
Message-ID: <2078507.UX8nfMRFou@avalon>
References: <508BECFE.2010302@googlemail.com> <508C009F.30107@googlemail.com> <20121028130301.64f032ff@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121028130301.64f032ff-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Frank =?ISO-8859-1?Q?Sch=E4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Sunday 28 October 2012 13:03:01 Jean Delvare wrote:
> On Sat, 27 Oct 2012 18:41:19 +0300, Frank Sch=E4fer wrote:
> > Am 27.10.2012 18:50, schrieb Jean Delvare:
> > > On Sat, 27 Oct 2012 17:17:34 +0300, Frank Sch=E4fer wrote:
> > >> the i2c interface of my device is capable of writing 2 bytes (re=
g +
> > >> data) and reading a single data byte only.
> > >=20
> > > Are you talking about an I2C master (controller) here, or a slave
> > > device?
> >=20
> > It's an em2765 USB-video-bridge with an OV2640 sensor slave.
> > The i2c transfer functions I'm currently working on are not yet in =
the
> > em28xx driver.
> >=20
> > I don't know yet if it is a general bus limitation or a client
> > limitiation.
> > The procedures are based on reverse-engineering work and the OV2640=
 is
> > the only device we have seen so far.
> > Maybe it has something to do with the fact that the OV2640 uses SCC=
B.
>=20
> Yes SCCB is apparently very limited in terms of supported transaction
> types. Plus it diverges from the equivalent SMBus transactions in the
> details. Note that we do have support for SCCB since kernel v3.6
> (commit d47726c52122d64253ae56e0fafdb7d0b954e97c by Laurent Pinchart.=
)
>=20
> > (...)
> > Yes, emulating block reads/writes internally (the em28xx driver in =
this
> > case) is not the problem.
> > My question was if it makes sense to export the emulation through t=
he
> > i2c subsystem.
>=20
> If you do, you'll have to make it flexible enough that it can be used
> by other drivers, such as at24 and eeprom.

Is that really mandatory ? The EM2765 will only be connected to video s=
ensors=20
in practice.

> > >> What's the right error code to return from the drivers master_xf=
er
> > >> function if the message length is not supported ? -EMSGSIZE ?
> > >=20
> > > -EOPNOTSUPP, per Documentation/i2c/fault-codes.
> > >=20
> > > Note that ideally, the slave driver should check the bus function=
ality
> > > and not try transactions which aren't supported. So returning
> > > -EOPNOTSUPP normally never happens.
> >=20
> > What are the correct functionality flags to use in this case ?
> > I2C_FUNC_I2C | I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_WORD=
_DATA ?
>=20
> If your controller is limited then I2C_FUNC_I2C is most certainly
> wrong. From what you described, I'd say:
>=20
> I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA
>=20
> This doesn't match what Laurent said about SCCB 4 months ago though:
>=20
> "The read transaction transmits 2 2-byte messages (addr/w, reg,
> followed by addr/r, data)."

The EM2765 might split reg + data write operations into two transaction=
s=20
internally.

> You can take a look at Documentation/i2c/smbus-protocol to match
> transactions to function names (and from there to I2C_FUNC flags.)

--=20
Regards,

Laurent Pinchart
