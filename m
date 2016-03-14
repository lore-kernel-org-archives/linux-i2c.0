From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v3 05/14] i2c-octeon: Make adapter timeout tunable
Date: Mon, 14 Mar 2016 13:45:05 +0100
Message-ID: <20160314124505.GA5771@hardcore>
References: <cover.1457362545.git.jglauber@cavium.com>
 <00a182c50af211e409f128630ba6ba5359da6198.1457362545.git.jglauber@cavium.com>
 <20160312154611.GH1661@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1bon0057.outbound.protection.outlook.com ([157.56.111.57]:36290
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752512AbcCNMpV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 14 Mar 2016 08:45:21 -0400
Content-Disposition: inline
In-Reply-To: <20160312154611.GH1661@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>

On Sat, Mar 12, 2016 at 04:46:12PM +0100, Wolfram Sang wrote:
> On Mon, Mar 07, 2016 at 04:10:48PM +0100, Jan Glauber wrote:
> > From: Peter Swain <pswain@cavium.com>
> > 
> > Make the i2c adapter timeout a module parameter to allow upper-level
> > target device drivers to retry with their own logic before their own
> > timeouts abort operations.
> > 
> > For example, at24 eeprom driver retries for 25ms when -EAGAIN
> > indicates that an eeprom has gone unresponsive while committing
> > a newly written page (5ms on typical devices).
> > 
> > Signed-off-by: Peter Swain <pswain@cavium.com>
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> i2c-dev has IOCTLs for timeout and retries. Can't you use those?
> 

Yes, with these IOCTLs we don't need to add a module parameter
so I'll drop that.
