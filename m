From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] mfd: Add basic support for the Congatec CGEB BIOS
 interface
Date: Mon, 20 Feb 2012 17:39:27 +0100
Message-ID: <20120220163927.GY5387@sortiz-mobl>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328102793-4313-2-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sascha,

On Wed, Feb 01, 2012 at 02:26:31PM +0100, Sascha Hauer wrote:
> The Congatec CGEB is a BIOS interface found on some Congatec x86
> modules. It provides access to on board peripherals like I2C busses
> and watchdogs. This driver contains the basic support for accessing
> the CGEB interface and registers the child devices.
After looking at the code, I'm not entirely sure this one belongs to
drivers/mfd/. Have you thought about putting it under arch/x86/platform/ ?
There are similar examples there, like uv or olpc.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
