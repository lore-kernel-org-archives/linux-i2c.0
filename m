From: =?ISO-8859-1?Q?Frank_Sch=E4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Q: i2c block write emulation / handling of i2c message size constraints
    of a bus ?
Date: Sun, 28 Oct 2012 17:25:19 +0200
Message-ID: <508D4E5F.4070209@googlemail.com>
References: <508BECFE.2010302@googlemail.com> <20121027175030.0474249b@endymion.delvare> <508C009F.30107@googlemail.com> <20121028130301.64f032ff@endymion.delvare> <508D33E0.6070808@googlemail.com> <20121028163342.48bc40aa@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121028163342.48bc40aa-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Am 28.10.2012 17:33, schrieb Jean Delvare:
> Hi Frank,
>
> On Sun, 28 Oct 2012 15:32:16 +0200, Frank Sch=E4fer wrote:
>> Am 28.10.2012 14:03, schrieb Jean Delvare:
>>> On Sat, 27 Oct 2012 18:41:19 +0300, Frank Sch=E4fer wrote:
>>>> What are the correct functionality flags to use in this case ?
>>>> I2C_FUNC_I2C | I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_WOR=
D_DATA ?
>>> If your controller is limited then I2C_FUNC_I2C is most certainly
>>> wrong. From what you described, I'd say:
>>>
>>> I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA
>>>
>>> This doesn't match what Laurent said about SCCB 4 months ago though=
:
>>>
>>> "The read transaction transmits 2 2-byte messages (addr/w, reg,
>>> followed by addr/r, data)."
>>>
>>> You can take a look at Documentation/i2c/smbus-protocol to match
>>> transactions to function names (and from there to I2C_FUNC flags.)
>> Ok, I've been digging deeper into this but still don't understand th=
e
>> meaning of the functionality flags I2C_FUNC_*** with regards to the
>> capabilites of an master_xfer implemetation in struct i2c_algortihm.=
=2E.
>> Are they supposed to describe the smbus operations/methods that can =
be
>> successfully emulated by the smbus layer using i2c_xfer or do they
>> describe the actual capabilities of function master_xfer / the i2c a=
dapter ?
> Most I2C_FUNC_* flags actual refer to the smbus_xfer method. A driver
> implementing master_xfer is typically fully I2C capable and can thus
> run almost any I2C or SMBus transaction. Such a driver will set
> functionality flags to I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL. The rest o=
f
> the flags are for SMBus-only controllers. Each flag basically
> corresponds to an i2c_smbus_*() function, which in turn corresponds t=
o
> the combination of an SMBus transaction type or size and a direction
> (read or write).
>
> The mapping between i2c_smbus_*() functions and functionality flags i=
s
> rather obvious, but for clarity I'll update
> Documentation/i2c/smbus-protocol to mention it. Patch follows.
>
> Also see Documentation/i2c/functionality for a detailed explanation o=
f
> how functionality flags work both on the I2C/SMBus adapter driver and
> the I2C device driver sides.

Ok, so the functionality flags describe whats possible when using the
smbus functions.
That's a bit confusing/misleading if the adapter driver doesn't
implement the smbus_xfer function in struct i2c_algorithm.
And if the i2c adapter / master_xfer fcn has some restrictions (e.g.
data length), things are getting complicated.

I2C_FUNC_SMBUS functionality flags are sufficiently documented, but wha=
t
about I2C_FUNC_I2C ?
Should this be set always if there is a master_xfer function or only if
the adapter is fully i2c compliant (and what does "fully i2c compliant"
mean ?) ?

To summarize: there is no possibilty to determine the maximum i2c data
length when using the i2c_xfer functions directly. It's basically try
and error and if the message is too long, the adapters should return
-EOPNOTSUPP.

Thanks for your explanations,
=46rank
