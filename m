From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV3 2/4] OMAP: I2C: Remove the reset in the init path
Date: Thu, 21 Jul 2011 08:30:29 -0700
Message-ID: <87hb6fabxm.fsf@ti.com>
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
	<1311256381-25548-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1311256381-25548-3-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Thu, 21 Jul 2011 19:22:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, balajitk@ti.com, santosh.shilimkar@ti.com
List-Id: linux-i2c@vger.kernel.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> The reset in the driver at init is not needed
> anymore as the hwmod framework takes care of
> reseting it.

Agreed, but...

The addition of the new places for reset (after timeout, after error) is
not immediately clear, and not described here at all.

After digging myself (since it wasn't described in the changelog), I see
that since the reset was removed from omap_i2c_init(), which was called
not only during probe, but also after time out and error handling, new
reset calls were added back in those locations.

This is the kind of thing that needs to be thoroughly described in the
changelog so reviewers who are not necessarily experts in this driver
will easily and *quickly* understand what is going on without having to
dig into all the details themselves.

Summary: Descriptive, detailed changelogs are invaluable to
reviewers/maintainers.

Kevin
