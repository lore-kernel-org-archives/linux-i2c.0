From: d binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: i2c/busses/i2c-highlander.c: using char variable in bit operation
Date: Mon, 1 Feb 2010 09:51:42 +0000
Message-ID: <BLU108-W10538CE8A7EF6373FB36AE9C580@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



Hello there,

I just ran the sourceforge tool cppcheck over the source code of the
new Linux kernel 2.6.33-rc6

It said

[./i2c/busses/i2c-highlander.c:284]: (style) Warning - using char varia=
ble in bit operation

The source code is

static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr=
,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned short flags, char read_write,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 command, int size,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 union i2c_smbus_data *data)
{
=A0=A0=A0=A0=A0=A0=A0 struct highlander_i2c_dev *dev =3D i2c_get_adapda=
ta(adap);
=A0=A0=A0=A0=A0=A0=A0 int read =3D read_write & I2C_SMBUS_READ;

In C, chars can be signed or unsigned, so the value written into
local variable read by sign extension is not certain.

Suggest new code

static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr=
,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned short flags, char read_write,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 command, int size,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 union i2c_smbus_data *data)
{
=A0=A0=A0=A0=A0=A0=A0 struct highlander_i2c_dev *dev =3D i2c_get_adapda=
ta(adap);
=A0=A0=A0=A0=A0=A0=A0 int read =3D ((unsigned char) read_write) & I2C_S=
MBUS_READ;


Regards

David Binderman

 		 	   		 =20
_________________________________________________________________
Tell us your greatest, weirdest and funniest Hotmail stories
http://clk.atdmt.com/UKM/go/195013117/direct/01/--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
