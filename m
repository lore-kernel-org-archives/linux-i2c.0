From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Resend Patch 9/9] I2C/ACPI: Add CONFIG_I2C_ACPI config
Date: Wed, 23 Apr 2014 10:40:56 +0300
Message-ID: <20140423074056.GU30677@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-10-git-send-email-tianyu.lan@intel.com>
 <20140422114510.GM30677@intel.com>
 <53575227.7080407@intel.com>
 <1AE640813FDE7649BE1B193DEA596E88025577CB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88025577CB@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "awilliam@redhat.com" <awilliam@redhat.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 23, 2014 at 06:47:05AM +0000, Zheng, Lv wrote:
> Hi, Tianyu
>=20
> > From: Lan, Tianyu
> > Sent: Wednesday, April 23, 2014 1:40 PM
> >=20
> > On 2014=E5=B9=B404=E6=9C=8822=E6=97=A5 19:45, Mika Westerberg wrote=
:
> > > On Tue, Apr 22, 2014 at 02:24:15PM +0800, Lan Tianyu wrote:
> > >> This patch is to add CONFIG_I2C_ACPI. Current there is a race be=
tween
> > >> removing I2C ACPI operation region and ACPI AML code accessing.
> > >> So make i2c core built-in if CONFIG_I2C_ACPI is set.
> > >>
> > >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> > >> ---
> > >>  drivers/i2c/Kconfig  | 17 ++++++++++++++++-
> > >>  drivers/i2c/Makefile |  2 +-
> > >>  include/linux/i2c.h  |  2 +-
> > >>  3 files changed, 18 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> > >> index 7b7ea32..c670d49 100644
> > >> --- a/drivers/i2c/Kconfig
> > >> +++ b/drivers/i2c/Kconfig
> > >> @@ -2,7 +2,9 @@
> > >>  # I2C subsystem configuration
> > >>  #
> > >>
> > >> -menuconfig I2C
> > >> +menu "I2C support"
> > >> +
> > >> +config I2C
> > >>  	tristate "I2C support"
> > >>  	select RT_MUTEXES
> > >>  	---help---
> > >> @@ -21,6 +23,17 @@ menuconfig I2C
> > >>  	  This I2C support can also be built as a module.  If so, the =
module
> > >>  	  will be called i2c-core.
> > >>
> > >> +config I2C_ACPI
> > >> +	bool "I2C ACPI support"
> > >> +	select I2C
> > >> +	depends on ACPI
> > >> +	default y
> > >> +	help
> > >> +	  Say Y here if you want to enable I2C ACPI function. ACPI tab=
le
> > >> +	  provides I2C slave devices' information to enumerate these d=
evices.
> > >> +	  This option also allows ACPI AML code to access I2C slave de=
vices
> > >> +	  via I2C ACPI operation region to fulfill ACPI method.
> > >> +
> > >
> > > I'm wondering, can we provide some sort of wrapper function from =
ACPI core
> > > that is guaranteed to be built in to the kernel image and use it =
instead of
> > > adding new Kconfig options?
> > >
> > Cc: LV
> >=20
> > LV tried to fix the issue via wrapper solution in the ACPI code bef=
ore.
> > https://lkml.org/lkml/2013/7/23/87
> >=20
> > He has a plan to resolve the issue in ACPICA later.
> >=20
> > Other choice is to increase the i2c-core module count to prevent it
> > being unloaded when i2c operation region handler is installed. Remo=
ve
> > the code When LV finish his job.
>=20
> You may see it implemented in ACPICA after several release.
> If you need a fix for now, you can use the patch pointed to by the li=
nk you've provided,
> Or you could find an updated one here:
>  acpi-ipmi13.patch archived in (https://bugzilla.kernel.org/attachmen=
t.cgi?id=3D112611)
>=20
> I think the solution you've provided in this patch is also reasonable=
 for now.
> IPMI also uses a similar solution to solve this issue.
> Please refer to the CONFIG_ACPI_IPMI.
>=20
> The story can be found at:
> http://www.spinics.net/lists/linux-acpi/msg49044.html
> And the similar solution can be found at:
> http://www.spinics.net/lists/linux-acpi/msg49184.html

Thanks for the pointers.

Given that the IPMI problem was solved like this I guess I2C operation
regions can follow the same pattern if there is no better solution
available.

Out of curiousity: how did you plan to fix this in ACPICA?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
