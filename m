From: Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH 1/2] i2c: designware: register clkdev during acpi device
 configuration
Date: Fri, 23 Oct 2015 13:29:14 +0800
Message-ID: <1445578154.2977.24.camel@kxue-X58A-UD3R>
References: <1445323081.3380.25.camel@kxue-X58A-UD3R>
	 <20151020111737.GF1526@lahna.fi.intel.com>
	 <1445389893.2483.3.camel@kxue-X58A-UD3R>
	 <20151021072817.GM1526@lahna.fi.intel.com>
	 <1445416943.2977.8.camel@kxue-X58A-UD3R>
	 <20151021092553.GX1526@lahna.fi.intel.com>
	 <1445420273.2977.10.camel@kxue-X58A-UD3R>
	 <20151021094931.GY1526@lahna.fi.intel.com>
	 <1445421002.2977.14.camel@kxue-X58A-UD3R>
	 <20151021104650.GA1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151021104650.GA1526@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: baruch@tkos.co.il, SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-10-21 at 13:46 +0300, Mika Westerberg wrote:
> You are saying that the original commit a445900c906092 ("i2c:
> designware: Add support for AMD I2C controller") actually never worked
> because it failed to register the clock with clkdev? In that case it is
> not even a regression ;-) Oh my...

You are right :-). The new patch for reverting a445900c906092 is
submitted.
Please help to review. Thanks.
