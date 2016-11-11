From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4] i2c: designware: Implement support for SMBus block
 read and write
Date: Fri, 11 Nov 2016 13:03:10 +0200
Message-ID: <20161111110310.GU1470@lahna.fi.intel.com>
References: <1478746593-10905-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37548 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755819AbcKKLDU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 11 Nov 2016 06:03:20 -0500
Content-Disposition: inline
In-Reply-To: <1478746593-10905-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tnhuynh@apm.com
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

On Thu, Nov 10, 2016 at 09:56:33AM +0700, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
> 
> Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF protocol.
> However, I2C Designware Core Driver doesn't handle the case at the moment.
> The below patch supports this feature.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
