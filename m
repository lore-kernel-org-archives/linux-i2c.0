From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Thu, 15 May 2008 20:33:52 +0200
Message-ID: <20080515203352.14109101@hyperion.delvare>
References: <200805012046.07885.david-b@pacbell.net>
	<200805120948.23842.david-b@pacbell.net>
	<20080514141738.327be680@hyperion.delvare>
	<200805140750.49365.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805140750.49365.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, 14 May 2008 07:50:49 -0700, David Brownell wrote:
> On Wednesday 14 May 2008, Jean Delvare wrote:
> > 
> > > Here's a patch adding such information ... against 2.6.26-rc2 and
> > > in synch with both the "-Errno not -1" patches I've sent.
> > 
> > Thanks for doing this. This document will be very helpful both for me
> > when reviewing your patches, and for both I2C bus and I2C device driver
> > authors later.
> 
> Updated version.
> 
> ======== CUT HERE
> Create Documentation/i2c/fault-codes to help standardize
> fault/error code usage in the I2C stack.  It turns out that
> returning -1 (-EPERM) for everything was not at all helpful.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  Documentation/i2c/fault-codes |  127 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
