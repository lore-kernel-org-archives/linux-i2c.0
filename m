From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Do not require clock when SSCN and FFCN
 are provided
Date: Wed, 16 Dec 2015 17:04:46 +0200
Message-ID: <20151216150446.GY1762@lahna.fi.intel.com>
References: <1450219138-5868-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151216094202.GR1762@lahna.fi.intel.com>
 <56717100.3020602@amd.com>
 <20151216142810.GW1762@lahna.fi.intel.com>
 <567178D2.30002@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45544 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbbLPPHW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 16 Dec 2015 10:07:22 -0500
Content-Disposition: inline
In-Reply-To: <567178D2.30002@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: wsa@the-dreams.de, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Wed, Dec 16, 2015 at 08:44:34AM -0600, Suravee Suthikulpanit wrote:
> I am trying to avoid having to hard-coded clock frequency value in the
> driver. Would it be alright to not return w/ error, and just do the
> following?
> 
> 	dev->clk = devm_clk_get(&pdev->dev, NULL);
> 	if (!IS_ERR(dev->clk))
> 		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
> 
> This should work for the Intel case when clock is also provided.

Does it also work when clk_prepare_enable()/disable() is called for the
clock (in PM callbacks for example)? If yes, then I don't see problems
with what you are suggesting.
