From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [REGRESSION? v4.8] i2c-core: acpi_i2c_get_info() touches non-existent devices
Date: Mon, 19 Sep 2016 15:58:52 +0200
Message-ID: <87fuowf0tf.fsf@gmail.com>
References: <87a8f4kfhe.fsf@gmail.com>
        <20160919084807.GC1811@lahna.fi.intel.com>
        <20160919130324.GI1811@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34571 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756640AbcISN64 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 19 Sep 2016 09:58:56 -0400
In-Reply-To: <20160919130324.GI1811@lahna.fi.intel.com> (Mika Westerberg's
        message of "Mon, 19 Sep 2016 16:03:24 +0300")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Nicolai Stange <nicstange@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Mon, Sep 19, 2016 at 11:48:07AM +0300, Mika Westerberg wrote:
>> On Mon, Sep 19, 2016 at 12:30:53AM +0200, Nicolai Stange wrote:

>> > I'm encountering the following:
>> > 
>> > [   10.409490] ERROR: Unable to locate IOAPIC for GSI 37
>> > 
>> > Note that the system works fine, so it's a "cosmetic" regression, I think.
>> > 
>> > 
>> > I added a dump_stack() right below the printk() in question and it reads
>> > as
>> > 
>> > [   10.410290] CPU: 6 PID: 710 Comm: systemd-udevd Not tainted 4.7.0-rc4+ #348
>> > [   10.410962] Hardware name: Dell Inc. Latitude E6540/0725FP, BIOS A10 06/26/2014
>> > [   10.411772]  0000000000000286 00000000b9050627 ffff8800c2e5f590 ffffffffa54161e7
>> > [   10.412569]  0000000000000025 0000000000000001 ffff8800c2e5f5a0 ffffffffa50465df
>> > [   10.413292]  ffff8800c2e5f5d0 ffffffffa5046ffd 0000000000000000 0000000000000025
>> > [   10.414016] Call Trace:
>> > [   10.414713]  [<ffffffffa54161e7>] dump_stack+0x68/0xa1
>> > [   10.415406]  [<ffffffffa50465df>] mp_find_ioapic+0x4f/0x60
>> > [   10.416131]  [<ffffffffa5046ffd>] mp_map_gsi_to_irq+0x1d/0xc0
>> > [   10.416806]  [<ffffffffa503dbbb>] acpi_register_gsi_ioapic+0x7b/0x170
>> > [   10.417494]  [<ffffffffa503da6f>] acpi_register_gsi+0xf/0x20
>> > [   10.418217]  [<ffffffffa54a14d5>] acpi_dev_get_irqresource.part.3+0xd7/0x11d
>> > [   10.418871]  [<ffffffffa54a139a>] ? acpi_dev_resource_address_space+0x31/0x67
>> > [   10.419655]  [<ffffffffa54a168d>] acpi_dev_resource_interrupt+0x9b/0xab
>> > [   10.420408]  [<ffffffffa54a1848>] acpi_dev_process_resource+0xbc/0xf7
>> > [   10.421070]  [<ffffffffa54a178c>] ? acpi_dev_resource_memory+0x7c/0x7c
>> > [   10.421732]  [<ffffffffa54c3ba2>] acpi_walk_resource_buffer+0x4d/0x85
>> > [   10.422399]  [<ffffffffa54a178c>] ? acpi_dev_resource_memory+0x7c/0x7c
>> > [   10.423158]  [<ffffffffa54c3e89>] acpi_walk_resources+0x83/0xb6
>> > [   10.423831]  [<ffffffffa54a15b1>] acpi_dev_get_resources+0x96/0xd7
>> > [   10.424505]  [<ffffffffa563f7c4>] acpi_i2c_get_info+0xe4/0x1a0
>> > [   10.425181]  [<ffffffffa5642c06>] acpi_i2c_add_device+0x56/0xa0
>> > [   10.425856]  [<ffffffffa54bf2ff>] acpi_ns_walk_namespace+0xe8/0x19d
>> > [   10.426564]  [<ffffffffa5642bb0>] ? acpi_i2c_register_device+0x70/0x70
>> > [   10.427418]  [<ffffffffa5642bb0>] ? acpi_i2c_register_device+0x70/0x70
>> > [   10.428179]  [<ffffffffa54bf83d>] acpi_walk_namespace+0xa0/0xd5
>> > [   10.428858]  [<ffffffffa56437a9>] i2c_register_adapter+0x369/0x500
>> > [   10.429499]  [<ffffffffa564399c>] i2c_add_adapter+0x5c/0x70
>> > [   10.430125]  [<ffffffffc07df7dd>] i801_probe+0x2bd/0x6a0 [i2c_i801]


>> > I bisected this to commit 525e6fabeae2 ("i2c / ACPI: add support for
>> > ACPI reconfigure notifications").
>> > 
>> > The reason for the above message seems to be that acpi_i2c_get_info()
>> > configures the IRQs for any ACPI devices that have got some
>> > I2cSerialBus() resource, regardless of the actual adapter those are
>> > attached to. This behaviour is different from before that commit.
>> > 
>> > My ACPI DSDT has got a PCI I2C adapter that isn't physically present, it
>> > seems. No clue why.
>> > 
>> > That non-existent PCI I2C adapter is in turn I2cSerialBus()-referenced
>> > by some ACPI device that has got exactly this interrupt 37 assigned.
>> > 
>> > So it looks like an attempt is made to configure this non-existent,
>> > ACPI-listed I2C slave's IRQs when an actually existing I2C adapter (i801
>> > SMBus) gets probed.


> Can you try if the following patch cures the problem?

Unfortunately not. That patch installs the check after the
acpi_i2c_get_info() invocation which is part of the backtrace above.

I moved your check into i2c_get_info(), right in front of the IRQ
handling and this works.

So,

  Tested-by: Nicolai Stange <nicstange@gmail.com>

for this:

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 74e5aea..3f2b3cf 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -141,6 +141,7 @@ static int acpi_i2c_get_info(struct acpi_device *adev,
 	struct list_head resource_list;
 	struct resource_entry *entry;
 	struct acpi_i2c_lookup lookup;
+	struct acpi_device *adapter_adev;
 	int ret;
 
 	if (acpi_bus_get_status(adev) || !adev->status.present ||
@@ -163,6 +164,12 @@ static int acpi_i2c_get_info(struct acpi_device *adev,
 	if (ret < 0 || !info->addr)
 		return -EINVAL;
 
+	/* The adapter must be present */
+	if (acpi_bus_get_device(lookup.adapter_handle, &adapter_adev))
+		return -EINVAL;
+	if (acpi_bus_get_status(adapter_adev) || !adapter_adev->status.present)
+		return -EINVAL;;
+
 	*adapter_handle = lookup.adapter_handle;
 
 	/* Then fill IRQ number if any */



But it is still true that acpi_i2c_register_devices() configures the
interrupts for all ACPI I2C slaves attached to an available adapter,
independent of whether their adapter is the one given as an argument or
not. I can't tell whether this is desired, just a note...
