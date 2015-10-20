From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: designware: register clkdev during acpi device
 configuration
Date: Tue, 20 Oct 2015 14:17:37 +0300
Message-ID: <20151020111737.GF1526@lahna.fi.intel.com>
References: <1445323081.3380.25.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54196 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbbJTLRl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 07:17:41 -0400
Content-Disposition: inline
In-Reply-To: <1445323081.3380.25.camel@kxue-X58A-UD3R>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ken Xue <Ken.Xue@amd.com>
Cc: baruch@tkos.co.il, SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Tue, Oct 20, 2015 at 02:38:01PM +0800, Ken Xue wrote:
> DW I2C driver tries to register a clk from id->driver_data as an
> alternative way besides intel lpss. But code doesn't register the
> clk to clkdev. So, devm_clk_get will fail during probe.
> 
> The patch can fix this issue.

Since you now have drivers/acpi/acpi_apd.c for AMD ACPI stuff, can you
create the clock there just like we do for Intel stuff?
