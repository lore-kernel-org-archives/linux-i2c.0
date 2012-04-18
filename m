From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3] i2c: designware: Add support for 16bit register access
Date: Wed, 18 Apr 2012 16:09:04 +0200
Message-ID: <201204181609.05156.sr@denx.de>
References: <1334754101-25802-1-git-send-email-sr@denx.de> <20120418140011.GC19220@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418140011.GC19220-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 18 April 2012 16:00:11 Wolfram Sang wrote:
> On Wed, Apr 18, 2012 at 03:01:41PM +0200, Stefan Roese wrote:
> > The STM SPEAr platform can only access the i2c controller register
> > via 16bit read/write functions. This patch adds support to
> > automatically detect this 16bit access mode.
> > 
> > Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> 
> Even on second thought, I still think checking the upper 16 bits would
> not have hurt much, but I am taking it as is. Applied.

Thanks,
Stefan
