From: Ken Xue <ken.xue@amd.com>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Wed, 23 Dec 2015 17:59:49 +0800
Message-ID: <1450864789.7740.35.camel@kxue-X58A-UD3R>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
	 <566F6485.2000508@amd.com> <20151215132721.GJ1762@lahna.fi.intel.com>
	 <56702923.9010305@amd.com> <20151215145953.GK1762@lahna.fi.intel.com>
	 <1450863241.7740.30.camel@kxue-X58A-UD3R>
	 <20151223095237.GJ1758@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0064.outbound.protection.outlook.com ([207.46.100.64]:26256
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753672AbbLWKGJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Dec 2015 05:06:09 -0500
In-Reply-To: <20151223095237.GJ1758@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: wsa@the-dreams.de, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Loc Ho <lho@apm.com>, rjw@rjwysocki.net, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, "Duran, Leo" <leo.duran@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>, Ivan.Zheng@amd.com, Xiangliang.Yu@amd.com

On Wed, 2015-12-23 at 11:52 +0200, Mika Westerberg wrote:
> On Wed, Dec 23, 2015 at 05:34:01PM +0800, Ken Xue wrote:
> > 1) Regarding
> > https://msdn.microsoft.com/en-us/library/windows/hardware/dn919852(v=vs.85).aspx
> > , Window I2C driver should pass MITT test. There are 5 I2C devices
> > connect to one I2C bus for test. And those devices defined different
> > "ConnectionSpeed" over the I2C bus by ACPI resource "I2CSerialBus".
> > 
> > During test, I2C bus should run in different "ConnectionSpeed" of
> > device.
> > 
> > That means windows driver can modify I2C bus speed to match the
> > "ConnectionSpeed" of device on-the-fly. Static value from SSCN and FMCN
> > can not work for WITT test cases.
> 
> That is why there are *CNT methods for all supported I2C modes:
> 
>   - SSCN() - returns for standard mode (100kHz)
>   - FMCN() - returns for fast mode (400kHz)
>   - FPCN() - returns for fast mode+ (1MHz)
>  
> for High-speed mode I'm not sure what the method name is ;-)
> 
> Then the Windows driver switches between those based on what the
> ConnectionSpeed is in the ACPI I2C connector.

Window driver can set Bus speed based on "ConnectionSpeed". But Current
Linux driver only sets Bus speed during probe. How can Linux diver
determine which Bus speed should be applied, if all *CNT methods return
non-zero? 
