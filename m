From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [crash, bisected] I2C,  kobject (ffff81003e8c4160): tried to
 init an initialized object
Date: Wed, 6 Aug 2008 22:21:28 +0200
Message-ID: <20080806222128.30d55622@hyperion.delvare>
References: <20080714224945.629446fa@hyperion.delvare>
	<20080716082352.GA30483@elte.hu>
	<20080716110702.3ca61eb2@hyperion.delvare>
	<20080716120801.3e9b4c80@hyperion.delvare>
	<20080716141826.1d88d05e@hyperion.delvare>
	<20080717092655.GA6115@elte.hu>
	<20080717093329.GA20032@elte.hu>
	<20080717094858.GA18687@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758588AbYHFUW2@vger.kernel.org>
In-Reply-To: <20080717094858.GA18687@martell.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux I2C <i2c@lm-sensors.org>, Ulrich Drepper <drepper@redhat.com>
List-Id: linux-i2c@vger.kernel.org

Hi Alexey, Ingo,

On Thu, 17 Jul 2008 13:48:58 +0400, Alexey Dobriyan wrote:
> On Thu, Jul 17, 2008 at 11:33:30AM +0200, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > Jean,
> > > 
> > > -tip testing found another (similar) i2c crash with latest -git, on a 
> > > Core2Duo laptop:
> > > 
> > > calling  nforce2_init+0x0/0x1b
> > > initcall nforce2_init+0x0/0x1b returned 0 after 0 msecs
> > > calling  nforce2_s4985_init+0x0/0x275
> > > BUG: unable to handle kernel NULL pointer dereference at 0000000c
> > > IP: [<c04af2cf>] i2c_smbus_xfer+0x27/0x3f0
> > > *pdpt = 00000000009cb001 *pde = 0000000000000000 
> > > Oops: 0000 [#1] SMP 
> > 
> > turning off I2C_NFORCE2_S4985 makes the system boot up fine. Workaround 
> > patch below.
> 
> Well, it's pretty easy oops unless I misread something.
> 
> It happened on not nforce2 motherboard, right?
> 
> nforce2_init will just register PCI driver,
> no matching PCI ids => nforce2_set_reference() isn't called =>
> nforce2_smbus stays NULL.
> 
> Second module loads and tries to i2c_smbus_xfer(NULL, ) in module_init()
> hook which oopses.

Analysis is totally correct. I guess I shouldn't have tried to fix the
original bug in a hurry before leaving for vacation. I didn't have the
time to completely test it and as a result I introduced a new bug.
Which the following patch should fix:

* * * * *

Subject: i2c: Fix oops on bus multiplexer driver loading

The two I2C bus multiplexer drivers (i2c-amd756-s4882 and
i2c-nforce2-s4985) make use of the bus they want to multiplex before
checking if it is really present. Swap the instructions to test for
presence first. This fixes a oops reported by Ingo Molnar.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Ingo Molnar <mingo@elte.hu>
---
 drivers/i2c/busses/i2c-amd756-s4882.c  |    9 ++++-----
 drivers/i2c/busses/i2c-nforce2-s4985.c |    5 +++--
 2 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.27-rc2.orig/drivers/i2c/busses/i2c-amd756-s4882.c	2008-08-05 18:17:05.000000000 +0200
+++ linux-2.6.27-rc2/drivers/i2c/busses/i2c-amd756-s4882.c	2008-08-06 20:40:16.000000000 +0200
@@ -155,6 +155,9 @@ static int __init amd756_s4882_init(void
 	int i, error;
 	union i2c_smbus_data ioconfig;
 
+	if (!amd756_smbus.dev.parent)
+		return -ENODEV;
+
 	/* Configure the PCA9556 multiplexer */
 	ioconfig.byte = 0x00; /* All I/O to output mode */
 	error = i2c_smbus_xfer(&amd756_smbus, 0x18, 0, I2C_SMBUS_WRITE, 0x03,
@@ -168,11 +171,7 @@ static int __init amd756_s4882_init(void
 	/* Unregister physical bus */
 	error = i2c_del_adapter(&amd756_smbus);
 	if (error) {
-		if (error == -EINVAL)
-			error = -ENODEV;
-		else
-			dev_err(&amd756_smbus.dev, "Physical bus removal "
-				"failed\n");
+		dev_err(&amd756_smbus.dev, "Physical bus removal failed\n");
 		goto ERROR0;
 	}
 
--- linux-2.6.27-rc2.orig/drivers/i2c/busses/i2c-nforce2-s4985.c	2008-08-05 18:17:05.000000000 +0200
+++ linux-2.6.27-rc2/drivers/i2c/busses/i2c-nforce2-s4985.c	2008-08-06 20:07:48.000000000 +0200
@@ -150,6 +150,9 @@ static int __init nforce2_s4985_init(voi
 	int i, error;
 	union i2c_smbus_data ioconfig;
 
+	if (!nforce2_smbus)
+		return -ENODEV;
+
 	/* Configure the PCA9556 multiplexer */
 	ioconfig.byte = 0x00; /* All I/O to output mode */
 	error = i2c_smbus_xfer(nforce2_smbus, 0x18, 0, I2C_SMBUS_WRITE, 0x03,
@@ -161,8 +164,6 @@ static int __init nforce2_s4985_init(voi
 	}
 
 	/* Unregister physical bus */
-	if (!nforce2_smbus)
-		return -ENODEV;
 	error = i2c_del_adapter(nforce2_smbus);
 	if (error) {
 		dev_err(&nforce2_smbus->dev, "Physical bus removal failed\n");

This is going to Linus tomorrow.

Thanks,
-- 
Jean Delvare
