From: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Subject: Re: [PATCH v2 3/4] Device bindings documentation updated ACPI-enabled
 platforms not currently supported
Date: Tue, 18 Oct 2016 15:50:08 +0100
Message-ID: <b0ced156-fa38-8283-167f-872f6d3dd9c5@synopsys.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
 <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
 <20161014173014.GA26269@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:45807 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbcJROuO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 18 Oct 2016 10:50:14 -0400
In-Reply-To: <20161014173014.GA26269@leverpostej>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Luis.Oliveira@synopsys.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, CARLOS.PALMINHA@synopsys.com, Ramiro.Oliveira@synopsys.com

On 10/14/2016 6:30 PM, Mark Rutland wrote:
> On Fri, Oct 14, 2016 at 05:52:50PM +0100, Luis.Oliveira@synopsys.com wrote:
>> -		is_slave = device_property_read_bool(&pdev->dev, "isslave");
> Which tree is this based on? I cant see the existing isslave property in
> mainline HEAD (commit 29fbff8698fc0ac1).

I'm replying for Luís, since at the moment he's not able to reply.

This is a custom property since this I2C core doesn't support both master and
slave at the same time.

>
>> +#ifndef CONFIG_ACPI
>> +		is_slave = device_property_read_bool(&pdev->dev, "is-slave");
>> +#endif
> This ifdef is broken. At least for arm64, a single kernel image can be
> booted with either ACPI or DT. We need separate accessors for DT and
> ACPI to handle these differently, or you need to explicitly check
> whether or not you have ACPI or DT at runtime.

Thanks for the feedback, I'll take a look at this

>
> Thanks,
> Mark.

Thanks,
Ramiro
