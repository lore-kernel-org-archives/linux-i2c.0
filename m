From: "Zheng, Ivan" <Ivan.Zheng@amd.com>
Subject: RE: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Wed, 23 Dec 2015 10:02:04 +0000
Message-ID: <BLUPR12MB0451770284D7788418640F699DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com> <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com> <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
 <20151223095237.GJ1758@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151223095237.GJ1758@lahna.fi.intel.com>
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
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Xue, Ken" <Ken.Xue@amd.com>
Cc: Loc Ho <lho@apm.com>, Al Stone <al.stone@linaro.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "jcm@redhat.com" <jcm@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@apm.com" <patches@apm.com>, "Duran, Leo" <leo.duran@amd.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, "Hurwitz,
 Sherry" <sherry.hurwitz@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-i2c@vger.kernel.org

Why/how can Linux driver make use of such non-ACPI defined methods?

Thanks,
Ivan

-----Original Message-----
From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com] 
Sent: Wednesday, December 23, 2015 17:53
To: Xue, Ken
Cc: wsa@the-dreams.de; Suthikulpanit, Suravee; Loc Ho; rjw@rjwysocki.net; lenb@kernel.org; linux-i2c@vger.kernel.org; linux-acpi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; jcm@redhat.com; patches@apm.com; Hurwitz, Sherry; Duran, Leo; Hanjun Guo; Al Stone; Zheng, Ivan; Yu, Xiangliang
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support

On Wed, Dec 23, 2015 at 05:34:01PM +0800, Ken Xue wrote:
> 1) Regarding
> https://msdn.microsoft.com/en-us/library/windows/hardware/dn919852(v=v
> s.85).aspx , Window I2C driver should pass MITT test. There are 5 I2C 
> devices connect to one I2C bus for test. And those devices defined 
> different "ConnectionSpeed" over the I2C bus by ACPI resource 
> "I2CSerialBus".
> 
> During test, I2C bus should run in different "ConnectionSpeed" of 
> device.
> 
> That means windows driver can modify I2C bus speed to match the 
> "ConnectionSpeed" of device on-the-fly. Static value from SSCN and 
> FMCN can not work for WITT test cases.

That is why there are *CNT methods for all supported I2C modes:

  - SSCN() - returns for standard mode (100kHz)
  - FMCN() - returns for fast mode (400kHz)
  - FPCN() - returns for fast mode+ (1MHz)
 
for High-speed mode I'm not sure what the method name is ;-)

Then the Windows driver switches between those based on what the ConnectionSpeed is in the ACPI I2C connector.
