From: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
Subject: Re: i2c: cdev lock_kernel() pushdown
Date: Tue, 15 Jul 2008 10:52:11 -0600
Message-ID: <20080715105211.77a15b25@bike.lwn.net>
References: <20080715174155.2d52e6f6@hyperion.delvare>
	<20080715101406.6b4517e3@bike.lwn.net>
	<20080715183552.7e1b797a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080715183552.7e1b797a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 15 Jul 2008 18:35:52 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Good point. i2c_dev is guaranteed to stay thanks to the call to
> i2c_get_adapter(), however it happens _after_ the call to
> i2c_dev_get_by_minor(), so without additional locking, this is racy.
> That being said, I'm not sure how lock_kernel() is supposed to help.
> Is the BKL held when i2cdev_detach_adapter() is called? If not, then I
> suspect that the current code is already racy.

A quick look suggests that there will be no BKL protection for
i2cdev_detach_adapter().  So, yes, I think it doesn't help here.  

jon

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
