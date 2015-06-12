From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] i2c: octeon: remove unused signal handling
Date: Fri, 12 Jun 2015 14:38:45 +0200
Message-ID: <557AD2D5.2060102@nokia.com>
References: <1434031923-20914-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434031923-20914-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Nicholas Mc Guire <hofrat@osadl.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi!

On 11/06/15 16:12, ext Nicholas Mc Guire wrote:
> 'commit 2637e5fd232d ("i2c: octeon: Fix i2c fail problem when a process is
> terminated by a signal")' removed the wait_event_interruptible_timeout to 
> prevent half/mixed i2c messages from being sent/recievd but forgot to 
> drop the signal handling case in the return handling. This just removes 
> this dead code. While at it the return variable is adjusted to the type 
> expected.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Looks good,

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
> 
> V2: Thanks to Wolfram Sang <wsa@the-dreams.de> for clarifying the intent
>     (and how I should have found this by properly checking the git log).
> 
> Patch was compile tested with cavium_octeon_defconfig
> (implies CONFIG_I2C_OCTEON=y)
> 
> Patch is against 4.1-rc7 (localversion-next is -next-20150611)
> 
>  drivers/i2c/busses/i2c-octeon.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
> index 6e75e01..32914ab 100644
> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -200,7 +200,7 @@ static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
>   */
>  static int octeon_i2c_wait(struct octeon_i2c *i2c)
>  {
> -	int result;
> +	long result;
>  
>  	octeon_i2c_int_enable(i2c);
>  
> @@ -210,10 +210,7 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
>  
>  	octeon_i2c_int_disable(i2c);
>  
> -	if (result < 0) {
> -		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
> -		return result;
> -	} else if (result == 0) {
> +	if (result == 0) {
>  		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
>  		return -ETIMEDOUT;
>  	}

-- 
Best regards,
Alexander Sverdlin.
