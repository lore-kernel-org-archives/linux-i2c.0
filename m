From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Add support for Aeroflex Gaisler I2CMST
 controller
Date: Wed, 16 Feb 2011 16:15:36 +0100
Message-ID: <20110216151536.GB6365@pengutronix.de>
References: <1297859448-6621-1-git-send-email-jan@gaisler.com>
 <20110216142708.GA6365@pengutronix.de>
 <4D5BE45F.5020908@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D5BE45F.5020908-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jan,

> I considered that change more complex and did not think it to be
> worth the trouble for saving ~50 LOC (probably less with added
> glue). Of course, it could be beneficial to have the algo part
> shared if there are future updates to it. At the same time I suppose

Or another core pops up using the same algorithm.

> that it could be bad to have the algo part shared if the updates are
> only valid for one of the cores.

Well, for now it really seems it won't matter much. Plus, we could rip it out
later if needed. OK, thanks for answering.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
