From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v6 03/19] i2c: octeon: Rename [read|write]_sw to
 reg_[read|write]
Date: Thu, 14 Apr 2016 09:58:47 +0200
Message-ID: <20160414075847.GA2532@hardcore>
References: <cover.1460387640.git.jglauber@cavium.com>
 <be18c6fc7331af1b383419819a5a947f35dd6d00.1460387640.git.jglauber@cavium.com>
 <20160413084409.GD1563@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1bbn0100.outbound.protection.outlook.com ([157.56.111.100]:62202
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752357AbcDNH7E (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Apr 2016 03:59:04 -0400
Content-Disposition: inline
In-Reply-To: <20160413084409.GD1563@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Wed, Apr 13, 2016 at 10:44:09AM +0200, Wolfram Sang wrote:
> On Mon, Apr 11, 2016 at 05:28:34PM +0200, Jan Glauber wrote:
> > octeon_i2c_read_sw -> octeon_i2c_reg_read
> > octeon_i2c_write_sw -> octeon_i2c_reg_write
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> Please add the motivation of the change (the reason). No need to resend
> the whole patch. Just reply with the updated commit message and I'll fix
> up locally.
> 

Sorry, forgot to expand the initial description a bit.

Update:
---
i2c: octeon: Rename [read|write]_sw to reg_[read|write]

Rename the [read|write]_sw functions to make it clearer they access
the TWSI registers.
---

Thanks, Jan
