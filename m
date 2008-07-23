From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: class_for_each_device() oops
Date: Wed, 23 Jul 2008 16:18:59 -0700
Message-ID: <20080723231859.GB30234@kroah.com>
References: <200807231606.48016.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200807231606.48016.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, Jul 23, 2008 at 04:06:47PM -0700, David Brownell wrote:
> I happened across this ... it looks like the root cause
> is that an i2c driver ("smbus_alert") gets registered
> before the class ("i2c_adapter") being iterated.
> 
> (This used the latest version of the patch adding SMBus
> alert support to I2C.  It's not mainline, although it's
> been posted a few times.)
> 
> 
> Now, obviously a trivial fix is to change that init order,
> and just accept that there's now an init dependency which
> didn't exist before.  But on the other hand I don't think
> that it's reasonable to oops there; it's needless, and in
> fact it never oopsed before!  
> 
> In this case adding 
> 
> 	if (!class->p)
> 		return -EINVAL;
> 
> at the top of class_for_each_device() would prevent such
> oopses from ever happening.

Makes sense, care to send a real patch for this?

thanks,

greg k-h

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
