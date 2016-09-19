From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [REGRESSION? v4.8] i2c-core: acpi_i2c_get_info() touches
 non-existent devices
Date: Mon, 19 Sep 2016 16:03:24 +0300
Message-ID: <20160919130324.GI1811@lahna.fi.intel.com>
References: <87a8f4kfhe.fsf@gmail.com>
 <20160919084807.GC1811@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160919084807.GC1811@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 19, 2016 at 11:48:07AM +0300, Mika Westerberg wrote:
> On Mon, Sep 19, 2016 at 12:30:53AM +0200, Nicolai Stange wrote:
> > Hi,
> > 
> > I'm encountering the following:
> > 
> > [   10.409490] ERROR: Unable to locate IOAPIC for GSI 37
> > 
> > Note that the system works fine, so it's a "cosmetic" regression, I think.
> > 
> > 
> > I added a dump_stack() right below the printk() in question and it reads
> > as
> > 
> > [   10.410290] CPU: 6 PID: 710 Comm: systemd-udevd Not tainted 4.7.0-rc4+ #348
> > [   10.410962] Hardware name: Dell Inc. Latitude E6540/0725FP, BIOS A10 06/26/2014
> > [   10.411772]  0000000000000286 00000000b9050627 ffff8800c2e5f590 ffffffffa54161e7
> > [   10.412569]  0000000000000025 0000000000000001 ffff8800c2e5f5a0 ffffffffa50465df
> > [   10.413292]  ffff8800c2e5f5d0 ffffffffa5046ffd 0000000000000000 0000000000000025
> > [   10.414016] Call Trace:
> > [   10.414713]  [<ffffffffa54161e7>] dump_stack+0x68/0xa1
> > [   10.415406]  [<ffffffffa50465df>] mp_find_ioapic+0x4f/0x60
> > [   10.416131]  [<ffffffffa5046ffd>] mp_map_gsi_to_irq+0x1d/0xc0
> > [   10.416806]  [<ffffffffa503dbbb>] acpi_register_gsi_ioapic+0x7b/0x170
> > [   10.417494]  [<ffffffffa503da6f>] acpi_register_gsi+0xf/0x20
> > [   10.418217]  [<ffffffffa54a14d5>] acpi_dev_get_irqresource.part.3+0xd7/0x11d
> > [   10.418871]  [<ffffffffa54a139a>] ? acpi_dev_resource_address_space+0x31/0x67
> > [   10.419655]  [<ffffffffa54a168d>] acpi_dev_resource_interrupt+0x9b/0xab
> > [   10.420408]  [<ffffffffa54a1848>] acpi_dev_process_resource+0xbc/0xf7
> > [   10.421070]  [<ffffffffa54a178c>] ? acpi_dev_resource_memory+0x7c/0x7c
> > [   10.421732]  [<ffffffffa54c3ba2>] acpi_walk_resource_buffer+0x4d/0x85
> > [   10.422399]  [<ffffffffa54a178c>] ? acpi_dev_resource_memory+0x7c/0x7c
> > [   10.423158]  [<ffffffffa54c3e89>] acpi_walk_resources+0x83/0xb6
> > [   10.423831]  [<ffffffffa54a15b1>] acpi_dev_get_resources+0x96/0xd7
> > [   10.424505]  [<ffffffffa563f7c4>] acpi_i2c_get_info+0xe4/0x1a0
> > [   10.425181]  [<ffffffffa5642c06>] acpi_i2c_add_device+0x56/0xa0
> > [   10.425856]  [<ffffffffa54bf2ff>] acpi_ns_walk_namespace+0xe8/0x19d
> > [   10.426564]  [<ffffffffa5642bb0>] ? acpi_i2c_register_device+0x70/0x70
> > [   10.427418]  [<ffffffffa5642bb0>] ? acpi_i2c_register_device+0x70/0x70
> > [   10.428179]  [<ffffffffa54bf83d>] acpi_walk_namespace+0xa0/0xd5
> > [   10.428858]  [<ffffffffa56437a9>] i2c_register_adapter+0x369/0x500
> > [   10.429499]  [<ffffffffa564399c>] i2c_add_adapter+0x5c/0x70
> > [   10.430125]  [<ffffffffc07df7dd>] i801_probe+0x2bd/0x6a0 [i2c_i801]
> > [   10.431159]  [<ffffffffa50eb8dd>] ? trace_hardirqs_on+0xd/0x10
> > [   10.432196]  [<ffffffffa54682f2>] local_pci_probe+0x42/0xa0
> > [   10.432826]  [<ffffffffa5468e2a>] ? pci_match_device+0xca/0x110
> > [   10.433460]  [<ffffffffa5469243>] pci_device_probe+0x103/0x150
> > [   10.434083]  [<ffffffffa5545acc>] driver_probe_device+0x22c/0x440
> > [   10.434712]  [<ffffffffa5545db5>] __driver_attach+0xd5/0x100
> > [   10.435341]  [<ffffffffa5545ce0>] ? driver_probe_device+0x440/0x440
> > [   10.435963]  [<ffffffffa5543313>] bus_for_each_dev+0x73/0xc0
> > [   10.436676]  [<ffffffffa554519e>] driver_attach+0x1e/0x20
> > [   10.437356]  [<ffffffffa5544bc6>] bus_add_driver+0x1c6/0x290
> > [   10.437978]  [<ffffffffc07e5000>] ? 0xffffffffc07e5000
> > [   10.438699]  [<ffffffffa5546a50>] driver_register+0x60/0xe0
> > [   10.439502]  [<ffffffffc07e5000>] ? 0xffffffffc07e5000
> > [   10.440310]  [<ffffffffa5467e4d>] __pci_register_driver+0x5d/0x60
> > [   10.440313]  [<ffffffffc07e50af>] i2c_i801_init+0xaf/0x1000 [i2c_i801]
> > [   10.440314]  [<ffffffffc07e5000>] ? 0xffffffffc07e5000
> > [   10.440316]  [<ffffffffa5000450>] do_one_initcall+0x50/0x180
> > [   10.440319]  [<ffffffffa5101cc5>] ? rcu_read_lock_sched_held+0x45/0x80
> > [   10.440322]  [<ffffffffa5234e55>] ? kmem_cache_alloc_trace+0x2d5/0x340
> > [   10.440325]  [<ffffffffa51c1252>] do_init_module+0x5f/0x1da
> > [   10.440329]  [<ffffffffa512d615>] load_module+0x2195/0x2950
> > [   10.440331]  [<ffffffffa512a0e0>] ? __symbol_put+0x70/0x70
> > [   10.440334]  [<ffffffffa525dd3b>] ? vfs_read+0x11b/0x130
> > [   10.440337]  [<ffffffffa512e066>] SYSC_finit_module+0xe6/0x120
> > [   10.440339]  [<ffffffffa512e0be>] SyS_finit_module+0xe/0x10
> > [   10.440340]  [<ffffffffa5002fb1>] do_syscall_64+0x61/0x170
> > [   10.440343]  [<ffffffffa581e1da>] entry_SYSCALL64_slow_path+0x25/0x25
> > 
> > 
> > I bisected this to commit 525e6fabeae2 ("i2c / ACPI: add support for
> > ACPI reconfigure notifications").
> > 
> > The reason for the above message seems to be that acpi_i2c_get_info()
> > configures the IRQs for any ACPI devices that have got some
> > I2cSerialBus() resource, regardless of the actual adapter those are
> > attached to. This behaviour is different from before that commit.
> > 
> > My ACPI DSDT has got a PCI I2C adapter that isn't physically present, it
> > seems. No clue why.
> > 
> > That non-existent PCI I2C adapter is in turn I2cSerialBus()-referenced
> > by some ACPI device that has got exactly this interrupt 37 assigned.
> > 
> > So it looks like an attempt is made to configure this non-existent,
> > ACPI-listed I2C slave's IRQs when an actually existing I2C adapter (i801
> > SMBus) gets probed.
> > 
> > 
> > Let me know if I can provide you with any additional information,
> 
> Can you send me acpidump from that that machine?

Can you try if the following patch cures the problem?

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index da3a02ef4a31..4e6c6fde9bdb 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -205,7 +205,7 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 				       void *data, void **return_value)
 {
 	struct i2c_adapter *adapter = data;
-	struct acpi_device *adev;
+	struct acpi_device *adev, *adapter_adev;
 	acpi_handle adapter_handle;
 	struct i2c_board_info info;
 
@@ -218,6 +218,12 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 	if (adapter_handle != ACPI_HANDLE(&adapter->dev))
 		return AE_OK;
 
+	/* The adapter must be present */
+	if (acpi_bus_get_device(adapter_handle, &adapter_adev))
+		return AE_OK;
+	if (acpi_bus_get_status(adapter_adev) || !adapter_adev->status.present)
+		return AE_OK;
+
 	acpi_i2c_register_device(adapter, adev, &info);
 
 	return AE_OK;
