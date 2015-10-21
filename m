From: Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH 1/2] i2c: designware: register clkdev during acpi device
 configuration
Date: Wed, 21 Oct 2015 09:11:33 +0800
Message-ID: <1445389893.2483.3.camel@kxue-X58A-UD3R>
References: <1445323081.3380.25.camel@kxue-X58A-UD3R>
	 <20151020111737.GF1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0071.outbound.protection.outlook.com ([65.55.169.71]:42560
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751695AbbJUBQ0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 21:16:26 -0400
In-Reply-To: <20151020111737.GF1526@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: baruch@tkos.co.il, SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Tue, 2015-10-20 at 14:17 +0300, Mika Westerberg wrote:
> On Tue, Oct 20, 2015 at 02:38:01PM +0800, Ken Xue wrote:
> > DW I2C driver tries to register a clk from id->driver_data as an
> > alternative way besides intel lpss. But code doesn't register the
> > clk to clkdev. So, devm_clk_get will fail during probe.
> > 
> > The patch can fix this issue.
> 
> Since you now have drivers/acpi/acpi_apd.c for AMD ACPI stuff, can you
> create the clock there just like we do for Intel stuff?
Sure. APD already creates the clock for AMD0010 as you expected. And the
next patch([PATCH 2/2] i2c: designware: remove freq definition for
"AMD0010" in acpi_device_id) is dropping the old way for getting freq.
