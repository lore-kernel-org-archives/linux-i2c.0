Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77BEC12002
	for <linux-i2c@archiver.kernel.org>; Wed, 21 Jul 2021 09:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B335561175
	for <linux-i2c@archiver.kernel.org>; Wed, 21 Jul 2021 09:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbhGUIUY (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:20:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49890 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhGUIOs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Jul 2021 04:14:48 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 46C051FE7D;
        Wed, 21 Jul 2021 08:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626857724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7hwZJXBpTSNB+8cL01HoLens7IZWVX/bluLtOUr2UM=;
        b=bjVjaa2zOvmEVm/Icn081H8Z7suyHG7pgnaiNkvhegAZBThyR0S27DclrHuN8nlh4+KIEE
        aEbQ4rqEg84qWPVjiaHnwoOFoXhcqTouOsHEXYFBYfWlqEE+rhJaxos837BIRQsJVAgohG
        dn9S+P6PZwDRQ0kCbpj7EUgXv7dOc20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626857724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7hwZJXBpTSNB+8cL01HoLens7IZWVX/bluLtOUr2UM=;
        b=RMCWetIu0NJ4JrS6z2aGI63Hw7T6n8nO4bSz5UKBZrY1hTZfSYagsWlvA6fejQeXDAIQyQ
        kulqeCEFS6gx94AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 04C6F13BC9;
        Wed, 21 Jul 2021 08:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id lfZqOfvg92D6LQAAGKfGzw
        (envelope-from <jdelvare@suse.de>); Wed, 21 Jul 2021 08:55:23 +0000
Date:   Wed, 21 Jul 2021 10:55:22 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: i801: Fix handling SMBHSTCNT_PEC_EN
Message-ID: <20210721105522.626cc13b@endymion>
In-Reply-To: <634382bd-b7b7-3a77-757c-b44fc070c7e8@gmail.com>
References: <15db81d0-ddbd-b590-3996-51e588c5b10a@gmail.com>
        <634382bd-b7b7-3a77-757c-b44fc070c7e8@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Sun, 18 Jul 2021 15:51:22 +0200, Heiner Kallweit wrote:
> Jean, do you have an opinion on this patch? It's been pending for quite some
> time and I have few more patches that I'd like to submit.

Sorry for the delay, I'll look into it today.

-- 
Jean Delvare
SUSE L3 Support
