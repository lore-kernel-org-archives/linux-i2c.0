From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [4/7] i2c-designware: use dynamic adapter numbering on Lynxpoint
Date: Tue, 9 Apr 2013 11:06:05 +0200
Message-ID: <20130409090605.GC28509@the-dreams.de>
References: <1363867800-23861-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1363867800-23861-4-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 21, 2013 at 02:09:57AM -0000, Mika Westerberg wrote:
> It is not good idea to mix static and dynamic I2C adapter numbering. In
> this particular case on Lynxpoint we had graphics I2C adapter which took
> the first numbers preventing the designware I2C driver from using the
> adapter numbers it preferred.
> 
> Fix this by switching to use dynamic adapter numbering on Intel Lynxpoint.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

I am fearing regressions here if the bus numbering changes.
