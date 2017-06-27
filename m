From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v12 2/2] i2c: designware: enable SLAVE in platform module
Date: Tue, 27 Jun 2017 17:11:58 +0300
Message-ID: <d42e4282-617d-2154-e62c-14f2b75c6827@linux.intel.com>
References: <cover.1498126241.git.lolivei@synopsys.com>
 <258fe2f0cc73bcb8be6e7b61418a64a1927acf4e.1498126241.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:60940 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752486AbdF0OOh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Jun 2017 10:14:37 -0400
In-Reply-To: <258fe2f0cc73bcb8be6e7b61418a64a1927acf4e.1498126241.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 06/22/2017 01:17 PM, Luis Oliveira wrote:
> - Slave mode selected in platform module if the support is detected in
>   the DT.
>
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> V11-V12
> - no changes
>
>  drivers/i2c/busses/i2c-designware-core.h    |  2 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c | 41 +++++++++++++++++++++++++----
>  2 files changed, 38 insertions(+), 5 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
