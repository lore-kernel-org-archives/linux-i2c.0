From: Scot Doyle <lkml14@scotdoyle.com>
Subject: Re: [4/4] i2c: designware-pci: Add Haswell PCI IDs
Date: Fri, 6 Jun 2014 23:44:25 +0100 (BST)
Message-ID: <alpine.DEB.2.02.1406062340400.32753@scotdoyle.com>
References: <1400164644-3222-5-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400164644-3222-5-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Yao Jin <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This patch works on a Toshiba CB35 Chromebook, applied against 3.15-rc8.

On Thu, 15 May 2014, Mika Westerberg wrote:
> Intel Haswell has the same I2C host controller than Baytrail and it can
> also be enumerated as a PCI device. Add the PCI IDs to the driver list.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> ---
> drivers/i2c/busses/i2c-designware-pcidrv.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
