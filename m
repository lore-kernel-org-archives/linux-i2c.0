From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] i2c: move acpi code back into the core
Date: Tue, 30 Sep 2014 19:03:52 +0300
Message-ID: <20140930160352.GV1786@lahna.fi.intel.com>
References: <1411594591-5048-1-git-send-email-wsa@the-dreams.de>
 <20140930125520.61b57882@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140930125520.61b57882-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 30, 2014 at 12:55:20PM +0200, Jean Delvare wrote:
> The only thing which I find curious is that ACPI_I2C_OPREGION depends
> on I2C=y. Is this limitation a leftover from when the code was split to
> a separate file? It builds just fine with I2C=m, and I can't see why it
> wouldn't work. I have a patch to enable that, I can send it if it is
> the right thing to do. But maybe I'm missing something?

I think reason for the limitation is that if there happens to be some
AML code that is currently using the I2C operation region and the user
decides to unload the i2c-core.ko module or along those lines.
