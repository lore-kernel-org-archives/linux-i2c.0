From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] i2c-piix4: Always use the same type for port
Date: Fri, 29 Jan 2016 12:59:56 +0200
Message-ID: <20160129105956.GK1778@lahna.fi.intel.com>
References: <20160129104146.50f06562@endymion.delvare>
 <20160129104530.1ba78e8b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7966 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbcA2LAA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 06:00:00 -0500
Content-Disposition: inline
In-Reply-To: <20160129104530.1ba78e8b@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

On Fri, Jan 29, 2016 at 10:45:30AM +0100, Jean Delvare wrote:
> Sometimes u8 is used to store the port number, sometimes unsigned
> short is used. Consistently stick to a single type, for consistency
> and to avoid implicit casts.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
