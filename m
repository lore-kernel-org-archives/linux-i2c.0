From: Jason Baron <jbaron-JqFfY2XvxFXQT0dZR+AlfA@public.gmane.org>
Subject: i2c_i801: status of use hardware semaphore patch?
Date: Thu, 21 Mar 2013 18:07:40 -0400
Message-ID: <514B84AC.6040703@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I've also hit the i2c_i801 driver conflicts with ACPI region:

kernel: [73904.044722] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18
(level, low) -> IRQ 18
kernel: [73904.045573] ACPI: resource 0000:00:1f.3 [io  0xf000-0xf01f]
conflicts with ACPI region SMBI [io 0xf000-0xf00f]
kernel: [73904.046461] ACPI: If an ACPI driver is available for this
device, you should use it instead of the native driver

I tested this patch: http://marc.info/?l=linux-i2c&m=135188429220187&w=2

And it avoids the warning (as we no longer check for acpi conflicts).
However, I don't see the patch in any trees. Are there
any reservations in applying it?

Thanks,

-Jason
