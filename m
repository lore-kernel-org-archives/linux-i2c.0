From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] i2c: designware: Implement support for SMBus block
 read and write
Date: Mon, 31 Oct 2016 14:05:09 +0200
Message-ID: <20161031120509.GO23812@lahna.fi.intel.com>
References: <1477896677-13085-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56098 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936333AbcJaMFP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Oct 2016 08:05:15 -0400
Content-Disposition: inline
In-Reply-To: <1477896677-13085-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tnhuynh@apm.com
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

On Mon, Oct 31, 2016 at 01:51:17PM +0700, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
> 
> Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF protocol.
> However, I2C Designware Core Driver doesn't handle the case at the moment.
> The below patch supports this feature.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>

Looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
