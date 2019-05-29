From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next,v4 0/2] Enable SFP on ACPI based systems
Date: Wed, 29 May 2019 17:51:32 +0200
Message-ID: <20190529155132.GZ18059@lunn.ch>
References: <20190528230233.26772-1-ruslan@babayev.com>
 <20190529094818.GF2781@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190529094818.GF2781@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ruslan Babayev <ruslan@babayev.com>, wsa@the-dreams.de, linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 29, 2019 at 12:48:18PM +0300, Mika Westerberg wrote:
> On Tue, May 28, 2019 at 04:02:31PM -0700, Ruslan Babayev wrote:
> > Changes:
> > v2:
> > 	- more descriptive commit body
> > v3:
> > 	- made 'i2c_acpi_find_adapter_by_handle' static inline
> > v4:
> > 	- don't initialize i2c_adapter to NULL. Instead see below...
> > 	- handle the case of neither DT nor ACPI present as invalid.
> > 	- alphabetical includes.
> > 	- use has_acpi_companion().
> > 	- use the same argument name in i2c_acpi_find_adapter_by_handle()
> > 	  in both stubbed and non-stubbed cases.
> > 
> > Ruslan Babayev (2):
> >   i2c: acpi: export i2c_acpi_find_adapter_by_handle
> >   net: phy: sfp: enable i2c-bus detection on ACPI based systems
> 
> For the series,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Mika

Are you happy for the i2c patch to be merged via net-next?

    Andrew
