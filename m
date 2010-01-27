From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Intel ICHx bus driver
Date: Wed, 27 Jan 2010 19:56:02 +0200
Message-ID: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Running i2cdetect on ICH9 says:
"I2C Block Write =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0yes"

But having a closer look at how the whole thing is implemented proves
that no i2c block write is supported.

The proof:
1. i801_probe turns i801_features to FEATURE_I2C_BLOCK_READ
2. as a sequence in i801_block_transaction
i801_block_transaction_byte_by_byte is called
3. on the other hand i801_block_transaction_byte_by_byte does
=A0 =A0if (read_write =3D=3D I2C_SMBUS_WRITE)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(len, SMBHSTDAT0);
meaning SMBus length.

But what if I want to write I2C's multi-block (without length or even
command before)?
I cannot understand why i801_func turns on I2C_FUNC_SMBUS_WRITE_I2C_BLO=
CK?

Thanks,
=46elix R.
