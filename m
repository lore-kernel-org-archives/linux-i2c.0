From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv8 03/13] I2C: OMAP: Remove reset at init
Date: Wed, 20 Jun 2012 03:29:05 -0700
Message-ID: <20120620102905.GC12766@atomide.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-4-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1340029828-20751-4-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, w.sang@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

* Shubhrajyoti D <shubhrajyoti@ti.com> [120618 07:35]:
> The reset in the driver at init is not needed anymore as the
> following patch has removed the HWMOD_INIT_NO_RESET flag.
> 6d3c55f [OMAP: hwmod: fix the i2c-reset timeout during bootup]
> 
> This patch does the following
> -removes the reset from the probe and implements a omap_i2c_reset
>  function to reset.
> - Reset is removed from omap_i2c_init, which was called
>  not only during probe, but also after time out and error handling.
>  omap_i2c_reset is added in those places to effect the reset.

See the comments regarding driver specific resets in hwmod code.

The way to set this up is to have a shared inline function in
i2c-omap.h that both the driver and hwmod code can use.

Eventually hwmod code will do the reset only in late initcall
if no driver is loaded for the device in question.

Tony
