From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Q: i2c block write emulation / handling of i2c message size
 constraints      of a bus ?
Date: Mon, 29 Oct 2012 18:27:25 +0100
Message-ID: <20121029182725.7abb3913@endymion.delvare>
References: <508BECFE.2010302@googlemail.com>
	<20121027175030.0474249b@endymion.delvare>
	<508C009F.30107@googlemail.com>
	<20121028130301.64f032ff@endymion.delvare>
	<508D33E0.6070808@googlemail.com>
	<20121028163342.48bc40aa@endymion.delvare>
	<508D4E5F.4070209@googlemail.com>
	<20121028183913.79ad5ae3@endymion.delvare>
	<508E9FA0.4000505@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <508E9FA0.4000505-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank =?ISO-8859-1?B?U2No5GZlcg==?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Mon, 29 Oct 2012 17:24:16 +0200, Frank Sch=E4fer wrote:
> Am 28.10.2012 19:39, schrieb Jean Delvare:
> > In theory, "fully I2C compliant" means that i2c_transfer() would
> > succeed regardless of the message set passed (unless protocol mangl=
ing
> > flags are used.) In practice, it is still OK to set I2C_FUNC_I2C if=
 the
> > controller has limitations, as long as these limitations are less
> > restrictive than SMBus.
>=20
> I would say no, not true in my this case.
>=20
> So we have 1x pro and 2x contra I2C_FUNC_I2C.
>=20
> My feeling is, that a max. data size of 1 byte isn't what users of
> i2c_transfer, i2c_master_send and i2c_master_recv expect.
> So I think I will stay with I2C_FUNC_SMBUS_READ_BYTE |
> I2C_FUNC_SMBUS_BYTE_DATA only.

I agree.

> >> To summarize: there is no possibilty to determine the maximum i2c =
data
> >> length when using the i2c_xfer functions directly. It's basically =
try
> >> and error and if the message is too long, the adapters should retu=
rn
> >> -EOPNOTSUPP.
> > Yes, this is correct. I2C_FUNC_* flags aren't fine-grained enough t=
o
> > describe all cases, so they should be used as a way for device driv=
er
> > to exclude transactions which aren't supported at all, but they may
> > still have to deal with -EOPNOTSUPP on supported transactions. This=
 is
> > handled on a case-by-case basis.
> >
> > It could be argued that the I2C_FUNC_* flags aren't really necessar=
y
> > and drivers could simply try what they need and deal with -EOPNOTSU=
PP
> > afterward. This is correct but it would probably make the driver co=
de
> > more complex in most cases.
>=20
> What about adding a field/function i2c_xfer_maxlen to struct i2c_algo=
rtihm ?

This is only one of the various limitations we've seen in I2C
controllers so far. The maximum length may even by different in both
directions. Some controllers only support a discrete set of message
lengths or numbers. Etc... I don't think it makes sense to try to
exhaustively describe all these possible limitations. The current
approach where bus drivers return -EOPNOTSUPP on what they do not
support seems a lot better to me.

> It would also be useful for i2c_smbus_xfer_emulated, which can do a m=
uch
> better emulation with this information.

Can't see how. i2c_smbus_xfer_emulated translates an SMBus transaction
to an I2C message set, and there's only one way it can do that. Either
the controller can handle it, or it can't, but it's definitely not
i2c_smbus_xfer_emulated's job to silently tinkle the request to work
around hardware limitations.

--=20
Jean Delvare
