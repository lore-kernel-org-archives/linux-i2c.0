From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch] i2c: announce SMBus host controllers
Date: Fri, 4 Jan 2008 18:44:11 +0100
Message-ID: <20080104184411.142fd0b2@hyperion.delvare>
References: <e3i3Vo4v.1198339842.7760000.khali@gcu-squad.org>
	<200801021635.04702.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801021635.04702.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bjorn,

On Wed, 2 Jan 2008 16:35:04 -0700, Bjorn Helgaas wrote:
> On Saturday 22 December 2007 09:10:44 am Jean Delvare wrote:
> > * I think that you should make sure that the device has been successfully
> > registered before you print the message, otherwise it might be
> > confusing. I only looked at i2c-pasemi and scx200_acb and for both
> > drivers you print the message at a point where a failure could still
> > happen. Please double-check for all drivers, adjust as needed and
> > resubmit.
> 
> Take a look at i2c-ali1535.c.  I put the new printk in ali1535_setup(),
> which does PCI initialization, even though a failure could happen later
> in i2c_add_adapter().
> 
> I picked that because putting the new printk in ali1535_probe() would
> mean:
>   - the printk would be far removed from the request_region(), so it's
>     a little harder to be sure the "ali1535_smba + ALI1535_SMB_IOSIZE - 1"
>     expression matches,
>   - I wouldn't be able print the SMBREV value, and
>   - I'd have to add a temporary to check the return from
>     i2c_add_adapter() instead of just returning it directly,
> 
> I'd still be glad to change them if you prefer.  I just want to do
> them all the same (either all before or all after i2c_add_adapter()).
> Let me know your preference.

If moving the message makes the code mode complex, then I agree that
you shouldn't do that. After all, i2c_add_adapter() is very unlikely to
fail, and if it does, I certainly hope that it'll clearly show in the
kernel log so that no confusion is possible.

So just do what you think is best and I'll take that.

Thanks,
-- 
Jean Delvare
