From: Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] ALS: TSL2550 driver move from i2c/chips
Date: Sat, 17 Oct 2009 19:07:20 +0200
Message-ID: <20091017170718.GB10344@nowhere>
References: <4AD9F750.9090800@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4AD9F750.9090800-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Oct 17, 2009 at 05:56:48PM +0100, Jonathan Cameron wrote:
> +static int tsl2550_get_id(void)
> +{
> +	int ret, val;
> +
> +idr_again:
> +	if (unlikely(idr_pre_get(&tsl2550_idr, GFP_KERNEL) == 0))
> +		return -ENOMEM;
> +	spin_lock(&tsl2550_idr_lock);
> +	ret = idr_get_new(&tsl2550_idr, NULL, &val);
> +	if (unlikely(ret == -EAGAIN))
> +		goto idr_again;



That looks like a fair chance to produce a deadlock
by reacquiring the above spinlock.

Also I never see the above lock released later from this
function or its caller.
