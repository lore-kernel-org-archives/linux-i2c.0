From: Adam Williamson <awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3] ACPI: Add _DEP(Operation Region Dependencies)
 support to fix battery issue on the Asus T100TA
Date: Sun, 23 Nov 2014 20:23:32 -0800
Message-ID: <1416803012.2669.68.camel@redhat.com>
References: <1416748974-24124-1-git-send-email-tianyu.lan@intel.com>
	 <54729A7B.4050007@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54729A7B.4050007-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Li, Aubrey" <aubrey.li-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shigorin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jan.brummer-sgYkR6nYkOfYtjvyW6yDsg@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-11-24 at 10:39 +0800, Li, Aubrey wrote:
> On 2014/11/23 21:22, Lan Tianyu wrote:
> > ACPI 5.0 introduces _DEP to designate device objects that OSPM should
> > assign a higher priority in start ordering due to future operation region
> > accesses.
> > 
> > On Asus T100TA, ACPI battery info are read from a I2C slave device via
> > I2C operation region. Before I2C operation region handler is installed,
> > battery _STA always returns 0. There is a _DEP method of designating
> > start order under battery device node.
> > 
> > This patch is to implement _DEP feature to fix battery issue on the Asus T100TA.
> > Introducing acpi_dep_list and adding dep_unmet count in the struct
> > acpi_device. During ACPI namespace scan, create struct acpi_dep_data for a
> > valid pair of master (device pointed to by _DEP)/slave(device with _DEP), record
> > master's and slave's ACPI handle in it and put it into acpi_dep_list. The dep_unmet
> > count will increase by one if there is a device under its _DEP. Driver's probe() should
> > return EPROBE_DEFER when find dep_unmet is larger than 0. When I2C operation
> > region handler is installed, remove all struct acpi_dep_data on the acpi_dep_list
> > whose master is pointed to I2C host controller and decrease slave's dep_unmet.
> > When dep_unmet decreases to 0, all _DEP conditions are met and then do acpi_bus_attach()
> > for the device in order to resolve battery _STA issue on the Asus T100TA.
> 
> Well, Can we explicitly tied this up with ASUS T100TA in the code?
> If I understand correctly, the assumption in the patch is that the
> battery device only depends on I2C device, which is true on ASUS T100TA,
> but may not on the other platforms.
> 
> This patch does not work on a box I have, on it _DEP contains I2C and GPIO.
> 
> Device (BATC)
>         {
>             Name (_HID, EisaId ("PNP0C0A"))  // _HID: Hardware ID
> --------snip--------
>             Name (_DEP, Package (0x03)  // _DEP: Dependencies
>             {
>                 I2C1,
>                 GPO2,
>                 GPO0
>             })
> 
> Thanks,
> -Aubrey

It certainly works for more than *just* the T100 - fedlet users have
reported working battery status on at least the Miix 2 and Venue 8 Pro
(I can personally confirm it works on the Venue 8 Pro). However, Bastien
Nocera reported failure on an Onda v975w with a slightly earlier version
of the patch in the bug report -
https://bugzilla.kernel.org/show_bug.cgi?id=69011#c58 , "Tested with the
same patch on a Onda v975w, and it tries very hard to detect the battery
but fails."
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
