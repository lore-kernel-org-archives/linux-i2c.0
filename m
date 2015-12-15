From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Tue, 15 Dec 2015 16:59:53 +0200
Message-ID: <20151215145953.GK1762@lahna.fi.intel.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com>
 <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25469 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457AbbLOPAB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 15 Dec 2015 10:00:01 -0500
Content-Disposition: inline
In-Reply-To: <56702923.9010305@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Loc Ho <lho@apm.com>, wsa@the-dreams.de, Ken.Xue@amd.com, Jeff.Wu@amd.com, rjw@rjwysocki.net, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, "Duran, Leo" <leo.duran@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>

On Tue, Dec 15, 2015 at 08:52:19AM -0600, Suravee Suthikulpanit wrote:
> 
> 
> On 12/15/2015 07:27 AM, Mika Westerberg wrote:
> >On Mon, Dec 14, 2015 at 06:53:25PM -0600, Suravee Suthikulanit wrote:
> >>>I'm not sure if this has been discussed earlier. But after looking at the
> >>>the acpi_apd driver, all we need is just the platform-specific input clock
> >>>frequency value used by the drivers/i2c/busses/i2c-designware-core.c:
> >>>i2c_dw_init() to calculate the values to program into the DW_IC_SS_SCL_HCNT
> >>>and DW_IC_SS_SCL_LCNT registers.
> >There is a way to pass *CNT values already from ACPI to the driver -- It
> >looks for method called FMCN (or SSCN) and retrieves the values from
> >there if found.
> 
> Right, I also noticed this afterward. By the way, are FMCN and SSCN
> documented anywhere in the ACPI spec?  I am trying to figure out how to
> update the ACPI table to add this information for the AMD Seattle (ARM64)
> platform, and I will also submit a patch to add the new HID for this driver.

No, they are Intel inventions for the Windows I2C driver.

Here is what I know about it:
  SSCN - Standard Mode CNTs
  FMCN - Fast Mode CNTs

They both return a package:

  Package() {
    HCNT,
    LCNT,
    SDA_hold_time,
  }
