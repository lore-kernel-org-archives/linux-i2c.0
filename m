From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH v2] I2C: designware: fix IO timeout issue for AMD
 controller
Date: Sun, 13 Dec 2015 12:01:57 +0000
Message-ID: <BLUPR12MB042075472454F9F15D40FFC2EBEC0@BLUPR12MB0420.namprd12.prod.outlook.com>
References: <1449835373-4669-1-git-send-email-Xiangliang.Yu@amd.com>
 <20151212170322.GB1530@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0064.outbound.protection.outlook.com ([65.55.169.64]:34582
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751273AbbLMMRS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 13 Dec 2015 07:17:18 -0500
In-Reply-To: <20151212170322.GB1530@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Sunday, December 13, 2015 1:03 AM
> To: Yu, Xiangliang
> Cc: andriy.shevchenko@linux.intel.com; jarkko.nikula@linux.intel.com;
> mika.westerberg@linux.intel.com; linux-i2c@vger.kernel.org; linux-
> kernel@vger.kernel.org; SPG_Linux_Kernel
> Subject: Re: [PATCH v2] I2C: designware: fix IO timeout issue for AMD
> controller
> 
> On Fri, Dec 11, 2015 at 08:02:53PM +0800, Xiangliang Yu wrote:
> > Because of some hardware limitation, AMD I2C controller can't trigger
> > pending interrupt if interrupt status has been changed after clearing
> > interrupt status bits. Then, I2C will lost interrupt and IO timeout.
> >
> > According to hardware design, this patch implements a workaround to
> > disable i2c controller interrupt and re-enable i2c interrupt before
> > exiting ISR.
> >
> > To reduce the performance impacts on other vendors, use unlikely
> > function to check flag in ISR.
> > ---
> 
> Don't manually add "---". This breaks a lot of workflow scripts.
> "Patchwork" missed your Signed-off, for example!
Sorry for my mistake. 

> > Changes in v2:
> >     - pass flags with ->driver_data
> >     - unmask interrupt right after masking
> 
> This paragraph...
>
> >
> > Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> > ---
> 
> ... needs to go here.
> 
> However, I fixed it this time and applied to for-current, thanks!

Thank you very much!
