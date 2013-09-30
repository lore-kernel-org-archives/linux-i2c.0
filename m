From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3] i2c: enable runtime PM for I2C adapter devices
 enumerated from ACPI
Date: Mon, 30 Sep 2013 21:59:07 +0300
Message-ID: <20130930185907.GS28875@intel.com>
References: <1380552228-23329-1-git-send-email-mika.westerberg@linux.intel.com>
 <1380552228-23329-2-git-send-email-mika.westerberg@linux.intel.com>
 <34540715.4ajYlpge4D@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <34540715.4ajYlpge4D-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 30, 2013 at 07:20:59PM +0200, Rafael J. Wysocki wrote:
> > +static void acpi_i2c_device_pm_get(struct i2c_client *client)
> > +{
> > +	struct i2c_adapter *adap = client->adapter;
> > +
> > +	/* Make sure the adapter is active */
> > +	if (ACPI_HANDLE(adap->dev.parent))
> > +		pm_runtime_get_sync(&adap->dev);
> > +	if (ACPI_HANDLE(&client->dev))
> > +		acpi_dev_pm_attach(&client->dev, true);
> 
> It would be sufficient to do
> 
> 	if (ACPI_HANDLE(&client->dev)) {
> 		pm_runtime_get_sync(&adap->dev);
> 		acpi_dev_pm_attach(&client->dev, true);
> 	}
> 
> here (and below), because I don't think the client with an ACPI handle and the
> parent without one is extremely unlikely (to the point of non-existence
> actually ;-)).  And even if something like that happens, then we only enable
> runtime PM for the adapter if the parent has an ACPI handle, so it still should
> be OK.

OK, I'll change that in the next revision. 

> Apart from this the patch looks good to me.

Thanks!
