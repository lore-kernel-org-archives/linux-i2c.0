From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Add Intel SCH I2C SMBus support
Date: Sun, 27 Apr 2008 21:56:02 +0800
Message-ID: <20080427215602.12f895da@dxy.sh.intel.com>
References: <20080424100510.09cc2d4b@dxy.sh.intel.com>
	<48124673.8020808@assembler.cz>
	<20080426095011.2d27b75b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080426095011.2d27b75b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

Hi Rudolf, Jean

Thanks for your kind review. Will submit second round patch for review.


On Sat, 26 Apr 2008 09:50:11 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Rudolf,
> 
> thanks for the review.
> 
> One preliminary note about the driver name. I'm a bit worried by the
> name "i2c-sch" because there is another manufacturer (SMSC) making
> chips named SCH-something which could include an SMBus controller. This
> could be a bit confusing for the users. Maybe we could rename this
> driver to i2c-isch, to make it clearer that it's for Intel SCH chips?
> 
> On Fri, 25 Apr 2008 23:00:35 +0200, Rudolf Marek wrote:
> > Hello Alek,
> > 
> > Please check the review bellow. It took me hour and half which was quite
> > unexpected when I started. Jean would you please take a look too?
> 
> I'll review the next iteration. Some comments on what you wrote:
> 
> > > +/*
> > > +    i2c-sch.c - Part of lm_sensors, Linux kernel modules for hardware
> > > +    monitoring
> 
> These drivers are no longer "part of lm_sensors".
> 
> > > (...)
> > > +#include <linux/module.h>
> > > +#include <linux/moduleparam.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/stddef.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/ioport.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/init.h>
> > > +#include <linux/apm_bios.h>
> 
> I'm very curious why you'd need this one? Presumably a leftover from
> the i2c-piix4 driver...
> 
> > > +#include <linux/io.h>
> 
> > (...)
> > Maybe your mailer did something to the tabs. You can run:
> > 
> > indent -kr -i8 i2ci-sch.c
> >
> > It will fix all coding style issues. (I think except that it put labels
> > indented, you may revert that). We take here also text attachments, which are
> > fine through thunderbird. You seem to use clawmail so I cant help much.
> 
> There's scripts/Lindent which has all the options.
> 
> > > +
> > > +/* insmod parameters */
> > > +
> > > +/* If force is set to anything different from 0, we forcibly enable the
> > > +   SCH. DANGEROUS! */
> > > +static int force;
> > > +module_param(force, int, 0);
> > > +MODULE_PARM_DESC(force, "Forcibly enable the I2C. DANGEROUS!");
> > 
> > Hmm not sure if it is good now. The newer BIOSes are much more saner than the
> > old - but here it is some left_over - check bellow.
> 
> I agree with Rudolf here, we don't want any "force" parameter that
> isn't strictly necessary. And even then we'd rather complain to the
> manufacturers quickly, so that the BIOS can be fixed and the driver can
> be kept clean.
> 
> > > (...)
> > > +       switch (size) {
> > > +       case I2C_SMBUS_PROC_CALL:
> > > +               dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
> > > +               return -EPERM;
> > 
> > I think this should not happen.
> 
> It could happen, but there's no need to handle unsupported cases
> explicitly, just have a default case at the end which catches all the
> unsupported sizes and returns -EINVAL.
> 
> > (...)
> > MAybe you can test the driver with following commands. Assuming that you have
> > SPD eeprom on 0x50.
> > 
> > modprobe i2c-dev
> > modprobe i2c-sch
> > 
> > i2cdump -l
> 
> i2cdetect -l
> 
> > will list the busses, assuming it is 0 please try following:
> > 
> > i2cdetect 0
> > 
> > It should detect all devices, maybe on 0x50 or 0x51 SPD eeprom. Use this device
> > for other tests:
> > 
> > i2cdump  0 0x50 b
> > i2cdump  0 0x50 c
> > i2cdump  0 0x50 W
> > i2cdump  0 0x50 s
> > 
> > This commands should produce same results.
> > 
> > i2cdump  0 0x50 w
> > 
> > You should see above in daisy chained mode. If the byte mode was:
> > 00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
> > 
> > Now you should see:
> > 
> > 00: 0880 0708 0d07 0a0d 020a 4002 0040 0400
> > 08: 5004 6050 0060 8200 0882 0008 0100 0e01 (e1 is from offset 0x10)
> > 
> > CHeck log aftewards if there is nothing unusual.
> 
> This is very important to check that the contents of the EEPROMs have
> not been modified by the dumps. If they are, it means that there's a
> bug in the driver, and also your system probably won't boot next time
> because the memory module won't be recognized. Better do you tests with
> a cheap memory module ;)
> 
> > > (...)
> > > +       switch (size) {
> > > +       case SCH_BYTE:
> > > +               /* Where is the result put? I assume here it is in
> > > +                  SMBHSTDAT0 but it might just as well be in the
> > > +                  SMBHSTCMD. No clue in the docs */
> > 
> > Well check with my test ;)
> 
> The comment above is taken directly from the i2c-piix4 driver, does it
> apply to the SCH at all? We should probably remove it from the
> i2c-piix4 driver anyway, we know the answer by now.
> 
> > > (...)
> > > +static struct pci_device_id sch_ids[] = {
> > > +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SCH_LPC),
> > > +         .driver_data = 0xf8 },
> > 
> > Please set it to 0x40 as suggested above.
> 
> Or just don't use driver_data at all for now? With a single device
> supported at the moment, I don't see the idea.
> 
> > > (...)
> > > +MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and "
> > > +               "Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org> and "
> > > +               "Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> ");
> 
> You can remove Frodo and Philip here, they aren't the authors of _this_
> driver.
> 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
