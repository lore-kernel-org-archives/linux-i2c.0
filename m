From: =?UTF-8?B?Um9iaW4gTcO8bGxlci1CYWR5?= <mueller-bady-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
Subject: Writing I2C Sensor Kernel Modules
Date: Thu, 27 Jun 2013 20:12:57 +0200
Message-ID: <CACRdhnBAMzjATrftkD4a8LoUfx6quUifTP2R_QHCwcmN1b8e-w@mail.gmail.com>
References: <CACRdhnDOKdfFSPKmBZ=BoEfp4Tk3dur539b+eHw_bxm23H0rsQ@mail.gmail.com>
 <51CC52BB.5000302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51CC52BB.5000302-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

this iio subsystem is a good hint.
Thank you both very much!

Regards,
Robin

Am 27.06.2013 16:57 schrieb "Sylwester Nawrocki" <s.nawrocki-Sze3O3UU22KIwRZHo2/mJg@public.gmane.org=
m>:
>
> Hi,
>
> On 06/27/2013 04:33 PM, Robin M=C3=BCller-Bady wrote:
> > I have a (architectural design) question about I2C drivers in kerne=
l space.
> > Currently, I'm writing userspace software for using external sensor=
s
> > on an raspberry pi via bcm2835's I2C bus with the help of
> > wiringPi/ioctl, e.g. the barometric pressure with the MPL115A2 sens=
or.
>
> AFAIK the IIO framework should be use nowadays sensors like this one.
> Unfortunately I'm not aware of any detailed documentation of this
> subsystem. This presentation [1] might be helpful.
>
> I think you could get some help asking on linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> mailing list.
>
> > I now had the idea to write the software directly in kernel space,
> > providing a device, e.g. /dev/mpl115a2, for polling the sensor data=
=2E
> > Does this idea fit into the architectural design of the I2C subsyst=
em
> > / the sensors ? Or should code for handling I2C clients stay in
> > userspace?
> > Is there any good documentation for writing such drivers except the
> > kernel Documentation? I found some information in the kernel wiki
> > which is unfortunately not that detailed.
>
> [1] http://tinyurl.com/o6yxwrm
>
> Regards,
> Sylwester
>
