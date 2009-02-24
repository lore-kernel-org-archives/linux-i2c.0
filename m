From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/pca: add PCA9665 support
Date: Tue, 24 Feb 2009 09:36:03 +0100
Message-ID: <20090224093603.66d681e1@hyperion.delvare>
References: <20090221130354.GB16774@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090221130354.GB16774-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sat, 21 Feb 2009 14:03:54 +0100, Wolfram Sang wrote:
> 
> This patch adds support for the PCA9665 I2C controller, originally tested and
> posted by Marco Aurelio da Costa. As he did not resubmit the patch after the
> final review five months ago, I picked it up, made it apply to latest linus-git
> and removed the minor coding-style issues.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
> It still works with my PCA9564, so it surely didn't break anything.
> 
> Marco, if you are still around, it would be nice to get a signed-off from you!
> (I didn't change any code except adding two "\n" and one " " to debug strings)
> 
> Jean, Ben, do you think we can handle it this way? I'd like to see this
> included before the last known working state gets too far off from mainline.
>
>  drivers/i2c/algos/i2c-algo-pca.c      |  180 +++++++++++++++++++++++++++++++---
>  drivers/i2c/busses/Kconfig            |    8 -
>  drivers/i2c/busses/i2c-pca-isa.c      |   14 +-
>  drivers/i2c/busses/i2c-pca-platform.c |    9 -
>  include/linux/i2c-algo-pca.h          |   33 +++++-
>  5 files changed, 216 insertions(+), 28 deletions(-)

Unfortunately I don't have the time to make a full review of this
patch. I don't want to delay its inclusion though, so unless someone
volunteers to review it, I will apply it as is. If any problem is later
reported, you'll have to fix it.

-- 
Jean Delvare
