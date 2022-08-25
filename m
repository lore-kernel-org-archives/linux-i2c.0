Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCACDC04AA5
	for <linux-i2c@archiver.kernel.org>; Thu, 25 Aug 2022 12:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiHYMuh (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 25 Aug 2022 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbiHYMug (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 25 Aug 2022 08:50:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546EC5247E
        for <linux-i2c@vger.kernel.org>; Thu, 25 Aug 2022 05:50:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0A502077F;
        Thu, 25 Aug 2022 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661431833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcA/zNX9sPWwpscfitXTQjUWSdFZ0kAgwzTPBQGbbwk=;
        b=xAA50yWjwO30bJwvkdpwh02RFE8KHGLwKnmU9oDB+hag06XLXtuNLOBbqNReVMB+/UYqJw
        gJKRgeRBpw3x5RZkSHtbjT0fNH9SaeMuqa/ShD939R9rzn1pAKR8s+QZ1Q54VR2uYvWOPj
        mEjgp4wIakVcgfCraCrHH72J6kpSGNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661431833;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcA/zNX9sPWwpscfitXTQjUWSdFZ0kAgwzTPBQGbbwk=;
        b=/B/pjUt+MZIQNUzw0pghglHJfc4JNWZWbJO/4jfaUyEfyN62r6cl1rTqXZYMJ+x6eqiaux
        WqYUf2uu1RFJTwDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8154C13A8E;
        Thu, 25 Aug 2022 12:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id os3oHRlwB2N1IAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 25 Aug 2022 12:50:33 +0000
Date:   Thu, 25 Aug 2022 14:50:32 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Bruce Duncan <bwduncan@gmail.com>, linux-i2c@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] Fix typo, add markup, fix URL in i2c-piix4 docs
Message-ID: <20220825145032.7ab0b3ab@endymion.delvare>
In-Reply-To: <Yd3mypbrlKk/nc0e@ninjato>
References: <20211215113356.62982-1-bwduncan@gmail.com>
        <Yd3mypbrlKk/nc0e@ninjato>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, 11 Jan 2022 21:21:30 +0100, Wolfram Sang wrote:
> >  For additional information, read:
> > -http://www.lm-sensors.org/browser/lm-sensors/trunk/README
> > +https://hwmon.wiki.kernel.org  
> 
> I think the proper replacement is:
> 
> https://github.com/lm-sensors/lm-sensors/blob/master/README
> 
> ?

Yes, but I'd rather remove the pointer completely than update it.
There's nothing specific to the i2c-piix4 driver in that file, so I
can't see any value in mentioning it here.

As Bruce appears to have vanished meanwhile, I'll post an updated
version of the patch shortly myself, including another typo fix.

-- 
Jean Delvare
SUSE L3 Support
