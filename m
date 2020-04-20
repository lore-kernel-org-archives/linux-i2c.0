Return-Path: <SRS0=qnzP=6E=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D513C3815B
	for <linux-i2c@archiver.kernel.org>; Mon, 20 Apr 2020 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B7C2082E
	for <linux-i2c@archiver.kernel.org>; Mon, 20 Apr 2020 16:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDTQ07 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:26:59 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:45982 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDTQ07 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 20 Apr 2020 12:26:59 -0400
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=[192.168.0.10])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1jQZG5-0007Pr-Uq; Mon, 20 Apr 2020 17:26:58 +0100
Subject: Re: [PATCH] i2c-amd756: share definition of amd756_smbus
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@lists.codethink.co.uk, linux-i2c@vger.kernel.org
References: <20191220105954.382490-1-ben.dooks@codethink.co.uk>
 <20200415125859.5d6297b2@endymion>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <2c6246c3-5d89-05f1-36c2-6515789d5dcd@codethink.co.uk>
Date:   Mon, 20 Apr 2020 17:26:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415125859.5d6297b2@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 15/04/2020 11:58, Jean Delvare wrote:
> Hi Ben,
> 
> On Fri, 20 Dec 2019 10:59:54 +0000, Ben Dooks (Codethink) wrote:
>> Add a shared header to declare amd756_smbus that is used
>> by two files, to remove the following sparse warning:
>>
>> drivers/i2c/busses/i2c-amd756.c:286:20: warning: symbol 'amd756_smbus' was not declared. Should it be static?
> 
> I can't see this warning, not even with W=1. What did you do to see it?

Was running C=1, looks like output from sparse.

