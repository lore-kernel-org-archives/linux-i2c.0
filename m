From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Mon, 4 Jan 2016 09:09:37 +0000
Message-ID: <568A36D1.8070808@codethink.co.uk>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com> <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com> <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:54831 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcADJJp (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Jan 2016 04:09:45 -0500
In-Reply-To: <1450863241.7740.30.camel@kxue-X58A-UD3R>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ken Xue <ken.xue@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, wsa@the-dreams.de
Cc: Ivan.Zheng@amd.com, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, jcm@redhat.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, patches@apm.com, "Duran, Leo" <leo.duran@amd.com>, linux-i2c@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, Xiangliang.Yu@amd.com, lenb@kernel.org, linux-arm-kernel@lists.infradead.org, Loc Ho <lho@apm.com>

On 23/12/15 09:34, Ken Xue wrote:
> On Tue, 2015-12-15 at 16:59 +0200, Mika Westerberg wrote:
>> On Tue, Dec 15, 2015 at 08:52:19AM -0600, Suravee Suthikulpanit wrote:

> During test, I2C bus should run in different "ConnectionSpeed" of
> device.
> 
> That means windows driver can modify I2C bus speed to match the
> "ConnectionSpeed" of device on-the-fly. Static value from SSCN and FMCN
> can not work for WITT test cases.
> 
> It sounds like odd that multi-speed can be applied over one I2C bus, But
> everything goes well.
> Does this behavior(multi-speed) violate the I2C spec?

I can't remember if the spec says it, but I would say the bus should
run at the speed of the slowest attached peripheral as they all have
to listen for the address-byte being sent at the start of each i2c
transaction.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
