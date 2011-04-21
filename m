From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] misc: Driver for Silicon Labs Si570 and compatibles
Date: Thu, 21 Apr 2011 18:23:21 +0200
Message-ID: <201104211823.21384.arnd@arndb.de>
References: <1303248968-5069-1-git-send-email-guenter.roeck@ericsson.com> <201104211311.25988.arnd@arndb.de> <20110421155658.GA28245@ericsson.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110421155658.GA28245-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: "Hans J. Koch" <hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 21 April 2011 17:56:58 Guenter Roeck wrote:
> On Thu, Apr 21, 2011 at 07:11:25AM -0400, Arnd Bergmann wrote:
> > On Wednesday 20 April 2011, Guenter Roeck wrote:
> > 
> > Isn't that what you'd normally call a 'struct clk' then?
> > 
> Yes, it would be nice to have that as part of the kernel and not architecture
> specific.

I think the generalization of the ARM code is currently being worked
on, so this should be there soon.

	Arnd
