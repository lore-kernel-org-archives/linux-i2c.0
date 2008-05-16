From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.26-rc1-git] i2c-core: return -Errno, not -1
Date: Fri, 16 May 2008 09:14:58 +0200
Message-ID: <20080516091458.28f9f5ca@hyperion.delvare>
References: <200805031306.16698.david-b@pacbell.net>
	<200805111516.08453.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805111516.08453.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Sun, 11 May 2008 15:16:07 -0700, David Brownell wrote:
> More updates to the I2C stack's fault reporting:  make the core stop
> returning "-1" (usually "-EPERM") for all faults.  Instead, pass lower
> level fault code up the stack, or return some appropriate errno.
> 
> This patch happens to touch almost exclusively SMBus calls.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> This is an updated version of:
> 	http://marc.info/?l=i2c&m=120984528415259&w=2
> with some return codes updated to address feedback from the similar
> patch for the x86 I2C/SMBus adapters.
> 
>  drivers/i2c/i2c-core.c |   78 +++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 34 deletions(-)
> 

Looks very good, with just one suggested change:

> --- g26.orig/drivers/i2c/i2c-core.c	2008-05-11 13:07:56.000000000 -0700
> +++ g26/drivers/i2c/i2c-core.c	2008-05-11 15:09:00.000000000 -0700
> (...)
> @@ -1568,7 +1576,7 @@ static s32 i2c_smbus_xfer_emulated(struc
>  	default:
>  		dev_err(&adapter->dev, "smbus_access called with invalid size (%d)\n",
>  		       size);
> -		return -1;
> +		return -EOPNOTSUPP;
>  	}

I'd rather use -EINVAL here. This case is a bit different from what we
did in the bus drivers, because here the function handles all
transaction types that exist. So if we reach the default case, it means
that the caller passed an invalid parameter. -EOPNOTSUPP is not
fundamentally incorrect but it's a little less precise.

In theory, in bus drivers we should separate between invalid
transaction types and unsupported transaction types, returning -EINVAL
for the former and -EOPNOTSUPP only for the latter. We do not simply
because it makes little sense to make the drivers bigger just to report
finer-grained error codes, especially when these error paths are almost
never reached, and also because it's convenient to be able to grep for
I2C_SMBUS_* transaction type constants to find out which drivers
support a given transaction type.

BTW, feel free to adjust the debugging message above, as you did in
some bus drivers already, to clearly say that we're speaking about a
transaction type and not a "size".

All the rest looks OK to me from a functional point of view. As far as
style is concerned, please keep the alignment on opening parenthesis
when the original code did that. i2c-core uses this style consistently
and I like it.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
