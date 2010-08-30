From: =?ISO-8859-1?Q?Rog=E9rio_de_Souza_Moraes?=
	<rogerio.souza-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2C driver modification for BH1710FVC Ambient Light Sensor
Date: Mon, 30 Aug 2010 12:33:26 -0300
Message-ID: <AANLkTinzBkHsLO3TqwoPFb3AjVQ5xziSg_F7wFtB0c0R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi folks,

I am developing a driver for the Ambient Light Sensor BH1710FVC that
communicates by i2c bus. My problem is that the type of message that
this chip accept is this:

S Addr Rd [A] [DataHigh] A [DataLow] NA P

I searched in the file "Documentation/i2c/smbus-protocol" for one
function that communicate like this, but I did not find. I tried to
use the function i2c_smbus_read_byte twice (reading data high first
and so the data low), but the chip do not accept communicate this way.

So I've based in the function i2c_smbus_read_byte to build the
function that implements the protocol like I need.

I modified the file i2c-core.c in the function i2c_smbus_xfer_emulated
creating an I2C_SMBUS_WORD.
In first switch I add:

=A0=A0=A0=A0=A0=A0=A0 case I2C_SMBUS_WORD:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (read_write =3D=3D I2C=
_SMBUS_READ) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m=
sg[0].len =3D 2;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m=
sg[0].flags =3D I2C_M_RD | flags;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n=
um =3D 1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;

and for the second switch I added the following case:

                        case I2C_SMBUS_WORD:
                                data->word =3D msgbuf0[0] | (msgbuf0[1]=
 << 8);
                                break;

After this modification my Ambient Light Sensor driver is working just =
fine.

So I want to know if there is a better way to implement this without
need to modify the i2c driver.

Regards,

Rogerio
