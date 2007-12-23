From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [patch] i2c: announce SMBus host controllers
Date: Sat, 22 Dec 2007 20:42:11 -0700
Message-ID: <200712222042.12378.bjorn.helgaas@hp.com>
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

On Saturday 22 December 2007 9:10:44 am Jean Delvare wrote:
> Hi Bjorn,
>
> Le 21/12/2007, Bjorn Helgaas a =E9crit:
> >Would you consider adding a patch like this to your i2c tree?
> >Unfortunately, I don't think I have hardware for any of these
> >devices, so all I have done is compiled this.
> >(...)
> >i2c: announce SMBus host controllers
> >
> >Note where we find SMBus host controllers and what resources they use.
>
> I like the idea. The information printed is somewhat redundant with
> /proc/ioports but sometimes it's useful to see the information in dmesg
> directly, and having a common string to grep for should be convenient as
> well. Just a couple comments:
>
> * i2c-i810, i2c-prosavage, i2c-savage4 and i2c-voodoo3 are NOT SMBus host
> controller drivers. They do I2C/DDC over GPIO for graphics adapters. I
> don't think that you really need to know about the resources they use,
> they are not candidates for conflicts with ACPI / BIOS / whatever. And 3
> out of 4 are deprecated, so all in all they are probably just not worth
> modifying.
>
> * I think that you should make sure that the device has been successfully
> registered before you print the message, otherwise it might be
> confusing. I only looked at i2c-pasemi and scx200_acb and for both
> drivers you print the message at a point where a failure could still
> happen. Please double-check for all drivers, adjust as needed and
> resubmit.
>
> I can test the i2c-i801 driver now and i2c-viapro and i2c-piix4 later.

Thanks for the comments!  My work machine is powered off for the
holidays, so I'll rework the patch after the new year.

Bjorn
