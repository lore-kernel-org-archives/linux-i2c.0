From: Joan Pau Beltran <joanpau.beltran-i5CWTa81U/w@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Wed, 21 Dec 2011 18:02:37 +0100
Message-ID: <4EF2112D.6080607@uib.cat>
References: <4D0B9C35.5000802@uib.cat> <AANLkTi=LQ56S43=BL8tdo=MakP-PRzVK0ieJM07y_O_1@mail.gmail.com> <4D14C6D1.3030802@uib.cat> <AANLkTinSuVYAVQqPHRtrnTPrtEZA1aCHOb6X4H8u2OW1@mail.gmail.com> <4D1A0A95.7020408@uib.cat> <20110106162213.4e5ee5b4@endymion.del vare> <4D274E8B.8050600@uib.cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D274E8B.8050600-i5CWTa81U/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Giampaolo Bellini <iw2lsi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

This mail is to let everybody notice that since kernel version 3.1, the=
=20
pca953x module handles properly the chip WITHOUT the need of platform=20
specific data. This means that, from user space, you can manage the pin=
s=20
through the /sys/class/gpio interface (provided by kernel's gpiolib=20
framework) without building a new kernel with the platform code. You=20
just need to read / write to the correct files. E.g.

# Register the chip on the proper bus.
# A new directory should whose name ends with a chip number N:
#   /sys/class/gpio/gpiochip240
echo pca9555 0x20 > /sys/bus/i2c/devices/i2c-0/new_device

# Request the wanted pin number M on the chip number N (chip number +=20
pin number).
# A new directory should appear:
#   /sys/class/gpio/gpioN+M
echo 240 > /sys/class/gpio/export
echo 241 > /sys/class/gpio/export

# Get the pin state:
cat /sys/class/gpio/gpio240/value

# Set pin direction:
echo 'out' > /sys/class/gpio/gpio241/direction

# Set pin state:
echo '1' > /sys/class/gpio/gpio241/value

Regards,

--=20
Joan Pau Beltran
Grup de Sistemes, Rob=F2tica i Visi=F3 - DMI
Universitat de les Illes Balears
Ctra. Valldemossa, km 7.5 07122 Palma
Campus Universitari, edifici Anselm Turmeda
Telf (+34) 971 17 28 13
=46ax (+34) 971 17 30 03
