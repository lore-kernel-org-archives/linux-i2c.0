From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 0/3] i2c: designware-pci: refactor and add Merrifield
 support
Date: Thu, 16 Jun 2016 10:44:21 +0300
Message-ID: <a653f0b3-0a95-8227-db35-0076c1461827@linux.intel.com>
References: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51293 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbcFPHoY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 16 Jun 2016 03:44:24 -0400
In-Reply-To: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On 06/15/2016 06:05 PM, Andy Shevchenko wrote:
> Tested on bare metal (Intel Edison) by enumerating I2C GPIO expanders.
>
> In v2:
> - leave bus 3 at STD speed for Medfield
> - be consistent with workflow, i.e. call ->setup, and _then_ assign to i2c
>   properties
> - add a comment to explain magic numbers for Merrifield
> - add an Ack for patch 3
>
> Andy Shevchenko (3):
>   i2c: designware-pci: Make bus number allocation robust
>   i2c: designware-pci: Introduce Merrifield support
>   i2c: designware-pci: Sort header block alphabetically
>
>  drivers/i2c/busses/i2c-designware-core.h   |   1 +
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 143 +++++++++++++++++------------
>  2 files changed, 86 insertions(+), 58 deletions(-)
>
> --
> 2.8.1
>
To the series (patch 3 has my ack already):

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
