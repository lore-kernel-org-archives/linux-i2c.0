From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-bfin-twi: integrate
	timeout timer withcompletion interface
Date: Fri, 9 Oct 2009 12:49:35 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04D6FC09@chinexm1.ad.analog.com>
References: <1254973096-4391-1-git-send-email-vapier@gentoo.org>
	<20091008093817.GB6112@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20091008093817.GB6112-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Yes, jiffies is used in this patch for timeout value.

Sonic 

-----Original Message-----
From: Wolfram Sang [mailto:w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org] 
Sent: Thursday, October 08, 2009 5:38 PM
To: Mike Frysinger
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ben Dooks;
uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org; Zhang, Sonic
Subject: Re: [PATCH 1/2] i2c-bfin-twi: integrate timeout timer
withcompletion interface

On Wed, Oct 07, 2009 at 11:38:15PM -0400, Mike Frysinger wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> There isn't much point in managing our own custom timeout timer when 
> the completion interface already includes support for it.  This makes 
> the resulting code much simpler and robust.

This sounds like a good thing to do, but keep in mind that
adapter->timeout values should be in jiffies (see
8a52c6b4d55b2960d93a90a7cf6afd252357fa54).

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang
|
Industrial Linux Solutions                 | http://www.pengutronix.de/
|
