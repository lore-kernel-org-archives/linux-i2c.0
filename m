From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH]i2c-dev: add ioctls PROBE and REMOVE
Date: Fri, 27 Mar 2009 15:07:16 +0100
Message-ID: <20090327150716.094666d1@hyperion.delvare>
References: <49CB43E0.2050503@gmx.de>
	<49CCA82F.90106@gmx.de>
	<20090327134034.754908b5@hyperion.delvare>
	<49CCD0FC.9030500@gmx.de>
	<20090327145726.13c99aed@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090327145726.13c99aed-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 27 Mar 2009 14:57:26 +0100, Jean Delvare wrote:
> On Fri, 27 Mar 2009 14:13:32 +0100, Michael Lawnick wrote:
> > What is your time line?
> 
> Getting rid of the legacy binding model has higher priority and is far
> from being done. I also must take care of Rodolfo's multiplexer
> support, which a lot of people have been asking for, and which might as
> well be what you really need. The above interface comes next, I can't
> give it higher priority as the same can already be achieved today using
> module parameters for most drivers.

BTW, if you don't want your problem to be overlooked, I strongly
suggest that you create yourself a wiki account on
http://i2c.wiki.kernel.org/, create a page describing the problem and
its proposed solution, and link to it from the "Work in progress"
section.

-- 
Jean Delvare
