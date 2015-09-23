From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 8/8] pwm-pca9685: enable ACPI device found on Galileo
 Gen2
Date: Wed, 23 Sep 2015 11:41:26 +0300
Message-ID: <1442997686.8361.161.camel@linux.intel.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1442916619-140607-9-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150922143714.GA9235@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150922143714.GA9235@ulmo.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-09-22 at 16:37 +0200, Thierry Reding wrote:
> On Tue, Sep 22, 2015 at 01:10:19PM +0300, Andy Shevchenko wrote:

> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -26,6 +26,8 @@
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  #include <linux/delay.h>
> > +#include <linux/acpi.h>
> > +#include <linux/property.h>
> 
> These should be kept sorted. I know that delay.h isn't properly 
> ordered
> either, I missed that during patch review. Please keep new ones 
> ordered
> alphabetically and I'll sort out the delay.h via a separate patch.

Will do in next version.

> @@ -363,6 +364,12 @@ static const struct i2c_device_id pca9685_id[]
> > = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, pca9685_id);
> >  
> > +static const struct acpi_device_id pca9685_acpi_ids[] = {
> > +	{ "INT3492", 0 },
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
> > +
> >  static const struct of_device_id pca9685_dt_ids[] = {
> >  	{ .compatible = "nxp,pca9685-pwm", },
> >  	{ /* sentinel */ }
> > @@ -372,6 +379,7 @@ MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
> >  static struct i2c_driver pca9685_i2c_driver = {
> >  	.driver = {
> >  		.name = "pca9685-pwm",
> > +		.acpi_match_table = ACPI_PTR(pca9685_acpi_ids),
> 
> I think you now need #ifdef protection for the ACPI ID table, 
> otherwise
> the compiler will warn that the table is unused for !ACPI.

No, there is no warning, just checked a build with CONFIG_ACPI=n.

Tried even with C=1 W=2, and driver compiled in and a module.
In all variants no warning regarding the topic is issued.

$ gcc --version
gcc (Debian 5.2.1-17) 5.2.1 20150911

Perhaps this would explain what is happening there.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=28901

So, I will add #ifdef in the code as well, though I'm not a big fan of
conditional compilation.

> 
> >  		.of_match_table = pca9685_dt_ids,
> 
> Similarly to the above, this should use of_match_ptr(), which in turn
> will require #ifdef protection for the table to avoid warnings.

Hmm... my patch do not touches that part. Perhaps another patch for
this?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
