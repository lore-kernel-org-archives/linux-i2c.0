From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: platform_data when using of?
Date: Thu, 24 Apr 2008 13:07:49 +0200
Message-ID: <20080424130749.7e217ccf@hyperion.delvare>
References: <20080423164523.GA4190@pengutronix.de>
	<20080423203012.24ed38b6@hyperion.delvare>
	<20080424090045.GA4201@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080424090045.GA4201-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 24 Apr 2008 11:00:45 +0200, Wolfram Sang wrote:
> On Wed, Apr 23, 2008 at 08:30:12PM +0200, Jean Delvare wrote:
> > Each i2c driver can support many different devices, which are
> > differentiated simply by their name. So the driver can behave
> > differently for each device type as needed.
>
> We exactly threw this out of at24 in the new revision, as name-matching
> stored quite some data in the driver which was needed only once during
> initialization. Also, it was not very flexible; what if you want to mark
> this chip as read-only, your variant has bigger page size and could be
> faster... The list of device names would grow too fast IMHO, adding a
> new feature which is selectable by a flag could easily double it.

The interest of separate chip names depend on the variety of devices
your driver support. I am not suggesting to have one name for every
different device the at24 driver will support, that would obviously be
way too many. But if you could come up with families (e.g. one name per
EEPROM size) with sane default settings, and then you can adjust
parameters through platform data, for example to maximize performance
if your actual EEPROM can handle larger page, or to enable write
access. So you probably have to find the right balance between one name
for all devices, and a separate name for each device.

> Then again: If Jochen's patches get applied, then I have to use
> MODULE_DEVICE_TABLE anyhow, or?

If you want your driver to load automatically, yes. But this doesn't
have much to do with the problem discussed above.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
