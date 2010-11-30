From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Need help to fix some issues with the linux driver "i2c-gpio"
Date: Tue, 30 Nov 2010 11:26:22 +0100
Message-ID: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

** High Priority **

Hello mailing list,

we have to use the linux driver "i2c-gpio" because the "i2c-at91" is
marked as "BROKEN" and for our application it can as well not be used.

Here a brief description of the application:

AT91SAM9261 based embedded system running kernel 2.6.25.4, with Atmel
and our own BSP patches. This system uses both SPI interfaces, one USAR=
T
(for console),  MMC, Sound on SPI and SSC, digital poti for contrast
control and the an chip Frambuffer for a monochrome LCD (QVGA).

On the TWI interface are attached:=20
    the AT24C04 SMB EEPROM,   (@ 0x50)
    two LM84 Temperature sensors  (@ 0x18, 0x19)
    and the Infrared temperature sensor MLX90614 manfactured by
MELEXIS. (@ 0x5A)
Note: The LM84 sensors are not yet operated by the linux kernel.

Now the description of the issue we have with the I2C subsystem:

1. the EEPROM is working fine with "i2c-at91" and the "i2c-gpio"
modules
2. for IR-Sensor MLX90614, a hwmon class linux driver was implemented
by Linutronix on our demand. This driver works fine but delivers
sporadic the error message "i2c-adapter i2c-0: sendbytes: NAK bailout."=
=20
(this message is thrown by the  "i2c-algo-bit" driver), or invalid
temperature values ( near 0xFFFF). The invalid temperature values and a=
s
well the error message appear as reponse on bus timeout situations whic=
h
are not correctly handled by the linux driver. This we find out using a
I2C analyzer. In our opinion these issues come while the i2c
communication is disturbed by other tasks and/or interrupt service
routines (ISR) which extend the SMB clock over the permitted timeouts,
leaving the IR-Sensor in an undefined or erroneous state.

The address mentioned in the driver source "Haavard Skinnemoen
<hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>" invalid (unknown)

Please let us now if somebody can help in fixing the i2c-gpio, or give
us an other name who can help.

Thank you.
With best regards


Matthias Zacharias
Dipl.-Elektroingenieur (Univ)=20
Projektleiter Entwicklung=20



BMK professional electronics GmbH =C2=B7 Werner-von-Siemens-Str. 6 =C2=B7=
 D-86159
Augsburg
Tel: +49(0)821/20788-715=C2=B7 Fax: +49(0)821/20788-721=C2=B7 www.bmk-g=
roupde

--------------------
BMK electronic solutions GmbH
Werner-von-Siemens-Str. 6, Eingang 18 f
D-86159 Augsburg
Tel. +49 (0) 821 / 207 88 - 700
=46ax +49 (0) 821 / 207 88 - 721
info-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org
Gesch=C3=A4ftsf=C3=BChrer: Dipl.-oec. Alois Kn=C3=B6ferle
Sitz: Augsburg
HR-Nr.: B21197
---------------------

Diese E-mail kann vertrauliche Informationen enthalten. Falls Sie diese
E-Mail irrt=C3=BCmlich erhalten haben, informieren Sie bitte unverz=C3=BC=
glich den
Absender und l=C3=B6schen Sie diese E-Mail von jedem Rechner, auch von =
den
Mailservern. Jede Verbreitung des Inhalts, auch die teilweise
Verbreitung, ist in diesem Fall untersagt. Au=C3=9Fer bei Vorsatz oder =
grober
=46ahrl=C3=A4ssigkeit schliessen wir jegliche Haftung f=C3=BCr Verluste=
 oder Sch=C3=A4den
aus, die durch Viren befallene Software oder E-Mails verursacht werden.

This e-mail may contain confidential information. If you received this
e-mail in error, please contact the sender and delete this e-mail from
your computer, including your mailservers. Any dissemination, even
partly, is prohibited. Except in case of gross negligence or wilful
misconduct we accept no liability for any loss or damage caused by
software or e-mail viruses.
