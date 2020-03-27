From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] igb: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 19:31:40 -0700 (PDT)
Message-ID: <20200326.193140.518355155914627267.davem@davemloft.net>
References: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
        <20200326211001.13171-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:57528 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgC0Cbm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 26 Mar 2020 22:31:42 -0400
In-Reply-To: <20200326211001.13171-2-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org, jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Thu, 26 Mar 2020 22:09:59 +0100

> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied.
