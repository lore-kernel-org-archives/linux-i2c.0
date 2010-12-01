From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Antw: Re: Need help to fix some issues with the linux driver
	 "i2c-gpio"
Date: Wed, 01 Dec 2010 09:55:02 +0100
Message-ID: <4CF61B76020000AA000080D7@center.bmk-electronics.de>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
 <AANLkTik9rHn0QE3MzD-yViMPw2hm0VpFRjch-hf6n_xZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTik9rHn0QE3MzD-yViMPw2hm0VpFRjch-hf6n_xZ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thank you for the fast reply.
=20
I checked the clock speed, It can be changed in the specified limits
for MLX90614 with similar results in the data output.
=20
Using an I2C analyzer I was able to see that SCL stretching occures on
unpredictable times. If these SCL stretching is on specific point in th=
e
communication process or match the one of the SMbus timeout condition
unpredictable data is output, with out any error from the I2C subsystem=
=2E
Only the "i2c-adapter i2c-0: sendbytes: NAK bailout." message is
correctly thrown.
=20
best regards
Matthias Zacharias
matthias.zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org=20

>>> Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org> 30.11.2010 17:44 >>>
Is the i2c clock speed in spec with the slave part(s)?

I have seen weird things happen when the clock speed is wrong,
especially when it's too fast...



b.g.
--=20
Bill Gatliff
bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org

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
