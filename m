From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: configure SDA hold time from ACPI
Date: Wed, 10 Jul 2013 17:20:15 +0300
Message-ID: <20130710142015.GD4898@intel.com>
References: <1372845160-32625-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372845160-32625-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 03, 2013 at 12:52:40PM +0300, Mika Westerberg wrote:
> Some Intel LPSS I2C devices make the SDA hold time parameter available via
> SSCN (standard mode) and FMCN (fast mode) ACPI methods. If we find that
> such method exist, we evaluate it and pass the returned SDA hold value to
> the i2c-designware core analogous to Device Tree.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Please disregard this patch. I'll send a new one that combines both setting of
SDA hold time and *CNT values from ACPI.
