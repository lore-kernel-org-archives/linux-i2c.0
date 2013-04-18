From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] mfd: Kontron PLD mfd driver
Date: Wed, 17 Apr 2013 21:40:53 -0700
Message-ID: <1366260053.28609.66.camel@joe-AO722>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
	 <alpine.LFD.2.02.1304132152320.21884@ionos>
	 <20130418041940.GB7535@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130418041940.GB7535-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Michael Brunner <mibru-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2013-04-17 at 21:19 -0700, Guenter Roeck wrote:
> On Sat, Apr 13, 2013 at 10:38:07PM +0200, Thomas Gleixner wrote:
> > > + return kempld_read8(pld, index) | kempld_read8(pld, index+1) << 8;
> >                                                         index + 1)
> > Please
> Wondering .... why does checkpatch not report those ?

because checkpatch doesn't care about spacing around
arithmetic as long as it's consistent.

Documentation/CodingStyle doesn't say anything about
it either.

Look around checkpatch line 2654

                                } elsif ($op eq '<<' or $op eq '>>' or
                                         $op eq '&' or $op eq '^' or $op eq '|' or
                                         $op eq '+' or $op eq '-' or
                                         $op eq '*' or $op eq '/' or
                                         $op eq '%')
                                {
                                        if ($ctx =~ /Wx[^WCE]|[^WCE]xW/) {
                                                ERROR("SPACING",
                                                      "need consistent spacing around '$op' $at\n" .
                                                        $hereptr);
                                        }
