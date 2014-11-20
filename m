From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V2] ACPI: Add _DEP(Operation Region Dependencies) support
 to fix battery issue on the Asus T100TA
Date: Thu, 20 Nov 2014 16:27:30 +0200
Message-ID: <20141120142730.GP1309@lahna.fi.intel.com>
References: <1416492733-18597-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416492733-18597-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shigorin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, adamw-cfjF3rc+CpsYNetmKr+vY16hYfS7NtTn@public.gmane.org, jan.brummer-sgYkR6nYkOfYtjvyW6yDsg@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 20, 2014 at 10:12:12PM +0800, Lan Tianyu wrote:
> ACPI 5.0 introduces _DEP to designate device objects that OSPM should
> assign a higher priority in start ordering due to future operation region
> accesses.
> 
> On Asus T100TA, ACPI battery info are read from a I2C slave device via
> I2C operation region. Before I2C operation region handler is installed,
> battery _STA always returns 0. There is a _DEP method of designating
> start order under battery device node.
> 
> This patch is to implement _DEP feature to fix battery issue on the Asus T100TA.
> Introducing acpi_dep_list and adding dep_unmet count in the struct
> acpi_device. During ACPI namespace scan, create struct acpi_dep_data for a
> valid pair of master (device pointed to by _DEP)/slave(device with _DEP), record
> master's and slave's ACPI handle in it and put it into acpi_dep_list. The dep_unmet
> count will increase by one if there is a device under its _DEP. Driver's probe() should
> return EPROBE_DEFER when find dep_unmet is larger than 0. When I2C operation
> region handler is installed, remove all struct acpi_dep_data on the acpi_dep_list
> whose master is pointed to I2C host controller and decrease slave's dep_unmet.
> When dep_unmet decreases to 0, all _DEP conditions are met and then do acpi_bus_attach()
> for the device in order to resolve battery _STA issue on the Asus T100TA.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=69011
> Tested-by: Jan-Michael Brummer <jan.brummer-sgYkR6nYkOfYtjvyW6yDsg@public.gmane.org>
> Tested-by: Adam Williamson <adamw-cfjF3rc+CpsYNetmKr+vY16hYfS7NtTn@public.gmane.org>
> Tested-by: Michael Shigorin <shigorin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Looks good to me now,

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
