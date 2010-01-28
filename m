From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Thu, 28 Jan 2010 08:59:04 +0100
Message-ID: <20100128085904.4e202de1@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01001270956h781f2832r928364574d3406aa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Felix,

On Wed, 27 Jan 2010 19:56:02 +0200, Felix Rubinstein wrote:
> Running i2cdetect on ICH9 says:
> "I2C Block Write =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0yes"
>=20
> But having a closer look at how the whole thing is implemented proves
> that no i2c block write is supported.
>
> The proof:
> 1. i801_probe turns i801_features to FEATURE_I2C_BLOCK_READ

Yes it does, but this is totally unrelated to I2C block _writes_.

> 2. as a sequence in i801_block_transaction
> i801_block_transaction_byte_by_byte is called

No. Read the code again, for the ICH9, i801_block_transaction_by_block
is called, not i801_block_transaction_byte_by_byte.

> 3. on the other hand i801_block_transaction_byte_by_byte does
> =C2=A0 =C2=A0if (read_write =3D=3D I2C_SMBUS_WRITE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outb_p(len, SMBHSTDA=
T0);
> meaning SMBus length.

This is correct, and as a matter of fact,
i801_block_transaction_by_block does the same. And this is the right
thing to do: the SMBus controller must know how many bytes it must send
to the target slave.

> But what if I want to write I2C's multi-block (without length or even
> command before)?

I have no idea what you mean with "I2C's multi-block". Please be
specific.

> I cannot understand why i801_func turns on I2C_FUNC_SMBUS_WRITE_I2C_B=
LOCK?

Because it supports that transaction type. Why would you want it to not
advertise a transaction type it supports?

Please refer to Documentation/i2c/smbus-protocol for what exactly each
supported transaction type is doing at the wire level.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html
