From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v4] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Wed, 13 Jan 2016 16:46:41 -0600
Message-ID: <5696D3D1.2010509@amd.com>
References: <1451920655-10798-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20160110083812.GE1526@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0061.outbound.protection.outlook.com ([207.46.100.61]:3140
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750744AbcAMWqv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 13 Jan 2016 17:46:51 -0500
In-Reply-To: <20160110083812.GE1526@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>

On 1/10/2016 2:38 AM, Wolfram Sang wrote:
> On Mon, Jan 04, 2016 at 09:17:35AM -0600, Suravee Suthikulpanit wrote:
>> The current driver uses input clock source frequency to calculate
>> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
>> currently have a good way to provide the frequency information.
>> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
>> to directly provide these values. So, the clock information should
>> no longer be required during probing.
>>
>> However, since clk can be invalid, additional checks must be done where
>> we are making use of it.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Loc Ho <lho@apm.com>
>
> Applied to for-next, thanks! Also thanks to all reviewers and testers.
>
Thank you,
Suravee
