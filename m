From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Detect and report NAK right away instead of
	timing out.
Date: Mon, 3 Nov 2008 00:23:28 +0000
Message-ID: <20081103002328.GC30438@fluff.org.uk>
References: <490BA2E5.8010309@consentry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <490BA2E5.8010309-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 31, 2008 at 05:29:25PM -0700, Mike Ditto wrote:
> Make the driver report an ENXIO error immediately upon NAK instead of
> waiting for another interrupt and getting a timeout.
> 
> Signed-off-by: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
> ---
> When reading from a device that is not present or declines to respond
> to, e.g., a non-existent register address, CPM immediately reports a
> NAK condition in the TxBD, but the driver kept waiting until a timeout,
> which takes 1 second and causes an ugly console error message.

hmm, that block of text could probably go into the patch description.

It looks ok, I'll merge and push out to linus with the s3c fixes.
 
> Index: linux/drivers/i2c/busses/i2c-cpm.c
> ===================================================================
> retrieving revision 1.3
> diff -u -p -r1.3 i2c-cpm.c
> --- linux/drivers/i2c/busses/i2c-cpm.c	31 Oct 2008 06:36:08 -0000	1.3
> +++ linux/drivers/i2c/busses/i2c-cpm.c	1 Nov 2008 00:12:45 -0000
> @@ -369,6 +369,7 @@ static int cpm_i2c_xfer(struct i2c_adapt
>  		pmsg = &msgs[tptr];
>  		if (pmsg->flags & I2C_M_RD)
>  			ret = wait_event_interruptible_timeout(cpm->i2c_wait,
> +				(in_be16(&tbdf[tptr].cbd_sc) & BD_SC_NAK) ||
>  				!(in_be16(&rbdf[rptr].cbd_sc) & BD_SC_EMPTY),
>  				1 * HZ);
>  		else
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
