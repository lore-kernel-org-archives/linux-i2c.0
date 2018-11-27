From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Date: Tue, 27 Nov 2018 21:27:46 +0200
Message-ID: <20181127192746.GZ10650@smile.fi.intel.com>
References: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
 <20181127153728.47866-6-andriy.shevchenko@linux.intel.com>
 <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 27, 2018 at 05:14:06PM +0100, Hans de Goede wrote:
> On 27-11-18 16:37, Andy Shevchenko wrote:
> > The caller would like to know the reason why the i2c_acpi_new_device() fails.
> > For example, if adapter is not available, it might be in the future and we
> > would like to re-probe the clients again. But at the same time we would like to
> > bail out if the error seems unrecoverable, such as invalid argument supplied.
> > To achieve this, return error pointer in some cases.

> >   	acpi_dev_free_resource_list(&resource_list);
> > -	if (ret < 0 || !info->addr)
> > -		return NULL;
> > +	if (!info->addr)
> > +		return ERR_PTR(-EADDRNOTAVAIL);
> >   	adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
> >   	if (!adapter)
> > -		return NULL;
> > +		return ERR_PTR(-ENODEV);

> Why not simply return -EPROBE_DEFER here (and simplify the callers a lot).

> This is the only case where we really want to defer.

> > +	client = i2c_new_device(adapter, info);
> > +	if (!client)
> > +		return ERR_PTR(-ENODEV);
> 
> If you look at i2c_new_device, it can fail because it is
> out of memory, the i2c slave address is invalid, or
> their already is an i2c slave with the same address,
> iow if this were to return an ERR_PTR itself, this
> would return -ENOMEM, -EINVAL or -EBUSY and never
> -EPROBE_DEFER.

It would change the behaviour.

In any case, it's only two users and both written by you, so, just to be sure
you aware of this change and bless it.

-- 
With Best Regards,
Andy Shevchenko
