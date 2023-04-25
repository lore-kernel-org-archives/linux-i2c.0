Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F23C77B61
	for <linux-i2c@archiver.kernel.org>; Tue, 25 Apr 2023 12:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjDYMuz (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 25 Apr 2023 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjDYMuy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Apr 2023 08:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D5BB8D
        for <linux-i2c@vger.kernel.org>; Tue, 25 Apr 2023 05:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D1D6185D
        for <linux-i2c@vger.kernel.org>; Tue, 25 Apr 2023 12:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C7DC433EF;
        Tue, 25 Apr 2023 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682427052;
        bh=S8/7gJ2pfajbO/q/jWlJHSrD64UYXyjQzThpXd4esMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6FGNrdlJJrSuD+abguU9hmzGiPeCklwNvvTxywW3EZxpymozT1F4szFG6+Kn8Oju
         lck1GBZxdkg3KLA8zg5Qe5jjyp27MvEgKAf43CxCQKaTrSSNtAsEa/bomjWONBJqnc
         G0AtfhCz6MG5n5mpOPvQaSXGQkVlw6AOUMTC+IwvXxK8Lm1TcEnpWC8WDr63WQKLUN
         4YGn6upY8vmFyCpOaojGpwvS0ppC/e1e/sn00PDwOcfKmpljxrAr7tS9ziqA0aw58e
         PX2AiJHrHsVJgG02jFu5rO2EdHZI6ucW8crtkUYO54e8XYliASKH6vNq3FAj0PmM1m
         FjMOmi3wkYTaQ==
Date:   Tue, 25 Apr 2023 14:50:48 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v2 2/2] i2c: i801: Add support for Intel Meteor Lake PCH-S
Message-ID: <20230425125048.4rvaw6rjs24gpdoc@intel.intel>
References: <20230424105757.732150-1-jarkko.nikula@linux.intel.com>
 <20230424105757.732150-2-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424105757.732150-2-jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Jarkko,

On Mon, Apr 24, 2023 at 01:57:57PM +0300, Jarkko Nikula wrote:
> Add SMBus PCI ID on Intel Meteor Lake PCH-S. Also called as Meteor
> Point-S which is used in the code to distinguish from Meteor Lake-S SoC
> but call both as Meteor Lake in documentation and Kconfig.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
