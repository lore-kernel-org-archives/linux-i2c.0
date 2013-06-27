From: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: Re: Writing I2C Sensor Kernel Modules
Date: Thu, 27 Jun 2013 16:41:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1306271637020.26658@pmeerw.net>
References: <CACRdhnDOKdfFSPKmBZ=BoEfp4Tk3dur539b+eHw_bxm23H0rsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRdhnDOKdfFSPKmBZ=BoEfp4Tk3dur539b+eHw_bxm23H0rsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Robin_M=C3=BCller-Bady?= <mueller-bady-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Robin,

> wiringPi/ioctl, e.g. the barometric pressure with the MPL115A2 sensor.
> I now had the idea to write the software directly in kernel space,
> providing a device, e.g. /dev/mpl115a2, for polling the sensor data.
> Does this idea fit into the architectural design of the I2C subsystem
> / the sensors ? Or should code for handling I2C clients stay in

have a look at the IIO subsystem which provides an interface for various 
sensors (adc, light, accelerometer) attached via spi or i2c; pressure was 
very recently added

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
