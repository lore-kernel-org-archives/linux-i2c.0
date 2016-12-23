From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v1] i2c: busses: i2c-designware-pcidrv:- Unmap region obtained
 by pcim_iomap_regions
Date: Fri, 23 Dec 2016 12:44:49 +0200
Message-ID: <20161223104449.GV1460@lahna.fi.intel.com>
References: <1482487893-17589-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44893 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762301AbcLWKox (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Dec 2016 05:44:53 -0500
Content-Disposition: inline
In-Reply-To: <1482487893-17589-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jarkko.nikula@linux.intel.com, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 23, 2016 at 03:41:33PM +0530, Arvind Yadav wrote:
> Release IO memory mapping, if i2c_dw_pci_probe is not successful.

Point of pcim_iomap_regions() is that the regions are released
automatically. So there is no need for explicit release.
