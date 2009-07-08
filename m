From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 0/2] davinci i2c fixes for 2.6.31
Date: Wed, 08 Jul 2009 08:44:38 -0700
Message-ID: <87ocrv6uxl.fsf@deeprootsystems.com>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
	<20090707231938.GA9907@fluff.org.uk>
	<87skh79uai.fsf@deeprootsystems.com>
	<A69FA2915331DC488A831521EAE36FE40144D8117B@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A69FA2915331DC488A831521EAE36FE40144D8117B-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org> (Muralidharan Karicheri's message of "Wed\, 8 Jul 2009 10\:25\:24 -0500")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c@vger.kernel.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Murali,

"Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org> writes:

> When we do a video loopback with MT9T031, we get i2c timeouts when
> application is killed using Cntrl C. Is it being addressed in any of
> the patches?  

I don't know, as I have never seen that particular issue.

This series contains various fixes that have already been in DaVinci
git for a while, so if you are still seeing that problem with current
DaVinci git, then an additional patch will be needed.

Kevin
