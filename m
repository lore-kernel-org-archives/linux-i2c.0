From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] I2C: Make I2C core able to be module when I2C_ACPI is
 selected.
Date: Tue, 12 Aug 2014 12:53:21 +0300
Message-ID: <20140812095321.GU1657@lahna.fi.intel.com>
References: <1407740455-21269-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407740455-21269-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 11, 2014 at 03:00:55PM +0800, Lan Tianyu wrote:
> Commit da3c6647(I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI
> config) adds a new kernel config I2C_ACPI and make I2C core built in
> when the config is selected. This is wrong because distributions
> etc generally compile I2C as a module and the commit broken that.
> This patch is to make I2C core able to be a module when I2C_ACPI is
> selected. Original issue the commit da3c6647 tried to avoid will
> be fixed in ACPICA and it's rarely triggered during unloading module. 
> 
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

I wonder if we can do

	depends on I2C=y

here? If I understand it right, then we only build the ACPI_I2C if I2C
is compiled into the kernel. That way the problem da3c6647 tried to
solve doens't re-appear.

We can later on relax this once ACPICA has been fixed. Thoughts?
