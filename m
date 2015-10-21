From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: designware: register clkdev during acpi device
 configuration
Date: Wed, 21 Oct 2015 13:02:26 +0300
Message-ID: <20151021100226.GZ1526@lahna.fi.intel.com>
References: <1445323081.3380.25.camel@kxue-X58A-UD3R>
 <20151020111737.GF1526@lahna.fi.intel.com>
 <1445389893.2483.3.camel@kxue-X58A-UD3R>
 <20151021072817.GM1526@lahna.fi.intel.com>
 <1445416943.2977.8.camel@kxue-X58A-UD3R>
 <20151021092553.GX1526@lahna.fi.intel.com>
 <1445420273.2977.10.camel@kxue-X58A-UD3R>
 <20151021094931.GY1526@lahna.fi.intel.com>
 <1445421002.2977.14.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51566 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368AbbJUKCc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 21 Oct 2015 06:02:32 -0400
Content-Disposition: inline
In-Reply-To: <1445421002.2977.14.camel@kxue-X58A-UD3R>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ken Xue <Ken.Xue@amd.com>
Cc: baruch@tkos.co.il, SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Wed, Oct 21, 2015 at 05:50:02PM +0800, Ken Xue wrote:
> After apd was accept in kernel V4.1, there is no issue. But between 3.18
> and V4.1, there will be a problem.

We care about that because?
