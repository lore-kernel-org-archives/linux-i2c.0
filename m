From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Drop needless bit-wise OR
Date: Thu, 26 May 2016 11:36:57 +0300
Message-ID: <20160526083657.GT1789@lahna.fi.intel.com>
References: <20160525093702.64d7309c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11363 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbcEZIhD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 26 May 2016 04:37:03 -0400
Content-Disposition: inline
In-Reply-To: <20160525093702.64d7309c@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On Wed, May 25, 2016 at 09:37:02AM +0200, Jean Delvare wrote:
> The interrupt handling code makes it look like several status values
> may be merged together before being processed, while this will never
> happen. Change from bit-wise OR to simple assignment to make it more
> obvious and avoid misunderstanding.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
