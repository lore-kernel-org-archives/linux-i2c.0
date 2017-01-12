From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
Date: Thu, 12 Jan 2017 20:22:09 +0100
Message-ID: <20170112192209.qih7zm4x6k3rzt4i@ninjato>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
 <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:37900 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbdALTWM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 14:22:12 -0500
Content-Disposition: inline
In-Reply-To: <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soren.brinkmann@xilinx.com, michal.simek@xilinx.com


> Because the adapter registration i2c_add_adapter() can fail, information
> about the adapter initialization would be expected only in case of
> successful registration.

Exactly.

> 
> The information sent to the kernel log buffer here is quite trivial,
> probably dev_info() can be just removed, but in any case it should be
> a separate change.

I am not sure I get you here, but to not have false positive success
messages, I'd think that should be all in one patch.

Regards,

   Wolfram
