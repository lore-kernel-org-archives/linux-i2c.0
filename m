From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v2] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Wed, 16 Dec 2015 18:56:54 -0800
Message-ID: <CAPw-ZTkMm1c6tLkEMiDrE=TENeUe3bm+U+CFHw231ngzWMqPuQ@mail.gmail.com>
References: <1450319025-19120-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1450319025-19120-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, Ken Xue <Ken.Xue@amd.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

> The current driver uses input clock source frequency to calculate
> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
> currently have a good way to provide the frequency information.
> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
> to directly provide these values. So, the clock information should
> no longer be required during probing.
>
> However, since clk can be invalid, additional checks must be done where
> we are making use of it.
>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>
> Note: This has been tested on AMD Seattle RevB for both DT and ACPI.

Tested on X-Gene hardware also.

-Loc
