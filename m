From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v6 04/19] i2c: octeon: Introduce helper functions for
 register access
Date: Thu, 14 Apr 2016 10:05:11 +0200
Message-ID: <20160414080511.GB2532@hardcore>
References: <cover.1460387640.git.jglauber@cavium.com>
 <5667768441feb526fbf1c3cd8768827393f9bfce.1460387640.git.jglauber@cavium.com>
 <20160413084521.GE1563@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0086.outbound.protection.outlook.com ([65.55.169.86]:23872
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753086AbcDNIF2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Apr 2016 04:05:28 -0400
Content-Disposition: inline
In-Reply-To: <20160413084521.GE1563@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Wed, Apr 13, 2016 at 10:45:21AM +0200, Wolfram Sang wrote:
> On Mon, Apr 11, 2016 at 05:28:35PM +0200, Jan Glauber wrote:
> > Add helper functions for control, data and status register access.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> Same as patch 3.
> 

Updated commit message:

i2c: octeon: Introduce helper functions for register access

Add helper functions for control, data and status register access.
This simplifies the code and makes the purpose of the register
access clearer.
