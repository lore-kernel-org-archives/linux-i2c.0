Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BAEC433EF
	for <linux-i2c@archiver.kernel.org>; Tue, 15 Feb 2022 10:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiBOKCN (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:02:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiBOKB7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Feb 2022 05:01:59 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E517F1111A4;
        Tue, 15 Feb 2022 02:01:30 -0800 (PST)
Received: from [192.168.12.102] (unknown [159.196.94.94])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3F7292015A;
        Tue, 15 Feb 2022 18:01:26 +0800 (AWST)
Message-ID: <e891478fbb4c3a5a5b44d13c5ce3557a884d10f5.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v5 2/2] mctp i2c: MCTP I2C binding driver
From:   Matt Johnston <matt@codeconstruct.com.au>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>
Date:   Tue, 15 Feb 2022 18:01:25 +0800
In-Reply-To: <20220214210410.2d49e55f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220210063651.798007-1-matt@codeconstruct.com.au>
         <20220210063651.798007-3-matt@codeconstruct.com.au>
         <20220211143815.55fb29e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <b857c3087443f86746d81c1d686eaf5044db98a7.camel@codeconstruct.com.au>
         <20220214210410.2d49e55f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, 2022-02-14 at 21:04 -0800, Jakub Kicinski wrote:
> > 
> > One question, the tx thread calls netif_wake_queue() - is it safe to call
> > that after unregister_netdev()? (before free_netdev)
> 
> I don't think so.
> 
> > I've moved the kthread_stop() to the post-unregister cleanup.
> 
> The usual way to deal with Tx would be to quiesce the worker in
> ndo_stop. Maybe keep it simple and add a mutex around the worker?
> You can then take the same mutex around:

Thanks. I'll just make sure to kthread_stop() prior to calling unregister. It
looks like the kthread needs to keep running when the interface is down to
handle MCTP release timeouts which unlock the i2c bus, so can't use ndo_stop.

Similarly for the RX path, can I safely call netif_rx(skb) after unregister?
It looks like in that case it should be OK, since enqueue_to_backlog() tests
for netif_running() and just drops the packet. (It's running from the I2C
slave irq so can't just use a mutex).

Thanks,
Matt

