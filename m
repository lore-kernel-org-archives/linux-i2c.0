From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/5] i2c-piix4: Optionally release smba in
 piix4_adap_remove
Date: Mon, 9 Nov 2015 13:24:48 +0200
Message-ID: <20151109112448.GA1509@lahna.fi.intel.com>
References: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
 <1446896126-13369-2-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42181 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbbKILYx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 9 Nov 2015 06:24:53 -0500
Content-Disposition: inline
In-Reply-To: <1446896126-13369-2-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com

On Sat, Nov 07, 2015 at 12:35:22PM +0100, Christian Fetzer wrote:
> This is in preparation to support the multiplexed SMBus main controller
> in the SB800 chipset where the controller address is shared among
> the four multiplexed ports. As such the address region should be
> only freed for the first multiplexed adapter to avoid double free
> warnings.
> 
> Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
