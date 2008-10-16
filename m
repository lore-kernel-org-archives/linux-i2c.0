From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/7] powerpc and sparc: introduce dev_archdata node
 accessors
Date: Thu, 16 Oct 2008 15:36:41 -0700 (PDT)
Message-ID: <20081016.153641.32547403.davem@davemloft.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171251.GA5515@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758126AbYJPWhm@vger.kernel.org>
In-Reply-To: <20081016171251.GA5515@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net, sfalco@harris.com, grant.likely@secretlab.ca, khali@linux-fr.org, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 16 Oct 2008 21:12:51 +0400

> The name of the device_node field differ across the platforms, so we
> have to implement inlined accessors. This is needed to avoid ugly
> #ifdef in the generic code.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

I'm happy to just change this member name on sparc to match
powerpc's choice.

That being said, this abstraction still has value and I'd
like to let you merge this now and make forward progress
so:

Acked-by: David S. Miller <davem@davemloft.net>
