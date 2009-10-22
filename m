From: "Darrick J. Wong" <djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c-scmi: Quirk to work on IBM machines with broken
	BIOSes
Date: Thu, 22 Oct 2009 10:43:04 -0700
Message-ID: <20091022174304.GO26149@tux1.beaverton.ibm.com>
References: <20091020231149.GM26149@tux1.beaverton.ibm.com> <20091021023016.GC32413@crane-desktop> <200910210857.13978.bjorn.helgaas@hp.com> <20091021173733.GN26149@tux1.beaverton.ibm.com> <20091022071748.GA17917@crane-desktop>
Reply-To: djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091022071748.GA17917@crane-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 22, 2009 at 03:17:53PM +0800, Crane Cai wrote:

> This patch below represents my meanings:
> *) add a new HID for IBM SMBus CMI devices
> *) add methods for IBM SMBus CMI devices as you did
> *) hook different HID with different control methods set
> It may be more smooth for i2c-scmi, please consider.

Looks fine to me.

I still need the changes to drivers/acpi/scan.c, but if you push this patch
upstream then I'll reroll my patch as a follow-on to yours...

>  static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
> -	{"SMBUS01", 0},
> +	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
> +	{"SMBUSIBM", (kernel_ulong_t)&ibm_smbus_methods},

...with the custom HID string #define'd in a header file someplace.

Actually, if you'll add a Signed-off-by line to your patch, I'll submit both of
them as a patchset and save you a little work. :)

> +	for (; id->id[0]; id++)

Stylistic nit--would it be clearer to initialize id in the for loop instead of
at the beginning of the function?

--D
