From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Wed, 23 Dec 2015 12:09:59 +0200
Message-ID: <20151223100959.GK1758@lahna.fi.intel.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com>
 <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com>
 <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
 <20151223095237.GJ1758@lahna.fi.intel.com>
 <BLUPR12MB0451770284D7788418640F699DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27943 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933962AbbLWKKG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Dec 2015 05:10:06 -0500
Content-Disposition: inline
In-Reply-To: <BLUPR12MB0451770284D7788418640F699DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Zheng, Ivan" <Ivan.Zheng@amd.com>
Cc: "Xue, Ken" <Ken.Xue@amd.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, Loc Ho <lho@apm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jcm@redhat.com" <jcm@redhat.com>, "patches@apm.com" <patches@apm.com>, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, "Duran, Leo" <leo.duran@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>

On Wed, Dec 23, 2015 at 10:02:04AM +0000, Zheng, Ivan wrote:
> Why/how can Linux driver make use of such non-ACPI defined methods?

What do you mean exactly?

I added support for these (well, SSCN and FMCN) because I found out that
some vendors include such methods with their BIOS implementation.
Windows driver uses these if present and so do we.
