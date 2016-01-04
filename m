From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH v3] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Mon, 4 Jan 2016 09:17:26 -0600
Message-ID: <568A8D06.2010901@amd.com>
References: <1450820141-1720-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1450895221.30729.322.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0081.outbound.protection.outlook.com ([207.46.100.81]:26304
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751581AbcADPRi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 10:17:38 -0500
In-Reply-To: <1450895221.30729.322.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: jarkko.nikula@linux.intel.com, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andy,

On 12/23/2015 12:27 PM, Andy Shevchenko wrote:
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> >b/drivers/i2c/busses/i2c-designware-platdrv.c
>> >index 8ffc36b..04edd09 100644
>> >--- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> >+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> Can we introduce
>
> static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool
> prepare)
> {
> 	if (IS_ERR(i_dev->clk))
> 		return PTR_ERR(i_dev->clk);
>
> 	if (prepare)
> /* REMOVEME: Yes, you have to check return value and this is one
> benefit of this change */
> 		return clk_prepare_enable(i_dev->clk);
>
> 	clk_disable_unprepare(i_dev->clk);
> 	return 0;
> }
>
> and=E2=80=A6
>

Yes, I think this change. I'll put this in the V4, and send out soon.

Suravee
