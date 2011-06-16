From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: static s32 i2c_smbus_xfer_emulated
Date: Thu, 16 Jun 2011 18:44:11 +0200
Message-ID: <20110616184411.7272ca08@endymion.delvare>
References: <BANLkTinS1RA6iQfjZaVOE-q4qCtbt17LPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTinS1RA6iQfjZaVOE-q4qCtbt17LPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kassey Lee <kassey1216-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 14 Jun 2011 14:39:24 +0800, Kassey Lee wrote:
> hi, Jean:
>=20
>=20
> here is the structur of i2c_msg,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 struct i2c_msg {
> =A0=A0=A0=A0=A0=A0=A0 __u16 addr;=A0=A0=A0=A0 /* slave address=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> =A0=A0=A0=A0=A0=A0=A0 __u16 flags;
> #define I2C_M_TEN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0010=A0=
 /* this is a ten bit chip address */
> #define I2C_M_RD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0001=A0=
 /* read data, from slave to master */
> #define I2C_M_NOSTART=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x4000=A0 /* if I=
2C_FUNC_PROTOCOL_MANGLING */
> #define I2C_M_REV_DIR_ADDR=A0=A0=A0=A0=A0 0x2000=A0 /* if I2C_FUNC_PR=
OTOCOL_MANGLING */
> #define I2C_M_IGNORE_NAK=A0=A0=A0=A0=A0=A0=A0 0x1000=A0 /* if I2C_FUN=
C_PROTOCOL_MANGLING */
> #define I2C_M_NO_RD_ACK=A0=A0=A0=A0=A0=A0=A0=A0 0x0800=A0 /* if I2C_F=
UNC_PROTOCOL_MANGLING */
> #define I2C_M_RECV_LEN=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0400=A0 /* length=
 will be first received byte */
> =A0=A0=A0=A0=A0=A0=A0 __u16 len;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /* msg length=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 */
> =A0=A0=A0=A0=A0=A0=A0 __u8 *buf;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /* pointer to msg data=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 */
> };
>=20
> do you think it is better to use __u8 other than unsigned char here ?

What problem are you trying to solve, please?

> thanks
>=20
> static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 a=
ddr,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned short flags,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char read_write, u8 command, int size=
,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 union i2c_smbus_data *data)
> {
> =A0=A0=A0=A0=A0=A0=A0 /* So we need to generate a series of msgs. In =
the case of writing, we
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 need to use only one message; when readin=
g, we need two. We initialize
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 most things with sane defaults, to keep t=
he code below somewhat
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 simpler. */
> =A0=A0=A0=A0=A0=A0=A0 unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
> =A0=A0=A0=A0=A0=A0=A0 unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>=20
> =A0=A0=A0=A0=A0=A0=A0 int num =3D read_write =3D=3D I2C_SMBUS_READ ? =
2 : 1;
> =A0=A0=A0=A0=A0=A0=A0 struct i2c_msg msg[2] =3D { { addr, flags, 1, m=
sgbuf0 },
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 { addr, flags | I2C_M_RD, 0, msgbuf1 }
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 };
>=20
>=20
--=20
Jean Delvare
