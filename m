From: Bryan Evenson <bevenson@melinkcorp.com>
Subject: RE: Error using at91-i2c driver in kernel 4.4.x
Date: Wed, 24 May 2017 18:35:27 +0000
Message-ID: <DM5PR05MB29541B7EC525C8438538352ABBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
References: <DM5PR05MB2954708999EFB8F1B593BC93BBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-dm3nam03on0115.outbound.protection.outlook.com ([104.47.41.115]:43555
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753792AbdEXSfa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 May 2017 14:35:30 -0400
In-Reply-To: <DM5PR05MB2954708999EFB8F1B593BC93BBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bryan Evenson <bevenson@melinkcorp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ludovic Desroches <ludovic.desroches@atmel.com>

All,

> -----Original Message-----
> From: linux-i2c-owner@vger.kernel.org [mailto:linux-i2c-
> owner@vger.kernel.org] On Behalf Of Bryan Evenson
> Sent: Wednesday, May 24, 2017 2:18 PM
> To: linux-i2c@vger.kernel.org
> Cc: Wolfram Sang <wsa@the-dreams.de>; Ludovic Desroches
> <ludovic.desroches@atmel.com>
> Subject: Error using at91-i2c driver in kernel 4.4.x
>=20
>=20
> I have been using kernel version 3.10.x for a couple years and I am in th=
e
> process of upgrading to kernel version 4.4.  I am using an Atmel
> AT91SAM9G25 and I am using Atmel's stable fork of the kernel at
> github.com/linux4sam/linux-at91.  I last pulled the linux-4.4-at91 branch
> about two weeks ago.  Today I noticed that I can no longer talk to an I2C
> EEPROM that I could with kernel version 3.10.  I verified the EEPROM stil=
l
> worked with kernel version 3.10 on my hardware, updated my kernel, and
> now I can't talk to the EEPROM.
>=20
> First, for the ARM device tree the i2c section looks like this for my bui=
ld:
>=20
>                         i2c0: i2c@f8010000 {
>                                 status =3D "okay";
>=20
>                                 wm8731: wm8731@1a {
>                                         compatible =3D "wm8731";
>                                         reg =3D <0x1a>;
>                                 };
>=20
>                                 ov2640: camera@0x30 {
>                                         compatible =3D "ovti,ov2640";
>                                         reg =3D <0x30>;
>                                         pinctrl-names =3D "default";
>                                         pinctrl-0 =3D <&pinctrl_pck0_as_i=
si_mck
> &pinctrl_sensor_power &pinctrl_sensor_reset>;
>                                         resetb-gpios =3D <&pioA 7 GPIO_AC=
TIVE_LOW>;
>                                         pwdn-gpios =3D <&pioA 13 GPIO_ACT=
IVE_HIGH>;
>                                         clocks =3D <&pck0>;
>                                         clock-names =3D "xvclk";
>                                         assigned-clocks =3D <&pck0>;
>                                         assigned-clock-rates =3D <2500000=
0>;
>                                         status =3D "disabled";
>=20
>                                         port {
>                                                 ov2640_0: endpoint {
>                                                         remote-endpoint =
=3D <&isi_0>;
>                                                         bus-width =3D <8>=
;
>                                                 };
>                                         };
>                                 };
>                                 24c02@50 {
>                                         compatible =3D "atmel,24c02";
>                                         reg =3D <0x50>;
>                                         pagesize =3D <0x08>;
>                                         status =3D "okay";
>                                 };
>                         };
>=20
> I see the following messages in dmesg:
>=20
> [    0.234375] at91_i2c f8010000.i2c: using dma0chan0 (tx) and dma0chan1 =
(rx)
> for DMA transfers
> [    0.234375] at91_i2c f8010000.i2c: AT91 i2c bus driver (hw version: 0x=
402).
> [    0.742187] at24 0-0050: 256 byte 24c02 EEPROM, writable, 8 bytes/writ=
e
> [    1.343750] i2c /dev entries driver
>=20
> To me it appears the i2c driver and the EEPROM driver have been loaded an=
d
> populated.  I see that /dev/i2c-0 and /sys/class/i2c-dev/i2c-0 are popula=
ted
> on my system.  I then try to read all 256 bytes from the EEPROM as follow=
s
> from my C program:
>=20
>     int file;
>     char filename[] =3D "/dev/i2c-0";
>     int addr =3D 0x50;
>     char buf[256];
>     ssize_t readBytes;
>=20
>     /* Open the I2C dev interface file */
>     file =3D open(filename, O_RDWR);
>     if (file < 0)
>     {
>         printf("Can't open device\n");
>         exit(EXIT_FAILURE);
>     }
>=20
>     /* Set the I2C slave address */
>     if (ioctl(file, I2C_SLAVE, addr) < 0)
>     {
>         printf("Can't set slave address - %m\n");
>     }
>=20
>     /* Attempt to read out the entire EEPROM */
>     readBytes =3D read(file, buf, sizeof(buf));
>     if(readBytes !=3D (ssize_t)sizeof(buf))
>     {
>         printf("Only read %d bytes\n - %m", readBytes);
>     }
>     else
>     {
>         /* Do something with the data... */
>     }
>=20
> When I run the above code with the 4.4 kernel running, I get the followin=
g
> output:
>=20
>     Can't set slave address - Device or resource busy
>     Only read -1 bytes - Remote I/O error
>=20
> Any thoughts as to what I should be checking to figure out why i2c isn't
> working for me anymore?

As usual, five minutes after I ask a question I get further.  I tried chang=
ing the ioctl to I2C_SLAVE_FORCE, and now I can talk to my EEPROM.  I'm hap=
py it's now working, but I'm concerned about why I now need to force the sl=
ave address.  Is this because I now need to set things up differently, or i=
s it a problem with the driver?

Thanks,
Bryan

>=20
> Thanks,
> Bryan
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in t=
he body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
