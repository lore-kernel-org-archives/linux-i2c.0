From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Add support for Aeroflex Gaisler I2CMST
 controller
Date: Wed, 16 Feb 2011 15:27:08 +0100
Message-ID: <20110216142708.GA6365@pengutronix.de>
References: <1297859448-6621-1-git-send-email-jan@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1297859448-6621-1-git-send-email-jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jan,

On Wed, Feb 16, 2011 at 01:30:48PM +0100, Jan Andersson wrote:
> This patch adds support for the I2CMST core found on LEON/GRLIB SoCs.
> 
> Signed-off-by: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
> ---
> The I2CMST core is basically the OpenCores I2C master with an AMBA APB
> interface. This driver re-uses much of i2c-ocores.c. It is submitted as
> a separate driver since the register interfaces differ sligthly. Also the
> two IP cores are maintained separately so they may diverge further in
> the future.
> 
> The driver is identical in terms of transfer handling and HW control.
> The original module author string has been kept.

Just judging from this message, it seems that algo could be extracted and used
by both drivers? Or would this make no sense?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
