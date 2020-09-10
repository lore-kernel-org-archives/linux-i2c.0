Return-Path: <SRS0=08/0=CT=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B62C433E2
	for <linux-i2c@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9CF20C09
	for <linux-i2c@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgIJJcW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:32:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:52476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730526AbgIJJcD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Sep 2020 05:32:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B968EAEC3;
        Thu, 10 Sep 2020 09:32:17 +0000 (UTC)
Date:   Thu, 10 Sep 2020 11:32:01 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Volker =?UTF-8?B?UsO8bWVsaW4=?= <volker.ruemelin@googlemail.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Subject: Re: [PATCH v2 1/2] i2c: i801: Fix resume bug
Message-ID: <20200910113201.54f4db6f@endymion>
In-Reply-To: <20200910070913.GI1031@ninjato>
References: <20200901152221.3cea0048@endymion>
        <19d445a6-0410-78a0-77aa-4297e864d064@googlemail.com>
        <20200910070913.GI1031@ninjato>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, 10 Sep 2020 09:09:13 +0200, Wolfram Sang wrote:
> On Sun, Sep 06, 2020 at 10:00:50AM +0200, Volker Rümelin wrote:
> > with these two patches the code in i2c-i801.c looks really good.
> > 
> > But there is an issue with the reproducer.  
> 
> I am not familiar with the HW; do we want these two patches here or does
> the issue below need to be solved first? And if we want them, is it
> still stable material?

The new issue pointed out by Volker is independent from the bug being
fixed here. We do want these 2 patches applied now, with the 1st one
being stable material. The second patch is only a clean-up so it
doesn't need to go to stable.

This new issue exists since April 2018. I'm surprised it wasn't
reported as a regression earlier. Maybe newer BIOSes are getting better
at not making assumptions about register states at suspend time (let me
dream!) Anyway, it deserves its own fix, which also qualifies for
stable in my opinion.

-- 
Jean Delvare
SUSE L3 Support
