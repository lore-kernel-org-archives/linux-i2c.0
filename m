From: Bryan Evenson <bevenson@melinkcorp.com>
Subject: Error using at91-i2c driver in kernel 4.4.x
Date: Wed, 24 May 2017 18:18:20 +0000
Message-ID: <DM5PR05MB2954708999EFB8F1B593BC93BBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam01on0125.outbound.protection.outlook.com ([104.47.34.125]:46336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933130AbdEXSSW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 May 2017 14:18:22 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ludovic Desroches <ludovic.desroches@atmel.com>

I have been using kernel version 3.10.x for a couple years and I am in the =
process of upgrading to kernel version 4.4.  I am using an Atmel AT91SAM9G2=
5 and I am using Atmel's stable fork of the kernel at github.com/linux4sam/=
linux-at91.  I last pulled the linux-4.4-at91 branch about two weeks ago.  =
Today I noticed that I can no longer talk to an I2C EEPROM that I could wit=
h kernel version 3.10.  I verified the EEPROM still worked with kernel vers=
ion 3.10 on my hardware, updated my kernel, and now I can't talk to the EEP=
ROM.

First, for the ARM device tree the i2c section looks like this for my build=
:

			i2c0: i2c@f8010000 {
				status =3D "okay";

				wm8731: wm8731@1a {
					compatible =3D "wm8731";
					reg =3D <0x1a>;
				};

				ov2640: camera@0x30 {
					compatible =3D "ovti,ov2640";
					reg =3D <0x30>;
					pinctrl-names =3D "default";
					pinctrl-0 =3D <&pinctrl_pck0_as_isi_mck &pinctrl_sensor_power &pinctrl=
_sensor_reset>;
					resetb-gpios =3D <&pioA 7 GPIO_ACTIVE_LOW>;
					pwdn-gpios =3D <&pioA 13 GPIO_ACTIVE_HIGH>;
					clocks =3D <&pck0>;
					clock-names =3D "xvclk";
					assigned-clocks =3D <&pck0>;
					assigned-clock-rates =3D <25000000>;
					status =3D "disabled";

					port {
						ov2640_0: endpoint {
							remote-endpoint =3D <&isi_0>;
							bus-width =3D <8>;
						};
					};
				};
				24c02@50 {
					compatible =3D "atmel,24c02";
					reg =3D <0x50>;
					pagesize =3D <0x08>;
					status =3D "okay";
				};
			};

I see the following messages in dmesg:

[    0.234375] at91_i2c f8010000.i2c: using dma0chan0 (tx) and dma0chan1 (r=
x) for DMA transfers
[    0.234375] at91_i2c f8010000.i2c: AT91 i2c bus driver (hw version: 0x40=
2).
[    0.742187] at24 0-0050: 256 byte 24c02 EEPROM, writable, 8 bytes/write
[    1.343750] i2c /dev entries driver

To me it appears the i2c driver and the EEPROM driver have been loaded and =
populated.  I see that /dev/i2c-0 and /sys/class/i2c-dev/i2c-0 are populate=
d on my system.  I then try to read all 256 bytes from the EEPROM as follow=
s from my C program:

    int file;
    char filename[] =3D "/dev/i2c-0";
    int addr =3D 0x50;
    char buf[256];
    ssize_t readBytes;
   =20
    /* Open the I2C dev interface file */
    file =3D open(filename, O_RDWR);
    if (file < 0)
    {
        printf("Can't open device\n");
        exit(EXIT_FAILURE);
    }

    /* Set the I2C slave address */
    if (ioctl(file, I2C_SLAVE, addr) < 0)
    {
        printf("Can't set slave address - %m\n");
    }

    /* Attempt to read out the entire EEPROM */
    readBytes =3D read(file, buf, sizeof(buf));
    if(readBytes !=3D (ssize_t)sizeof(buf))
    {
        printf("Only read %d bytes\n - %m", readBytes);
    }
    else
    {
        /* Do something with the data... */
    }

When I run the above code with the 4.4 kernel running, I get the following =
output:

    Can't set slave address - Device or resource busy
    Only read -1 bytes - Remote I/O error

Any thoughts as to what I should be checking to figure out why i2c isn't wo=
rking for me anymore?

Thanks,
Bryan
