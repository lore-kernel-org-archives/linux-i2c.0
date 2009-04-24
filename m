From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: fix bit algorithm timeout for low values.
Date: Fri, 24 Apr 2009 11:42:59 +0200
Message-ID: <20090424114259.70f74ccd@hyperion.delvare>
References: <1240528153-5370-1-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755371AbZDXJnW@vger.kernel.org>
In-Reply-To: <1240528153-5370-1-git-send-email-airlied@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, Dave Airlie <airlied@redhat.com>
List-Id: linux-i2c@vger.kernel.org

Hi Dave,

On Fri, 24 Apr 2009 09:09:13 +1000, Dave Airlie wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> When fetching DDC using i2c algo bit, we were often seeing timeouts
> before getting valid EDID on a retry. The VESA spec states 2ms is the
> DDC timeout, so when this translates into 1 jiffie and we are close
> to the end of the time period, it could return with a timeout less than
> 2ms.
> 
> Change this code to use time_after instead of time_after_eq.
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/i2c/algos/i2c-algo-bit.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> index d420cc5..e25e139 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -104,7 +104,7 @@ static int sclhi(struct i2c_algo_bit_data *adap)
>  		 * chips may hold it low ("clock stretching") while they
>  		 * are processing data internally.
>  		 */
> -		if (time_after_eq(jiffies, start + adap->timeout))
> +		if (time_after(jiffies, start + adap->timeout))
>  			return -ETIMEDOUT;
>  		cond_resched();
>  	}

Applied, thanks. I agree this should go in stable.

-- 
Jean Delvare
