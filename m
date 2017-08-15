From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH 1/1] i2c: i801: Restore the presence state of P2SB PCI
 device after reading BAR
Date: Tue, 15 Aug 2017 10:13:28 +0300
Message-ID: <20170815071328.GJ2369@lahna.fi.intel.com>
References: <20170814160450.21978-1-qiuxu.zhuo@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40226 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753320AbdHOHOO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Aug 2017 03:14:14 -0400
Content-Disposition: inline
In-Reply-To: <20170814160450.21978-1-qiuxu.zhuo@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: jdelvare@suse.com, wsa@the-dreams.de, tony.luck@intel.com, bp@alien8.de, linux-i2c@vger.kernel.org

On Tue, Aug 15, 2017 at 12:04:50AM +0800, Qiuxu Zhuo wrote:
> Sun, Yunying reported the following failure on Denverton micro-server:
> 
>  EDAC DEBUG: pnd2_init:
>  EDAC DEBUG: pnd2_probe:
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_tolud_pci=00000000_80000000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_touud_lo_pci=00000000_80000000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_touud_hi_pci=00000000_00000004
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_asym_mem_region0_mchbar=00000000_00000000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_asym_mem_region1_mchbar=00000000_00000000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_mot_out_base_mchbar=00000000_00000000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_mot_out_mask_mchbar=00000000_00000000
>  EDAC pnd2: Failed to register device with error -19.
> 
> On Denverton micro-server, the presence of the P2SB bridge PCI device is
> enabled or disabled by the item 'RelaxSecConf' in BIOS setup menu. When
> 'RelaxSecConf' is enabled, the P2SB PCI device is present and the pnd2_edac
> EDAC driver also uses it to get BAR. Hiding the P2SB PCI device caused the
> pnd2_edac EDAC driver failed to get BAR then reported the above failure.
> 
> Therefor, store the presence state of P2SB PCI device before unhiding it
> for reading BAR and restore the presence state after reading BAR.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reported-and-tested-by: Yunying Sun <yunying.sun@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
