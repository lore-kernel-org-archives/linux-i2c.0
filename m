From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: always clear interrupts before
 enabling them
Date: Fri, 17 May 2013 10:31:42 +0200
Message-ID: <20130517083139.GC17056@katana>
References: <1368442471-7582-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368442471-7582-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 13, 2013 at 01:54:30PM +0300, Mika Westerberg wrote:
> If the I2C bus is put to a low power state by an ACPI method it might pull
> the SDA line low (as its power is removed). Once the bus is put to full
> power state again, the SDA line is pulled back to high. This transition
> looks like a STOP condition from the controller point-of-view which sets
> STOP detected bit in its status register causing the driver to fail
> subsequent transfers.
> 
> Fix this by always clearing all interrupts before we start a transfer.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-current, thanks! Added stable, too.
