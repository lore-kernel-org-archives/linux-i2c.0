From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c-designware: add Intel Lynxpoint support
Date: Thu, 24 Jan 2013 08:28:46 +0100
Message-ID: <20130124072846.GO8364@nekote.pengutronix.de>
References: <1358418667-4533-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358418667-4533-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 17, 2013 at 12:31:03PM +0200, Mika Westerberg wrote:
> Hi all,
> 
> This series adds support for the Intel Lynxpoint Low Power Subsystem I2C
> controllers. They are compatible with the DesignWare I2C controller.
> 
> Patches [1/4] and [2/4] are fixes that are necessary to get the driver
> working on Lynxpoint.
> 
> Patch [3/4] brings minimal runtime PM support for the designware platform
> driver. This is useful if the PM subsystem/domain implements runtime PM,
> like in case of ACPI.
> 
> Patch [4/4] finally implements ACPI enumeration support for the designware
> platform driver and adds Lynxpoint ACPI IDs.

I can't tell much about ACPI usage, but rest looks good to me. Applied
to next.
