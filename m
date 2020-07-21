Return-Path: <SRS0=p1Da=BA=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB12C433E0
	for <linux-i2c@archiver.kernel.org>; Tue, 21 Jul 2020 13:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3600E206E9
	for <linux-i2c@archiver.kernel.org>; Tue, 21 Jul 2020 13:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGUNwZ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:52:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgGUNwZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Jul 2020 09:52:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62AA6AD1A;
        Tue, 21 Jul 2020 13:52:31 +0000 (UTC)
Date:   Tue, 21 Jul 2020 15:52:23 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-ID: <20200721155223.6427b611@endymion>
In-Reply-To: <20200718184558.110942-1-refactormyself@gmail.com>
References: <20200718184558.110942-1-refactormyself@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Saheed,

On Sat, 18 Jul 2020 20:45:58 +0200, Saheed Olayemi Bolarinwa wrote:
> This goal of these series is to move the definition of *all* PCIBIOS* from
> include/linux/pci.h to arch/x86 and limit their use within there.
> All other tree specific definition will be left for intact. Maybe they can
> be renamed.
> 
> PCIBIOS* is an x86 concept as defined by the PCI spec. The returned error
> codes of PCIBIOS* are positive values and this introduces some complexities
> which other archs need not incur.
> 
> PLAN:
> 
> 1.   [PATCH v0 1-36] Replace all PCIBIOS_SUCCESSFUL with 0
> (...)

Thanks for the explanations. Now I understand your previous patches
better, and if you fix the alignment issues I'll be happy to approve
them.

> Bolarinwa Olayemi Saheed (35):
>   Change PCIBIOS_SUCCESSFUL to 0
>   Change PCIBIOS_SUCCESSFUL to 0
>   Change PCIBIOS_SUCCESSFUL to 0
> (...)

You'd have to prefix the patch names to make them all unique, but I
think you have done that already as the patches I received looked fine
in this respect.

-- 
Jean Delvare
SUSE L3 Support
