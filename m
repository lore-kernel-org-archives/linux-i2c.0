From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] I2C Designware Core Supports SMBUS BLOCK
Date: Wed, 26 Oct 2016 11:16:00 +0300
Message-ID: <20161026081600.GM1476@lahna.fi.intel.com>
References: <1477370113-15145-1-git-send-email-tnhuynh@apm.com>
 <20161025115025.GI1476@lahna.fi.intel.com>
 <CANQ9TuB5BbR40TEndGqQ6ABDSUsCOGjEhXSvmD78jtuqGRpXvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50844 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752254AbcJZIU1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Oct 2016 04:20:27 -0400
Content-Disposition: inline
In-Reply-To: <CANQ9TuB5BbR40TEndGqQ6ABDSUsCOGjEhXSvmD78jtuqGRpXvg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches <patches@apm.com>

On Wed, Oct 26, 2016 at 02:26:05PM +0700, Tin Huynh wrote:
>    But can you explain more about 'but even that starts to require small
>    helper function'?

So you could add a small function i2c_dw_xfer_need_stop() that returns
true if you need to set the stop bit.
