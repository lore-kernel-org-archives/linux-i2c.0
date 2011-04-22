From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2.6.39-rc3] i2c-i801: SMBus patch for Intel Panther
 Point DeviceIDs
Date: Fri, 22 Apr 2011 18:44:49 +0200
Message-ID: <20110422184449.06116327@endymion.delvare>
References: <201104201133.39979.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201104201133.39979.seth.heasley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-i2c@vger.kernel.org

Hi Seth,

On Wed, 20 Apr 2011 11:33:39 -0700, Seth Heasley wrote:
> This patch adds the SMBus controller DeviceID for the Intel Panther Point PCH.

With each new chip, we have to add the SMBus device ID to pci_ids.h,
then wait for Jesse to merge that, and only then I can apply the
changes to i2c-i801.c. This approach slows things down needlessly.

It isn't mandatory to add IDs to pci_ids.h when an ID is only used
locally in a device driver. So what I would like to propose is that we
move all PCI_DEVICE_ID_INTEL_*_SMBUS declarations from pci_ids.h to
i2c-i801.c now. Then you can resubmit your Panther Point patches, and
the pci and i2c parts will be independent, so Jesse and myself don't
depend on each other to apply them.

What do you think? Jesse, any objection?

Seth, if you agree, I can take care of the move, or you can send a
patch doing that, whatever you prefer.

-- 
Jean Delvare
