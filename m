Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2397C432BE
	for <linux-i2c@archiver.kernel.org>; Thu, 26 Aug 2021 14:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61BE60F25
	for <linux-i2c@archiver.kernel.org>; Thu, 26 Aug 2021 14:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbhHZOUj (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:20:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40608 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242856AbhHZOUj (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 26 Aug 2021 10:20:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B01C22312;
        Thu, 26 Aug 2021 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629987591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NFhH/3RmXkQH2uJW8qkNP4x5SeWqO4M4FoWpc+u6Mc=;
        b=Aboa21zKlP1B8+VdIdCCn9bWB9sqdOhR9KSBQFvGgVMECiioDALS17WdcDtlKbq7jBqq7e
        duNJbvs/We2wbRdtmji597ohWbnIfnLiH0Mdc+bcfgX1uBlAbKqNGWCBVSc6Vd++8a3NQL
        RBHmlZJeESINzNJRB7txNTyFE/vsnqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629987591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NFhH/3RmXkQH2uJW8qkNP4x5SeWqO4M4FoWpc+u6Mc=;
        b=zLM/PRJXWRWJBnCFawRBowfIcj8bibOSsQRU6dx0LW1Ef5HMyuWFEpvbHbVamzN4MoKIp4
        47J/GI662QQ2N+Cg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E56471365D;
        Thu, 26 Aug 2021 14:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HDLLNAajJ2F4XgAAGKfGzw
        (envelope-from <jdelvare@suse.de>); Thu, 26 Aug 2021 14:19:50 +0000
Date:   Thu, 26 Aug 2021 16:19:49 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 4/9] i2c: i801: Improve is_dell_system_with_lis3lv02d
Message-ID: <20210826161949.3fd7796b@endymion>
In-Reply-To: <YRTwCMgqmZmlExZk@smile.fi.intel.com>
References: <e46ac7c1-1bb0-2caf-58e6-2fcaa89d30ae@gmail.com>
        <effeb0c0-36cb-afc4-4d9a-7ef348c928ae@gmail.com>
        <YRPwsvJ7T+NcPepu@smile.fi.intel.com>
        <8d6e7c48-839a-44d7-3e4d-643dc79e20c5@gmail.com>
        <YRTwCMgqmZmlExZk@smile.fi.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, 12 Aug 2021 12:55:20 +0300, Andy Shevchenko wrote:
> On Wed, Aug 11, 2021 at 10:28:25PM +0200, Heiner Kallweit wrote:
> > On 11.08.2021 17:45, Andy Shevchenko wrote:  
> > > On Fri, Aug 06, 2021 at 11:15:15PM +0200, Heiner Kallweit wrote:  
> > >> Replace the ugly cast of the return_value pointer with proper usage.
> > >> In addition use dmi_match() instead of open-coding it.  
> > > 
> > > ...
> > >   
> > >> -	acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL,
> > >> -			 (void **)&found);
> > >> +	acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL, &err);
> > >>  
> > >> -	return found;
> > >> +	return !IS_ERR(err);  
> > > 
> > > Shouldn't you also check the status of acpi_get_device()?
> >
> > This shouldn't be needed because err isn't touched if function fails.  
> 
> For the sake of clearness of the code I would do it.

This brings us back to how awkward the API is. Most callers don't
bother checking the return value of acpi_get_devices() because it's
useless in practice. But I agree that in theory it could return with an
error and then it would be nicer to catch that.

> (...) But in any case what
> really hurt my eye is the last line here. To me sounds like
> 
> 	if (IS_ERR(err))
> 		return false;
> 	return true;
> 
> is much better to read (and I bet the compiler will generate the very same
> code for it).

Somehow the assembly code differs, but I'm unable to see the relation
between your proposed change and the assembly code changes. That's why
I hate modern compilers. They pretend to be smart, but what they are
essentially is unstable, and this ruins any attempt at such trivial
comparisons. Sad.

Personally I don't really care, Heiner's code did not strike me as
being hard to read in the first place. I tend to avoid conditionals
when possible.

-- 
Jean Delvare
SUSE L3 Support
