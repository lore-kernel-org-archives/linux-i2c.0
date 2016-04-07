From: Christian Ruppert <christian.ruppert@alitech.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Thu, 7 Apr 2016 15:37:08 +0200
Message-ID: <57066284.30403@alitech.com>
References: <1459478866-3896-1-git-send-email-lucas.de.marchi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459478866-3896-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, linux-i2c@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Dear Lucas,

Sorry for the late reply but I had to put our test environment back
together to check this patch. I'll keep it around for a while in case
you have further iterations to test.

On 2016-04-01 04:47, Lucas De Marchi wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Disabling the adapter after each transfer is pretty bad for sensors and
> other devices doing small transfers at a high rate. It slows down the
> transfer rate a lot since each of them have to wait the adapter to be
> enabled again.
> 
> It was done in order to avoid the adapter to generate interrupts when
> it's not being used. Instead of doing that here we just disable the
> interrupt generation in the controller. With a small program test to
> read/write registers in a sensor the speed doubled. Example below with
> write sequences of 16 bytes:
> 
> Before:
> 	i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
> 	num_transfers=20000
> 	transfer_time_avg=1032.728500us
> 
> After:
> 	i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
> 	num_transfers=20000
> 	transfer_time_avg=470.256050us
> 
> During the init we check the status register for no activity and TX
> buffer being empty since otherwise we can't change IC_TAR dynamically.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
> 
> Mika / Christian,
> 
> This is a second approach to a patch sent last year:
> https://patchwork.ozlabs.org/patch/481952/
> 
> I hope that now it's in a better form. This has been tested on a Baytrail soc
> (MinnowBoard Turbot) and is working. Would be nice to know if it also works on
> Christian's machine since it was the one giving problems.  Christian, could you
> give this a try?  It has been tested on top of 4.4.6 (+ some backports) and
> 4.6.0-rc1.

On Linux-4.6.0-rc2 the behaviour is still the same: The kernel locks up
in an irq loop at dwi2c driver probe time. If I don't apply the patch
everything works fine and the system boots and talks normally on the i2c
bus.

One solution might be to add a device-tree (and acpi) flag to tell the
driver that it does not need to expect any nastily behaved devices on
the bus. If this flag is given, the driver could use the faster
disable-interrupt strategy. Without the flag we need to fall back to the
conservative disable-i2c-controller strategy.

I think such a flag should be OK because I2C buses are generally quite
static and the list of devices should be known at system integration
time. In the rare cases where this is not true, users could still go
with the conservative approach. I know that the "cleaner" method would
be to rather mark nasty devices, either in device tree or in the driver,
but I guess the required changes in the I2C framework might be overkill
for this dwi2c specific problem.

Greetings,
  Christian
