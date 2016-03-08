From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH v2] i2c/designware: enable i2c controller to
 suspend/resume asynchronously
Date: Tue, 8 Mar 2016 16:05:43 +0800
Message-ID: <56DE87D7.7060205@linux.intel.com>
References: <569893D1.5050403@linux.intel.com>
 <56AF73E1.7080501@linux.intel.com>
 <1454339763.32507.26.camel@linux.intel.com>
 <20160201155422.GC10607@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43665 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754118AbcCHIGi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 8 Mar 2016 03:06:38 -0500
In-Reply-To: <20160201155422.GC10607@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 2/1/2016 11:54 PM, Wolfram Sang wrote:
>>>> device may be completed in separate kernel thread. PM core ensures
>>>> all power state transition dependency between devices. This patch
> I'd like an Ack on that from a PM maintainer, because I think chips like
> PMICs are special and might not be covered by the generic case...
>
>> Besides that we have to be really aware about DMA power related fix
>> introduced in v4.5-rc1 in acpi_lpss.c [1]. So, I would like to see a
>> wide testing especially on Intel Baytrail / Braswell platforms before
>> enabling it.
> And this one, too.
Because of long leave, so sorry for very late reply.

I agree with you. Need more investigation and test for this patch before enabling it.


Thanks,
Zhonghui
>
