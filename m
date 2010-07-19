From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C driver supporting Moorestown and Medfield platform
Date: Mon, 19 Jul 2010 14:32:44 +0200
Message-ID: <20100719143244.2be29ecc@hyperion.delvare>
References: <20100719101724.31685.76712.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100719101724.31685.76712.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alan,

On Mon, 19 Jul 2010 11:17:28 +0100, Alan Cox wrote:
> From: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Initial release of the driver.
> 
> Some clean up table removal by Alan Cox
> 
> Signed-off-by: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/Kconfig    |    9 
>  drivers/i2c/busses/Makefile   |    1 
>  drivers/i2c/busses/i2c-mrst.c |  902 +++++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-mrst.h |  269 ++++++++++++
>  4 files changed, 1181 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-mrst.c
>  create mode 100644 drivers/i2c/busses/i2c-mrst.h

I already reviewed this driver back in June 2009:
http://marc.info/?l=linux-i2c&m=124506668112908&w=2

I hope that all my concerns back then have been addressed?

-- 
Jean Delvare
