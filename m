From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v4 0/7] I2C IRQ Probe Improvements
Date: Tue, 11 Jun 2019 16:28:33 +0100
Message-ID: <20190611152833.GR28362@ediswmail.ad.cirrus.com>
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
 <CAO-hwJ+qSXwZ-5sAiZ55-r_PXp9pvnE1XEaE_v3SBnxzQQNH4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+qSXwZ-5sAiZ55-r_PXp9pvnE1XEaE_v3SBnxzQQNH4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, mika.westerberg@linux.intel.com, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jim Broadus <jbroadus@gmail.com>, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 11, 2019 at 05:16:58PM +0200, Benjamin Tissoires wrote:
> On Tue, Jun 11, 2019 at 2:31 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > This series attempts to align as much IRQ handling into the
> > probe path as possible. Note that I don't have a great setup
> > for testing these patches so they are mostly just build tested
> > and need careful review and testing before any of them are
> > merged.
> >
> > The series brings the ACPI path inline with the way the device
> > tree path handles the IRQ entirely at probe time. However,
> > it still leaves any IRQ specified through the board_info as
> > being handled at device time. In that case we need to cache
> > something from the board_info until probe time, which leaves
> > any alternative solution with something basically the same as
> > the current handling although perhaps caching more stuff.
> 
> Hmm, I still haven't pinpointed the issue, but I wanted to give a test
> of the series and I have:
> [    5.511806] i2c_hid i2c-DLL075B:01: HID over i2c has not been
> provided an Int IRQ
> [    5.511825] i2c_hid: probe of i2c-DLL075B:01 failed with error -22
> 
> So it seems that there is something wrong happening when fetching the
> IRQ and providing it to i2c-hid.
> 
> That was on a Dell XPS 9360.
> 
> Bisecting is starting.
> 

I have a sneaking suspision, does this diff fix it:

diff --git a/drivers/i2c/i2c-core-acpi.c
b/drivers/i2c/i2c-core-acpi.c
index 57be6342ba508..a90b05a269c36 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -169,7 +169,7 @@ int i2c_acpi_get_irq(struct i2c_client *client)
        acpi_dev_free_resource_list(&resource_list);

        if (irq == -ENOENT)
-           irq = acpi_dev_gpio_irq_get(adev, 0);
+         irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);

        return irq;
 }

There was some earlier discussion about which device was suitable
for this call.

Thanks,
Charles
