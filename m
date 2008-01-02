From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [patch] i2c: announce SMBus host controllers
Date: Wed, 2 Jan 2008 16:35:04 -0700
Message-ID: <200801021635.04702.bjorn.helgaas@hp.com>
References: <e3i3Vo4v.1198339842.7760000.khali@gcu-squad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <e3i3Vo4v.1198339842.7760000.khali-IO4AeUl/lkuWVfeAwA7xHQ@public.gmane.org>
Content-Disposition: inline
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 22 December 2007 09:10:44 am Jean Delvare wrote:
> Le 21/12/2007, Bjorn Helgaas a =E9crit:
> >Would you consider adding a patch like this to your i2c tree?
> >Unfortunately, I don't think I have hardware for any of these
> >devices, so all I have done is compiled this.
> >(...)
> >i2c: announce SMBus host controllers
> >
> >Note where we find SMBus host controllers and what resources they use.
> ...

> * i2c-i810, i2c-prosavage, i2c-savage4 and i2c-voodoo3 are NOT SMBus host
> controller drivers. They do I2C/DDC over GPIO for graphics adapters. I
> don't think that you really need to know about the resources they use,
> they are not candidates for conflicts with ACPI / BIOS / whatever. And 3
> out of 4 are deprecated, so all in all they are probably just not worth
> modifying.

I removed the patches for these drivers.

> * I think that you should make sure that the device has been successfully
> registered before you print the message, otherwise it might be
> confusing. I only looked at i2c-pasemi and scx200_acb and for both
> drivers you print the message at a point where a failure could still
> happen. Please double-check for all drivers, adjust as needed and
> resubmit.

Take a look at i2c-ali1535.c.  I put the new printk in ali1535_setup(),
which does PCI initialization, even though a failure could happen later
in i2c_add_adapter().

I picked that because putting the new printk in ali1535_probe() would
mean:
  - the printk would be far removed from the request_region(), so it's
    a little harder to be sure the "ali1535_smba + ALI1535_SMB_IOSIZE - 1"
    expression matches,
  - I wouldn't be able print the SMBREV value, and
  - I'd have to add a temporary to check the return from
    i2c_add_adapter() instead of just returning it directly,

I'd still be glad to change them if you prefer.  I just want to do
them all the same (either all before or all after i2c_add_adapter()).
Let me know your preference.

Bjorn
