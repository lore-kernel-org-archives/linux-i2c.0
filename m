From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: Kontron PLD i2c bus driver
Date: Tue, 16 Apr 2013 11:53:09 +0200
Message-ID: <20130416095309.GD16978@the-dreams.de>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
 <1365441321-21952-2-git-send-email-kevin.strasser@linux.intel.com>
 <20130410170212.GB19533@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130410170212.GB19533-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Michael Brunner <mibru-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 10, 2013 at 10:02:12AM -0700, Guenter Roeck wrote:
> On Mon, Apr 08, 2013 at 10:15:19AM -0700, Kevin Strasser wrote:
> > From: Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>
> > 
> > Add i2c support for the on-board PLD found on some Kontron embedded
> > modules.
> > 
> > Signed-off-by: Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Overall well written, though I have a couple of nitpicks.
> 
> I would prefer two separate drivers, one for the mux and one for the i2c bus.
> If that is possible, it would help getting rid of the #ifdef in the code, which
> is frowned upon in the kernel.
> 
> I dislike unnecessary ( ). Maintainer's call, though.
> 
> Couple of places have missing spaces around operators (checkpatch doesn't catch
> all those).
> 
> As far as I know, devm_ functions are supposed to print an error message on
> failure, so it should be unnecessary to print another one if that happens (this
> might need some confirmation).

Haven't done a full review due to tglx NACK. I agree to the points
mentioned here by Guenter, though.
