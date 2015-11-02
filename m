From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/5] i2c-piix4: Convert piix4_main_adapter to array
Date: Mon, 2 Nov 2015 12:47:42 +0200
Message-ID: <20151102104742.GF1509@lahna.fi.intel.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
 <1446395529-9987-3-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41905 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbbKBKty (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 05:49:54 -0500
Content-Disposition: inline
In-Reply-To: <1446395529-9987-3-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com

On Sun, Nov 01, 2015 at 05:32:06PM +0100, Christian Fetzer wrote:
> The SB800 chipset supports a multiplexed main SMBus controller with
> four ports. Therefore the static variable piix4_main_adapter is
> converted into a piix4_main_adapters array that can hold one
> i2c_adapter for each multiplexed port.
> 
> The auxiliary adapter remains unchanged since it represents the second
> (not multiplexed) SMBus controller on the SB800 chipset.
> 
> Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>

Looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
