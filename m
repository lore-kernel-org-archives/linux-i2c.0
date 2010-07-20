From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: HELP: Interface a CMOS sensor with the DM355 (fwd)
Date: Tue, 20 Jul 2010 15:06:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1007201504190.29807@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ibrahima sakho <ibrahima_sakho-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46orwarding on authors's behalf.

Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/

---------- Forwarded message ----------
Date: Tue, 20 Jul 2010 11:01:36 +0200
=46rom: ibrahima sakho <ibrahima_sakho-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: HELP: Interface a CMOS sensor with the DM355


Hello,

I come towards you because I work at present on the interfacing between=
=20
the demo board DM355 and the CMOS sensor MT9J003 from Micron (Aptina) t=
o=20
make of the video. I use the Arago project for it.

The problem which I have is situated at the configuration of the I2C bu=
s.=20
Indeed, the register address of the CMOS sensor MT9J003 is on 16 bits a=
nd=20
I do not succeed in communicating via this bus. I am parit of the drive=
r=20
that you developed for the MT9T031, but without succ=E9s. The communica=
tion=20
with the sensor is of this kind:

I2C Block Read (2 Comm bytes)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

 =20
This command reads a block of bytes from a device, from a=20
designated register that is specified through the two Comm byte.

S Addr Wr [A] Comm1 [A] Comm2 [A] S Addr Rd [A] [Data] A [Data] A ... A=
 [Data] NA P

Is this I2C function  implemented in the I2C module ?=20

May I use Arago project to manage to configure this I2C communication ?=
 I=20
shall really need your help and your councils.

I thank you beforehand.=20

Ibrahima SAKHO

 		 	   		 =20
_________________________________________________________________
Le nouveau Hotmail est presque arriv=E9, ne le manquez pas !
http://www.windowslive.fr/nouveau-hotmail/
