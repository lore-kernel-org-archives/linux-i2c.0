Return-Path: <SRS0=TNcc=CJ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDACC433E2
	for <linux-i2c@archiver.kernel.org>; Mon, 31 Aug 2020 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8A520767
	for <linux-i2c@archiver.kernel.org>; Mon, 31 Aug 2020 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaOdy (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:33:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:48542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgHaOdw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Aug 2020 10:33:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCFB0ADDB;
        Mon, 31 Aug 2020 14:33:50 +0000 (UTC)
Date:   Mon, 31 Aug 2020 16:33:50 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Volker =?UTF-8?B?UsO8bWVsaW4=?= <vr_qemu@t-online.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Subject: Re: [PATCH] i2c: i801: Fix resume bug
Message-ID: <20200831163350.0359f964@endymion>
In-Reply-To: <20200828164036.GA2158745@bjorn-Precision-5520>
References: <20200828085753.GH1343@ninjato>
        <20200828164036.GA2158745@bjorn-Precision-5520>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Bjorn, Wolfram,

On Fri, 28 Aug 2020 11:40:36 -0500, Bjorn Helgaas wrote:
> On Fri, Aug 28, 2020 at 10:57:53AM +0200, Wolfram Sang wrote:
> > On Tue, Aug 25, 2020 at 07:13:03PM +0200, Jean Delvare wrote:  
> > > +static unsigned char i801_setup_hstcfg(unsigned char hstcfg)
> > > +{
> > > +	hstcfg &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
> > > +	hstcfg |= SMBHSTCFG_HST_EN;
> > > +	return hstcfg;
> > > +}  
> > 
> > What about putting the write to SMBHSTCFG here, too. When I read the
> > function name, I assumed it will do that.  
> 
> From the point of view of suspend/resume, I think it's nice to have a
> write in i801_resume() to match the one in i801_suspend().

I agree that symmetry is nice in general, but I must agree with
Wolfram, a function named "setup" which doesn't actually perform any
action is kind of confusing. I believe that moving the write in there
makes sense as both callers will do exactly that immediately after.

> Putting the write inside i801_setup_hstcfg() would mean i801_probe()
> would do *two* writes instead of the one it currently does.

I can't see why that would be the case.

-- 
Jean Delvare
SUSE L3 Support
