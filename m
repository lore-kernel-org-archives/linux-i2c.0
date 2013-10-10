From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] spi: attach/detach SPI device to the ACPI power
 domain
Date: Thu, 10 Oct 2013 09:12:56 +0300
Message-ID: <20131010061256.GB3521@intel.com>
References: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
 <1381327461-10562-4-git-send-email-mika.westerberg@linux.intel.com>
 <20131009175528.GV21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131009175528.GV21581@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 09, 2013 at 06:55:28PM +0100, Mark Brown wrote:
> On Wed, Oct 09, 2013 at 05:04:21PM +0300, Mika Westerberg wrote:
> > If the SPI device is enumerated from ACPI namespace (it has an ACPI handle)
> > it might have ACPI methods that needs to be called in order to transition
> > the device to different power states (such as _PSx).
> 
> Acked-by: Mark Brown <broonie@linaro.org>

Thanks!

> > +	if (ACPI_HANDLE(&spi->dev))
> > +		acpi_dev_pm_attach(&spi->dev, true);
> 
> Though I do wonder if it wouldn't be sensible to push the if () here
> inside acpi_dev_pm_attach() and similarly for _detach().  Terribly
> trivial either way.

Actually, the check is already there in acpi_dev_pm_attach()/detach(). The
above code follows what Rafael did for platform bus previously. I think the
idea is to have visual hint that this is only for ACPI enumerated devices.

If preferred, I can drop the if() checks, though.
