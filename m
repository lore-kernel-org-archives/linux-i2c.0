From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c: cdev lock_kernel() pushdown
Date: Tue, 15 Jul 2008 18:35:52 +0200
Message-ID: <20080715183552.7e1b797a@hyperion.delvare>
References: <20080715174155.2d52e6f6@hyperion.delvare>
	<20080715101406.6b4517e3@bike.lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080715101406.6b4517e3-vw3g6Xz/EtPk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 15 Jul 2008 10:14:06 -0600, Jonathan Corbet wrote:
> Hi, Jean,
> 
> > I am looking at this patch of yours:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3db633ee352bfe20d4a2b0c3c8a46ce31a6c7149
> > 
> > I believe that no locking is needed in i2cdev_open(). Do you have any
> > reason to think it does? If not, can I simply revert this patch?
> 
> Before now, i2cdev_open() has always had the protection of the BKL.
> When I pushed that locking down into the individual open() functions, I
> really had to take a pretty conservative approach and assume that the
> BKL was needed unless that was really obviously not the case.  In
> i2cdev_open(), for example, there's:
> 
> 	i2c_dev = i2c_dev_get_by_minor(minor);
> 
> and I really don't know what keeps *i2c_dev from going away during the
> rest of the call.  I'm *not* saying there is a problem here; I just
> don't know.  So the only thing I could really do is to push the BKL
> down and let the maintainers sort it out.
> 
> ...all of which is my long-winded way of saying that, if you're
> convinced that i2cdev_open() is safe in the absence of the BKL, feel
> free to take it out.

Good point. i2c_dev is guaranteed to stay thanks to the call to
i2c_get_adapter(), however it happens _after_ the call to
i2c_dev_get_by_minor(), so without additional locking, this is racy.
That being said, I'm not sure how lock_kernel() is supposed to help. Is
the BKL held when i2cdev_detach_adapter() is called? If not, then I
suspect that the current code is already racy.

I'll look into this, thanks for the hint.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
