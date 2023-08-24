Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F767C6FA8F
	for <linux-i2c@archiver.kernel.org>; Thu, 24 Aug 2023 16:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbjHXQLR (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 24 Aug 2023 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242475AbjHXQLK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Aug 2023 12:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446041995;
        Thu, 24 Aug 2023 09:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8CB864542;
        Thu, 24 Aug 2023 16:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1453EC433C7;
        Thu, 24 Aug 2023 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692893468;
        bh=tZDgZ4F2s45swKCSwkXA7XjLqukt6/fIKBodiXl4Vu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huZej8CxQo/Q64nMHPiNi/0UkHmbHd2Jss/51fVdPPMJpOGLjyke62WGpMydGA8B8
         TCwX0mzkqqXeWXqyLNMJGUNjJlgQOZtIi9OGDFHH9LWIh1jc11AcKzUr9VSpBu/g+n
         essoU7utuuqkbFsnkgi17Q3vmu5LQE8GOo90kpFFRFMsWomLeZ//EF9WvP5L9X0e5U
         jw7qi1iclij4UzY/lgm7bzTYc62V7fVy8yAtnRh05OIUM6MNSs6G0y744SppVxWTD6
         wQPXXZ7ux+yvH8vSArujsLlv1oWZZRTmAaJkc7rzcAvctmfG78QE2l15M09zbMAFJz
         7L3i8Ocou9Zhg==
Date:   Thu, 24 Aug 2023 18:11:02 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dmitry.baryshkov@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Liao Chang <liaochang1@huawei.com>,
        Todor Tomov <todor.too@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com
Subject: Re: [PATCH next] i2c: qcom-cci: Fix error checking in cci_probe()
Message-ID: <20230824161102.vdzs25lqcmadlnkr@intel.intel>
References: <20230823194202.2280957-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823194202.2280957-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Harshit,

On Wed, Aug 23, 2023 at 12:42:02PM -0700, Harshit Mogalapalli wrote:
> devm_clk_bulk_get_all() can return zero when no clocks are obtained.
> Passing zero to dev_err_probe() is a success which is incorrect.
> 
> Fixes: 605efbf43813 ("i2c: qcom-cci: Use dev_err_probe in probe function")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
