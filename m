From: =?ISO-8859-1?Q?Frank_Sch=E4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Q: i2c block write emulation / handling of i2c message size constraints
   of a bus ?
Date: Sun, 28 Oct 2012 15:32:16 +0200
Message-ID: <508D33E0.6070808@googlemail.com>
References: <508BECFE.2010302@googlemail.com> <20121027175030.0474249b@endymion.delvare> <508C009F.30107@googlemail.com> <20121028130301.64f032ff@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121028130301.64f032ff-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am 28.10.2012 14:03, schrieb Jean Delvare:
> Hi Frank,
>
> On Sat, 27 Oct 2012 18:41:19 +0300, Frank Sch=E4fer wrote:
>> Am 27.10.2012 18:50, schrieb Jean Delvare:
>>> On Sat, 27 Oct 2012 17:17:34 +0300, Frank Sch=E4fer wrote:
>>>> the i2c interface of my device is capable of writing 2 bytes (reg =
+
>>>> data) and reading a single data byte only.
>>> Are you talking about an I2C master (controller) here, or a slave
>>> device?
>> It's an em2765 USB-video-bridge with an OV2640 sensor slave.
>> The i2c transfer functions I'm currently working on are not yet in t=
he
>> em28xx driver.
>>
>> I don't know yet if it is a general bus limitation or a client limit=
iation.
>> The procedures are based on reverse-engineering work and the OV2640 =
is
>> the only device we have seen so far.
>> Maybe it has something to do with the fact that the OV2640 uses SCCB=
=2E
> Yes SCCB is apparently very limited in terms of supported transaction
> types. Plus it diverges from the equivalent SMBus transactions in the
> details. Note that we do have support for SCCB since kernel v3.6
> (commit d47726c52122d64253ae56e0fafdb7d0b954e97c by Laurent Pinchart.=
)
>
>> (...)
>> Yes, emulating block reads/writes internally (the em28xx driver in t=
his
>> case) is not the problem.
>> My question was if it makes sense to export the emulation through th=
e
>> i2c subsystem.
> If you do, you'll have to make it flexible enough that it can be used
> by other drivers, such as at24 and eeprom.
>
>>>> What's the right error code to return from the drivers master_xfer
>>>> function if the message length is not supported ? -EMSGSIZE ?
>>> -EOPNOTSUPP, per Documentation/i2c/fault-codes.
>>>
>>> Note that ideally, the slave driver should check the bus functional=
ity
>>> and not try transactions which aren't supported. So returning
>>> -EOPNOTSUPP normally never happens.
>> What are the correct functionality flags to use in this case ?
>> I2C_FUNC_I2C | I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_WORD_=
DATA ?
> If your controller is limited then I2C_FUNC_I2C is most certainly
> wrong. From what you described, I'd say:
>
> I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA
>
> This doesn't match what Laurent said about SCCB 4 months ago though:
>
> "The read transaction transmits 2 2-byte messages (addr/w, reg,
> followed by addr/r, data)."
>
> You can take a look at Documentation/i2c/smbus-protocol to match
> transactions to function names (and from there to I2C_FUNC flags.)
>

Ok, I've been digging deeper into this but still don't understand the
meaning of the functionality flags I2C_FUNC_*** with regards to the
capabilites of an master_xfer implemetation in struct i2c_algortihm...
Are they supposed to describe the smbus operations/methods that can be
successfully emulated by the smbus layer using i2c_xfer or do they
describe the actual capabilities of function master_xfer / the i2c adap=
ter ?

Regards,
=46rank
