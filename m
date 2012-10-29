From: =?ISO-8859-1?Q?Frank_Sch=E4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Q: i2c block write emulation / handling of i2c message size constraints
     of a bus ?
Date: Mon, 29 Oct 2012 17:24:16 +0200
Message-ID: <508E9FA0.4000505@googlemail.com>
References: <508BECFE.2010302@googlemail.com> <20121027175030.0474249b@endymion.delvare> <508C009F.30107@googlemail.com> <20121028130301.64f032ff@endymion.delvare> <508D33E0.6070808@googlemail.com> <20121028163342.48bc40aa@endymion.delvare> <508D4E5F.4070209@googlemail.com> <20121028183913.79ad5ae3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121028183913.79ad5ae3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am 28.10.2012 19:39, schrieb Jean Delvare:
> On Sun, 28 Oct 2012 17:25:19 +0200, Frank Sch=E4fer wrote:
>> Am 28.10.2012 17:33, schrieb Jean Delvare:
>>> Most I2C_FUNC_* flags actual refer to the smbus_xfer method. A driv=
er
>>> implementing master_xfer is typically fully I2C capable and can thu=
s
>>> run almost any I2C or SMBus transaction. Such a driver will set
>>> functionality flags to I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL. The rest=
 of
>>> the flags are for SMBus-only controllers. Each flag basically
>>> corresponds to an i2c_smbus_*() function, which in turn corresponds=
 to
>>> the combination of an SMBus transaction type or size and a directio=
n
>>> (read or write).
>>>
>>> The mapping between i2c_smbus_*() functions and functionality flags=
 is
>>> rather obvious, but for clarity I'll update
>>> Documentation/i2c/smbus-protocol to mention it. Patch follows.
>>>
>>> Also see Documentation/i2c/functionality for a detailed explanation=
 of
>>> how functionality flags work both on the I2C/SMBus adapter driver a=
nd
>>> the I2C device driver sides.
>> Ok, so the functionality flags describe whats possible when using th=
e
>> smbus functions.
>> That's a bit confusing/misleading if the adapter driver doesn't
>> implement the smbus_xfer function in struct i2c_algorithm.
>> And if the i2c adapter / master_xfer fcn has some restrictions (e.g.
>> data length), things are getting complicated.
> Yes, this is correct.
>
>> I2C_FUNC_SMBUS functionality flags are sufficiently documented, but =
what
>> about I2C_FUNC_I2C ?
> I2C_FUNC_I2C means that you can call i2c_transfer, i2c_master_send an=
d
> i2c_master_recv on the I2C adapter.

=2E.. which is always possible if master_xfer is implemented...

>
>> Should this be set always if there is a master_xfer function or only=
 if
>> the adapter is fully i2c compliant (and what does "fully i2c complia=
nt"
>> mean ?) ?
> If i2c_transfer() has a chance to succeed for any transaction type no=
t
> covered by I2C_FUNC_SMBUS_* flags, then I2C_FUNC_I2C should be set.

I would say this is not the case for my adapter.
smbus capability flags I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_BYTE_D=
ATA
should cover everything which is possible.

> So
> yes, you are right, I2C_FUNC_I2C is set if and only if master_xfer is
> implemented.

That seems obvious.

> In theory, "fully I2C compliant" means that i2c_transfer() would
> succeed regardless of the message set passed (unless protocol manglin=
g
> flags are used.) In practice, it is still OK to set I2C_FUNC_I2C if t=
he
> controller has limitations, as long as these limitations are less
> restrictive than SMBus.

I would say no, not true in my this case.

So we have 1x pro and 2x contra I2C_FUNC_I2C.

My feeling is, that a max. data size of 1 byte isn't what users of
i2c_transfer, i2c_master_send and i2c_master_recv expect.
So I think I will stay with I2C_FUNC_SMBUS_READ_BYTE |
I2C_FUNC_SMBUS_BYTE_DATA only.

>
>> To summarize: there is no possibilty to determine the maximum i2c da=
ta
>> length when using the i2c_xfer functions directly. It's basically tr=
y
>> and error and if the message is too long, the adapters should return
>> -EOPNOTSUPP.
> Yes, this is correct. I2C_FUNC_* flags aren't fine-grained enough to
> describe all cases, so they should be used as a way for device driver
> to exclude transactions which aren't supported at all, but they may
> still have to deal with -EOPNOTSUPP on supported transactions. This i=
s
> handled on a case-by-case basis.
>
> It could be argued that the I2C_FUNC_* flags aren't really necessary
> and drivers could simply try what they need and deal with -EOPNOTSUPP
> afterward. This is correct but it would probably make the driver code
> more complex in most cases.

What about adding a field/function i2c_xfer_maxlen to struct i2c_algort=
ihm ?
It would also be useful for i2c_smbus_xfer_emulated, which can do a muc=
h
better emulation with this information.

Regards,
=46rank
