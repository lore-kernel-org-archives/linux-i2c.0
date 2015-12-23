From: "Zheng, Ivan" <Ivan.Zheng@amd.com>
Subject: RE: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Wed, 23 Dec 2015 11:24:44 +0000
Message-ID: <BLUPR12MB0451852E89B0848DA16067609DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com> <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com> <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
 <20151223095237.GJ1758@lahna.fi.intel.com>
 <BLUPR12MB0451770284D7788418640F699DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
 <20151223100959.GK1758@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151223100959.GK1758@lahna.fi.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Al Stone <al.stone@linaro.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "jcm@redhat.com" <jcm@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@apm.com" <patches@apm.com>, "Duran, Leo" <leo.duran@amd.com>, Loc Ho <lho@apm.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, "Yu,
 Xiangliang" <Xiangliang.Yu@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Xue,
 Ken" <Ken.Xue@amd.com>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-i2c@vger.kernel.org

Thanks Mika for the background.

I'm a BIOS engineer and my point is that such non-ACPI defined methods rely on BIOS implementation, so how the generic I2C driver works on a platform without such methods? Should the vendor implement their own driver in such case?

I think Windows driver use ConnectionSpeed field in I2CSerialBus declaration for a certain device and it's defined in ACPI 5.0.

Thanks,
Ivan

-----Original Message-----
From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com] 
Sent: Wednesday, December 23, 2015 18:10
To: Zheng, Ivan
Cc: Xue, Ken; wsa@the-dreams.de; Suthikulpanit, Suravee; Loc Ho; rjw@rjwysocki.net; lenb@kernel.org; linux-i2c@vger.kernel.org; linux-acpi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; jcm@redhat.com; patches@apm.com; Hurwitz, Sherry; Duran, Leo; Hanjun Guo; Al Stone; Yu, Xiangliang
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support

On Wed, Dec 23, 2015 at 10:02:04AM +0000, Zheng, Ivan wrote:
> Why/how can Linux driver make use of such non-ACPI defined methods?

What do you mean exactly?

I added support for these (well, SSCN and FMCN) because I found out that some vendors include such methods with their BIOS implementation.
Windows driver uses these if present and so do we.
