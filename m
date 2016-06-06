From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/3] i2c: core/designware: Find bus speed from ACPI
Date: Mon, 6 Jun 2016 19:06:05 +0300
Message-ID: <20160606160605.GF1791@lahna.fi.intel.com>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:45228 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbcFFQGK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 6 Jun 2016 12:06:10 -0400
Content-Disposition: inline
In-Reply-To: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>

On Mon, Jun 06, 2016 at 02:26:20PM +0300, Jarkko Nikula wrote:
> These patches add support to i2c-core for finding the bus speed from
> ACPI by looking at slowest connection from ACPI I2cSerialBus resources
> that are associated to I2C controller and use it in i2c-designware.
> 
> i2c-core patches apply on top of v4.7-rc1 and i2c-designware change is
> on top of Weifeng's fast mode + and high speed set:
> 
> http://www.spinics.net/lists/linux-i2c/msg24699.html
> 
> Jarkko Nikula (3):
>   i2c: core: Cleanup I2C ACPI namespace
>   i2c: core: Add function for finding the bus speed from ACPI
>   i2c: designware: Find bus speed from ACPI

For the whole series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
