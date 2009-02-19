From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for I2C to complete
Date: Thu, 19 Feb 2009 10:41:30 -0600
Message-ID: <BAA283E5-3730-4534-AA9D-446B3135966F@kernel.crashing.org>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233928837-3401-1-git-send-email-timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Feb 6, 2009, at 8:00 AM, Timur Tabi wrote:

> The i2c_wait() function is using wait_event_interruptible_timeout()  
> to wait for
> the I2C controller to signal that it has completed an I2C bus  
> operation.  If
> the process that causes the I2C operation terminated abruptly, the  
> wait will
> be interrupted, returning an error.  It is better to let the I2C  
> operation
> finished before the process exits.
>
> It is safe to use wait_event_timeout() instead, because the timeout  
> will allow
> the process to exit if the I2C bus hangs.  It's also better to allow  
> the
> I2C operation to finish, because unacknowledged I2C operations can  
> cause the
> I2C bus to hang.
>
> Signed-off-by: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>
> A similar change should probably be done to i2c-cpm.c, and maybe all  
> other
> I2C drivers.  Not many use wait_event_interruptible_timeout().
>
> drivers/i2c/busses/i2c-mpc.c |    9 +++------
> 1 files changed, 3 insertions(+), 6 deletions(-)

applied to next

- k
