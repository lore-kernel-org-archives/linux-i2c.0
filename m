From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Wed, 23 Dec 2015 13:40:09 +0200
Message-ID: <20151223114009.GM1758@lahna.fi.intel.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com>
 <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com>
 <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
 <20151223095237.GJ1758@lahna.fi.intel.com>
 <BLUPR12MB0451770284D7788418640F699DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
 <20151223100959.GK1758@lahna.fi.intel.com>
 <BLUPR12MB0451852E89B0848DA16067609DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31683 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531AbbLWLkQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Dec 2015 06:40:16 -0500
Content-Disposition: inline
In-Reply-To: <BLUPR12MB0451852E89B0848DA16067609DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Zheng, Ivan" <Ivan.Zheng@amd.com>
Cc: "Xue, Ken" <Ken.Xue@amd.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, Loc Ho <lho@apm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jcm@redhat.com" <jcm@redhat.com>, "patches@apm.com" <patches@apm.com>, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, "Duran, Leo" <leo.duran@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>

On Wed, Dec 23, 2015 at 11:24:44AM +0000, Zheng, Ivan wrote:
> I'm a BIOS engineer and my point is that such non-ACPI defined methods
> rely on BIOS implementation, so how the generic I2C driver works on a
> platform without such methods? Should the vendor implement their own
> driver in such case?

Those methods are by *no* means meant for generic driver. They are
specific to DesignWare I2C driver.

If you need to specify bus speed that the device is supposed to use,
you put it to the I2cSerialBus() resource (ConnectionSpeed)...

> I think Windows driver use ConnectionSpeed field in I2CSerialBus
> declaration for a certain device and it's defined in ACPI 5.0.

..like you say here.

We just need to add support for ConnectionSpeed to Linux I2C core.
