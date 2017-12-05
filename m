From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [wsa:renesas/sdhi-uniphier 2/22]
 drivers/mmc/host/tmio_mmc.h:249:2: error: implicit declaration of function
 'readsw'
Date: Tue, 5 Dec 2017 11:24:39 +0800
Message-ID: <20171205032439.hn7wlhifnf4z47tu@wfg-t540p.sh.intel.com>
References: <201712030902.U17suQaZ%fengguang.wu@intel.com>
 <20171204160024.yv3ztu2ntn2l2l3j@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2149 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdLEDYm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Dec 2017 22:24:42 -0500
Content-Disposition: inline
In-Reply-To: <20171204160024.yv3ztu2ntn2l2l3j@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, Dec 04, 2017 at 05:00:27PM +0100, Wolfram Sang wrote:
>Hey guys,
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi-uniphier
>
>buildbot is a really great and helpful service, so a lot of thanks for
>that.
>
>But please, again, drop the i2c mailing list for my personal development
>branches. *Only* include the i2c list, if there is an "i2c/" prefix in
>the branch name. This branch, for example, is MMC related and has
>nothing to do with I2C! Or, if this is not possible, drop the I2C list
>from all my branches and just mail me and the author.
>
>The current state creates too much noise and it starts to get a little
>annoying. Please let's find some fix for that. buildbot is so useful
>otherwise.

Sorry for the noise! We've added your tree to private reporting,
however it looks the mail_cc option has higher priority. So I'll
just remove the mail_cc. We don't support selectively CC mailing lists
based on branch name, which looks a bit overkill for most people.

Thanks,
Fengguang
