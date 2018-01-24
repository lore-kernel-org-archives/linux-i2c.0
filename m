From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 10:12:53 -0500
Message-ID: <f918bbf3-1f9a-df63-9906-7147620ee6cf@codeaurora.org>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
 <20180124055615.c3qwhwnj7spmcr3w@ninjato>
 <20180124062725.GK27654@lahna.fi.intel.com>
 <f498c1ef-0e15-3956-8e70-bca53ec2cac4@codeaurora.org>
 <CAHp75VexHQS20azPFO5uv+sBQ4QYVXL+yhT56EhT+QmNZfzMFg@mail.gmail.com>
 <54ef10bd-6209-6983-1d3a-ddf7d7fea252@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934032AbeAXPMz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 24 Jan 2018 10:12:55 -0500
In-Reply-To: <54ef10bd-6209-6983-1d3a-ddf7d7fea252@redhat.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 1/24/2018 9:59 AM, Hans de Goede wrote:
> TL;DR: I have to NAK this, I'm sorry but with the current state of ACPI we
> must simply have some stuff builtin to help with probe-ordering issues. Now
> if the ACPI code where ever to honor the _DEP method everywhere instead of
> only for battery devices this might change, but even then things will still
> be tricky.

Well, the alternative is even worse.

Redhat and most other distros configure I2C as a module. With this setup,
I2C OpRegion support does not get compiled. It doesn't even work let alone to have
race conditions. 

I2C OpRegion feature is practically dead for most general users unless you recompile
your own kernel.

There must be a middle ground somewhere.

I had some conversation with Rafael about _DEP support. He is not a big fan :)

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
