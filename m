From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: SMBus quick command problem
Date: Fri, 9 Jan 2009 15:27:52 +0100
Message-ID: <20090109152752.29b3c5de@hyperion.delvare>
References: <ce62e9d00901080101ocfa0388g91698776eb9704cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ce62e9d00901080101ocfa0388g91698776eb9704cb-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabien Marteau <lepingouin.tux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Salut Fabien,

On Thu, 8 Jan 2009 10:01:01 +0100, Fabien Marteau wrote:
> I'm writing a driver for i2c controller. To do it, I'm following the
> SMBus protocol description in linux/Documentation/i2c/SMBus-
> protocol. This documentation say that we can write a single bit with
> =ABSMBus Quick Command=BB. This command is used in i2cdetect program =
to
> find slave on the bus.
>=20
> I used this command to write bit 0 and that work whell with my slaves=
,
> but if I try to write bit 1 the slaves addressed are blocking the bus
> (maintain SDA to 0). I tried it with two slaves components :
> LIS3LV02DL (accelerometer) and DS28CZ04 (EEPROM).
>=20
> Is it a known problem ?

The SMBus specification describes a number of standardized
transactions. Each chip on the bus can support each given transaction
type or not. In practice, each slave chip only supports a subset of the
SMBus specification. I can't remember working on a chip saying it was
supporting the SMBus quick command. The Linux i2c subsystem abuses this
transaction type for device detection purposes, because it is known to
give good results in practice, but ideally it shouldn't do that.

There have been some devices known to lock up the SMBus on Quick
command with data bit =3D 1 (as you are experiencing.) In most cases
these were write-only devices, which didn't expect a transaction
starting like a read (the SMBus specification says that a Quick command
with data bit =3D 1 is writing 1 bit to the slave, but the I2C
specification says this is a _read_ transaction of length 0.)

This SMBus Quick command thing keeps causing trouble and confusing
people. Not much we can do though. If your slaves don't like the quick
command, just don't send that command to them.

> [Erreur de d=E9codage BASE64]

Gni?

--=20
Jean Delvare
