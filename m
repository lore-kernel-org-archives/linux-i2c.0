From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for I2C
	to complete
Date: Tue, 10 Feb 2009 08:59:57 -0600
Message-ID: <ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233928837-3401-1-git-send-email-timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 6, 2009 at 8:00 AM, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> The i2c_wait() function is using wait_event_interruptible_timeout() to wait for
> the I2C controller to signal that it has completed an I2C bus operation.  If
> the process that causes the I2C operation terminated abruptly, the wait will
> be interrupted, returning an error.  It is better to let the I2C operation
> finished before the process exits.
>
> It is safe to use wait_event_timeout() instead, because the timeout will allow
> the process to exit if the I2C bus hangs.  It's also better to allow the
> I2C operation to finish, because unacknowledged I2C operations can cause the
> I2C bus to hang.
>
> Signed-off-by: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Jean,

Could you pick up this patch for 2.6.30?

-- 
Timur Tabi
Linux kernel developer at Freescale
