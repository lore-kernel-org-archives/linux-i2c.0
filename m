From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: RFD: Illegal code in lm75.c (and other drivers?)
Date: Wed, 11 Mar 2009 12:30:31 +0100
Message-ID: <gp87cn$vj6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

Request For Discussion

I've already patched lm75.c for me in kernel 2.6.26.6, now I find the
same code again in 2.6.28.7:

> 	/* Now, we do the remaining detection. There is no identification-
> 	   dedicated register so we have to rely on several tricks:
> 	   unused bits, registers cycling over 8-address boundaries,
> 	   addresses 0x04-0x07 returning the last read value.
> 	   The cycling+unused addresses combination is not tested,
> 	   since it would significantly slow the detection down and would
> 	   hardly add any value. */
> 	if (kind < 0) {
> 		int cur, conf, hyst, os;
>=20
> 		/* Unused addresses */
> 		cur =3D i2c_smbus_read_word_data(new_client, 0);
> 		conf =3D i2c_smbus_read_byte_data(new_client, 1);
> 		hyst =3D i2c_smbus_read_word_data(new_client, 2);
> 		if (i2c_smbus_read_word_data(new_client, 4) !=3D hyst
> 		 || i2c_smbus_read_word_data(new_client, 5) !=3D hyst
> 		 || i2c_smbus_read_word_data(new_client, 6) !=3D hyst
> 		 || i2c_smbus_read_word_data(new_client, 7) !=3D hyst)
> 			return -ENODEV;
>
> 		os =3D i2c_smbus_read_word_data(new_client, 3);
> 		if (i2c_smbus_read_word_data(new_client, 4) !=3D os
> 		 || i2c_smbus_read_word_data(new_client, 5) !=3D os
> 		 || i2c_smbus_read_word_data(new_client, 6) !=3D os
> 		 || i2c_smbus_read_word_data(new_client, 7) !=3D os)
> 			return -ENODEV;
>=20
> 		/* Unused bits */
> 		if (conf & 0xe0)
> 			return -ENODEV;
>=20
> 		/* Addresses cycling */
> 		for (i =3D 8; i < 0xff; i +=3D 8)
> 			if (i2c_smbus_read_byte_data(new_client, i + 1) !=3D conf
> 			 || i2c_smbus_read_word_data(new_client, i + 2) !=3D hyst
> 			 || i2c_smbus_read_word_data(new_client, i + 3) !=3D os)
> 				return -ENODEV;
> 	}
>=20

LM75 Manual (National Semiconductors, April 2001) states on page 10:
> 1.11 POINTER REGISTER
> (Selects which registers will be read from or written to):
>           +--+--+--+--+--+--+----+----+
> |P7|P6|P5|P4|P3|P2| P1 | P0 |
> +--+--+--+--+--+--+----+----+
> | 0| 0| 0| 0| 0| 0|Register |
> |  |  |  |  |  |  | Select  |
> +--+--+--+--+--+--+----+----+
>=20
> P0-P1: Register Select:
>           +--+--+------------------------------------------+
>           |P1|P0|Register                                  |
>           +--+--+------------------------------------------+
>           | 0| 0|Temperature (Read only) (Power-up default)|
>           +--+--+------------------------------------------+
>           | 0| 1|Configuration (Read/Write)                |
>           +--+--+------------------------------------------+
>           | 1| 0|THYST (Read/Write)                        |
>           +--+--+------------------------------------------+
>           | 1| 1|TOS (Read/Write)                          |
>           +--+--+------------------------------------------+
>=20
> P2=E2=80=93P7: Must be kept zero.

Therefore the above code does illegal actions. It tries to access
offsets, that are not allowed.
The code may work on system with SMBUS controllers, but it does not (on
all) systems with IIC:
Already the offset-write phase fails (NACK from LM75) and so
i2c_smbus_read_byte_data() returns with an error code.

My proposal:
reduce LM75 code (and of all other devices that do same illegal things)
to test what is testable:

> 	if (kind < 0) {
> 		/* Check config register for the unused bits to be 0 */
> 		if (i2c_smbus_read_byte_data(new_client, 1) & 0xe0)
> 			return -ENODEV;
>
> 	}
>

Any comments before patch?

--=20
Kind regards,
Michael
