From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] drivers/misc/akm8975: Add compass sensor driver
Date: Fri, 27 Aug 2010 08:16:30 +0200
Message-ID: <20100827081630.25e6da34@hyperion.delvare>
References: <1282872717-12228-1-git-send-email-achew@nvidia.com>
	<20100826191037.abdf65e5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100826191037.abdf65e5.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 26 Aug 2010 19:10:37 -0700, Andrew Morton wrote:
> > From: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > 
> > This is for the Asahi Kasei's I2C compass sensor AK8975.
> > 
> > Signed-off-by: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/misc/Kconfig    |    8 +
> >  drivers/misc/Makefile   |    1 +
> >  drivers/misc/akm8975.c  |  670 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/akm8975.h |   87 ++++++
> >  4 files changed, 766 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/misc/akm8975.c
> >  create mode 100644 include/linux/akm8975.h
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 26386a9..9bb3d03 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -304,6 +304,14 @@ config SENSORS_TSL2550
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called tsl2550.
> >  
> > +config SENSORS_AK8975
> > +	tristate "AK8975 compass support"
> > +	default n
> > +	depends on I2C
> > +	help
> > +	  If you say yes here you get support for Asahi Kasei's
> > +	  orientation sensor AK8975.
> 
> Should it be in drivers/hwmon?
> 
> Perhaps not, given that drivers/misc/hmc6352.c is in drivers/misc/

No, this driver doesn't implement any standard hwmon attribute, so it
doesn't belong to drivers/hwmon. drivers/misc/ seems OK, until either
the IIO subsystem emerges, or someone creates a compass subsystem.

-- 
Jean Delvare
