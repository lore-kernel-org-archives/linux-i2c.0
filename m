From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Help needed
Date: Mon, 8 Dec 2008 11:42:59 +0100
Message-ID: <20081208114259.6ef784a6@hyperion.delvare>
References: <D6509B586112EA4B98E1AF0B4D58DF3016EA8A4E74@exch-hq.geomant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D6509B586112EA4B98E1AF0B4D58DF3016EA8A4E74-f5hAeJvXNqs9gvzQRsMqH0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dajka =?ISO-8859-15?B?VGFt4XM=?= <tdajka-PYL80EbDKh9BDgjK7y7TUQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Tamas,

On Thu, 27 Nov 2008 21:33:36 +0100, Dajka Tam=C3=A1s wrote:
> Hi all,
>=20
> I=E2=80=99m trying to use a Texas Instruments TMP175 temprature senso=
r on an AT91RM9200 system ( i2c-gpio).
>=20
> The code (part of it):
>=20
> //global vars
> int i2c_handler;
>=20
> int main( int argc, char *argv[] ) {
>     int i=3D0;
>     int value=3D0;
>     int adapter_nr;
>     int err;
>     int funcs;
>     char buf[8];
>=20
>     //we don't have to initialize the I2C, since it's done by the dri=
ver
>=20
>     //opening the device
>     printf("Opening /dev/i2c\n");
>     if ( ( err =3D ( i2c_handler =3D open("/dev/i2c-0",O_RDWR) ) ) < =
0 ) {
>         printf("Error opening /dev/i2c-0! Exiting (%d - %s).\n",err,s=
trerror(errno));
>         exit(1);
>     }
>=20
>     // check for req funcs
>     printf("Getting available IOCTLs\n");
>     // get funcs list
>     if((err =3D ioctl(i2c_handler, I2C_FUNCS, &funcs) < 0)) {
>         printf( "Error eeprom_open: %s\n", strerror(err));
>         exit(1);
>     }
>     CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_BYTE );
>     CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_BYTE );
>     CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_BYTE_DATA );
>     CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_BYTE_DATA );
>     CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_WORD_DATA );
>     CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_WORD_DATA );
>=20
>     printf("Setting slave addr to 0x79\n");
>     if ( ( err =3D ioctl(i2c_handler,I2C_SLAVE,0x79) ) < 0 ) {
>         printf("Error setting SLAVE address! Exiting (%d).\n",err);
>         exit(1);
>     }
>=20
>     value =3D i2c_smbus_read_byte(i2c_handler);
>     if ( value < 0 )
>         fprintf( stderr, "Failed to read from I2C device: %m\n" );
>=20
>     printf("Reading with read\n");
>     if ( read(i2c_handler,buf,1) !=3D 1 ) {
>         printf("Error reading byte! (%s)\n",buf);
>     }
>=20
>     printf("Reading with i2c_read\n");
>     if ( ( value =3D i2c_smbus_read_byte(i2c_handler)) < 0 ) {
>         printf("Error readiny byte! (%d)\n",value);
>     }
>=20
>     printf("Trying direct write!\n");
>     buf[0] =3D 0;
>=20
>     if ( write(i2c_handler,buf,1) !=3D 1 ) {
>         printf("Error writing byte! (%s)\n",buf);
>         return -1;
>     }
>=20
> The result:
> root@(none):/mnt/tmp175# ./tmp175
> Opening /dev/i2c
> Getting available IOCTLs
> Setting slave addr to 0x79
> Failed to read from I2C device: Operation not permitted
> Reading with read
> Error reading byte! (X=E2=80=A0)
> Reading with i2c_read
> Error readiny byte! (-1)
> Trying direct write!
> Error writing byte! ()
>=20
> The =E2=80=99dmesg=E2=80=99 output, since debug messages are turned o=
n:
> i2c-adapter i2c-0: ioctl, cmd=3D0x705, arg=3D0xbee5fde4
> i2c-adapter i2c-0: ioctl, cmd=3D0x703, arg=3D0x79
> i2c-adapter i2c-0: ioctl, cmd=3D0x720, arg=3D0xbee5fd74
> i2c-adapter i2c-0: master_xfer[0] R, addr=3D0x79, len=3D1
> i2c-adapter i2c-0: NAK from device addr 0x79 msg #0
> i2c-dev: i2c-0 reading 1 bytes.
> i2c-adapter i2c-0: master_xfer[0] R, addr=3D0x79, len=3D1
> i2c-adapter i2c-0: NAK from device addr 0x79 msg #0
> i2c-adapter i2c-0: ioctl, cmd=3D0x720, arg=3D0xbee5fd74
> i2c-adapter i2c-0: master_xfer[0] R, addr=3D0x79, len=3D1
> i2c-adapter i2c-0: NAK from device addr 0x79 msg #0
> i2c-dev: i2c-0 writing 1 bytes.
> i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x79, len=3D1
> i2c-adapter i2c-0: NAK from device addr 0x79 msg #0
>=20
> What=E2=80=99s wrong? Am I just lame, or it=E2=80=99s something with =
the device?

Double check the slave address. 0x79 isn't a valid address for the
TMP175 according to the datasheet. The highest possible address is 0x77=
=2E

--=20
Jean Delvare
