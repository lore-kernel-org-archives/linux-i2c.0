From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/6] i2c: designware: Remove interrupt clearing from i2c_dw_pci_probe()
Date: Mon, 12 Oct 2015 14:14:18 +0300
Message-ID: <561B960A.7060400@linux.intel.com>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com> <1441031493-18938-2-git-send-email-jarkko.nikula@linux.intel.com> <20151010075337.GE1619@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31586 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbbJLLOV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 12 Oct 2015 07:14:21 -0400
In-Reply-To: <20151010075337.GE1619@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On 10/10/2015 10:53 AM, Wolfram Sang wrote:
> On Mon, Aug 31, 2015 at 05:31:28PM +0300, Jarkko Nikula wrote:
>> There is no need to clear interrupts in i2c_dw_pci_probe() since only place
>> where interrupts are unmasked is i2c_dw_xfer_init() and there interrupts
>> are always cleared after commit 2a2d95e9d6d2 ("i2c: designware: always
>> clear interrupts before enabling them").
>
> Still, their status might be unclear when we init because firmware might
> have used it before. It should be easy to reintroduce this in patch 6,
> or?
>
Yes and then it would be also uniform across different enumeration 
methods if we ever need to add it. Now this clearing was done only for 
PCI devices. Although I don't think there is any need to add clearing to 
probe path as clearing happens beginning of transmit before enabling the 
interrupts.

-- 
Jarkko
