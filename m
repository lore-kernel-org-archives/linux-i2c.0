From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix bogus sda_hold_time due to
 uninitialized vars
Date: Mon, 22 May 2017 09:37:13 +0300
Message-ID: <aad364b9-75ce-553e-28da-a5458b90b332@linux.intel.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
 <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21711 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdEVGj0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 22 May 2017 02:39:26 -0400
In-Reply-To: <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/22/2017 08:46 AM, Jan Kiszka wrote:
> We need to initializes those variables to 0 for platforms that do not
> provide ACPI parameters. Otherwise, we set sda_hold_time to random
> values, breaking e.g. Galileo and IOT2000 boards.
>
> Fixes: 9d6408433019 ("i2c: designware: don't infer timings described by ACPI from clock rate")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Affects 4.12-rc2.
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
