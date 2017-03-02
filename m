From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RESEND PATCH v6 2/6] i2c: designware: refactoring of the
 i2c-designware
Date: Thu, 2 Mar 2017 15:40:56 +0200
Message-ID: <aeb4f4b8-5d0a-f8bc-55da-f8e407f3ea8e@linux.intel.com>
References: <cover.1488383202.git.lolivei@synopsys.com>
 <6fabfa1a657d6bac108bd91f8ac33295a5086987.1488383202.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23139 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752230AbdCBNyX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 2 Mar 2017 08:54:23 -0500
In-Reply-To: <6fabfa1a657d6bac108bd91f8ac33295a5086987.1488383202.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 03/01/17 17:59, Luis Oliveira wrote:
> - Factor out all _master() part of code from i2c-designware-core
>   and i2c-designware-platdrv to separate functions.
> - Standardize all code related with MASTER mode.
> - I have to take off DW_IC_INTR_TX_EMPTY from DW_IC_INTR_DEFAULT_MASK
>   because it is master specific.
>
> The purpose of this is to prepare the controller to have is I2C MASTER
> flow in a separate driver. To do this first all the
> functions/definitions related to the MASTER flow were identified.
>
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> V5->v6
> - Removed the __func__ of dev_dbg prints
> - Fix i2c_dw_configure_master() to accept dw_i2c_dev *
>
>  drivers/i2c/busses/i2c-designware-core.c    | 56 +++++++++++++++++------------
>  drivers/i2c/busses/i2c-designware-platdrv.c | 31 +++++++++-------
>  2 files changed, 52 insertions(+), 35 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
