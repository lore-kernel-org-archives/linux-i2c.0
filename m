From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 2/3] i2c-piix4: Add support for multiplexed main
 adapter in SB800
Date: Mon, 16 Nov 2015 14:31:54 +0200
Message-ID: <20151116123154.GC1604@lahna.fi.intel.com>
References: <1447587184-21965-1-git-send-email-fetzer.ch@gmail.com>
 <1447587184-21965-3-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7431 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbbKPMeI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 16 Nov 2015 07:34:08 -0500
Content-Disposition: inline
In-Reply-To: <1447587184-21965-3-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>

On Sun, Nov 15, 2015 at 12:33:03PM +0100, Christian Fetzer wrote:
> The SB800 chipset supports a multiplexed main SMBus controller with
> four ports. The multiplexed ports share the same SMBus address and
> register set. The port is selected by bits 2:1 of the smb_en register
> (0x2C).
> 
> Only one port can be active at any point in time therefore a mutex is
> needed in order to synchronize access.
> 
> Additionally, the commit avoids requesting and releasing the SMBus base
> address index region on every multiplexed transfer by moving the
> request_region call into piix4_probe.
> 
> Tested on HP ProLiant MicroServer G7 N54L (where this patch adds
> support to access sensor data from the w83795adg).
> 
> Cc: Thomas Brandon <tbrandonau@gmail.com>
> Cc: Eddi De Pieri <eddi@depieri.net>
> Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
