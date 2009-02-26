From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Thu, 26 Feb 2009 10:42:04 +0100
Message-ID: <20090226104204.21dd9616@hyperion.delvare>
References: <20090225212119.67402391@hyperion.delvare>
	<1235606248-13004-1-git-send-email-daniel@caiaq.de>
	<20090226094857.50d0710d@hyperion.delvare>
	<20090226090651.GA20531@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090226090651.GA20531-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 26 Feb 2009 10:06:51 +0100, Daniel Mack wrote:
> On Thu, Feb 26, 2009 at 09:48:57AM +0100, Jean Delvare wrote:
> > On Thu, 26 Feb 2009 00:57:28 +0100, Daniel Mack wrote:
> > > This patch adds a driver for Intersil's ISL29003 ambient light sensor
> > > device plus some documentation. Inspired by tsl2550.c, a driver for a
> > > similar device.
> > > 
> > > Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> > > ---
> > > Moved the driver to drivers/hwmon
> > > 
> > >  Documentation/hwmon/isl29003 |   62 +++++
> > >  drivers/hwmon/Kconfig        |   10 +
> > >  drivers/hwmon/Makefile       |    1 +
> > >  drivers/hwmon/isl29003.c     |  517 ++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 590 insertions(+), 0 deletions(-)
> > >  create mode 100644 Documentation/hwmon/isl29003
> > >  create mode 100644 drivers/hwmon/isl29003.c
> > 
> > Still no luck, sorry. Light sensors have nothing to do with hardware
> > monitoring.
> 
> I decided to put it there because of 
> 
> config SENSORS_APPLESMC
>         tristate "Apple SMC (Motion sensor, light sensor, keyboard
> 	backlight)"

That driver is in hwmon for the motion sensor, and the temperature
sensors, not the light sensor. That being said I was never happy to see
these accelerometer drivers in hwmon, they don't have much in common
with traditional hardware monitoring chips so they should have their
own subsystem. Or they could go to drivers/mfd as these chips usually
have many functions (as outlined by the above summary line.)

-- 
Jean Delvare
