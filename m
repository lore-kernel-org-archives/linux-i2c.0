From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-algo-bit: Fix spurious SCL timeouts under heavy
 load
Date: Thu, 15 Mar 2012 15:32:40 +0100
Message-ID: <20120315153240.75efc254@endymion.delvare>
References: <1331713973-7711-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331713973-7711-1-git-send-email-syrjala-ORSVBvAovxo@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ville =?UTF-8?B?U3lyasOkbMOk?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ville,

On Wed, 14 Mar 2012 10:32:52 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> When the system is under heavy load, there can be a significant delay
> between the getscl() and time_after() calls inside sclhi(). That dela=
y
> may cause the time_after() check to trigger after SCL has gone high,
> causing sclhi() to return -ETIMEDOUT.
>=20
> To fix the problem, double check that SCL is still low after the
> timeout has been reached, before deciding to return -ETIMEDOUT.
>=20
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <syrjala-ORSVBvAovxo@public.gmane.org>
> ---
> I can easily reproduce these spurious timeouts on my HP-compaq nc6000
> laptop with the radeon kms driver. It's enough to have a -j2 kernel
> build running, and simultaneosly issue xrandr commands in a
> terminal. Calling xrandr will cause the driver to re-read the EDID
> from the display. A significant number of the EDID reads will fail.
> With this fix I have yet to see any failed EDID reads.

Thanks for describing a test case, I was able to reproduce the problem
easily by following your instructions. The problem is real, even with
the pending fixes I have to radeon's I2C implementation.

I only have one concern about your implementation:

>=20
>  drivers/i2c/algos/i2c-algo-bit.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c=
-algo-bit.c
> index 525c734..d25112e 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -104,9 +104,11 @@ static int sclhi(struct i2c_algo_bit_data *adap)
>  		 * are processing data internally.
>  		 */
>  		if (time_after(jiffies, start + adap->timeout))
> -			return -ETIMEDOUT;
> +			break;
>  		cond_resched();
>  	}
> +	if (!getscl(adap))
> +		return -ETIMEDOUT;

This means double-check even in the most common case where time_after()
didn't cause the loop break. From a performance perspective, this seems
undesirable. What would you think of the alternative fix below?

--- linux-3.3-rc7.orig/drivers/i2c/algos/i2c-algo-bit.c	2012-03-15 09:3=
3:10.232176790 +0100
+++ linux-3.3-rc7/drivers/i2c/algos/i2c-algo-bit.c	2012-03-15 14:52:48.=
127778459 +0100
@@ -103,8 +103,14 @@ static int sclhi(struct i2c_algo_bit_dat
 		 * chips may hold it low ("clock stretching") while they
 		 * are processing data internally.
 		 */
-		if (time_after(jiffies, start + adap->timeout))
+		if (time_after(jiffies, start + adap->timeout)) {
+			/* Test one last time, as we may have been preempted
+			 * between last check and timeout test.
+			 */
+			if (getscl(adap))
+				break;
 			return -ETIMEDOUT;
+		}
 		cond_resched();
 	}
 #ifdef DEBUG

=46unctionally it should be equivalent to your proposal, but faster. I'=
ll
apply that (and send for stable inclusion.)

Thanks,
--=20
Jean Delvare
