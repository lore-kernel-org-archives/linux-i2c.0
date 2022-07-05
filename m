Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79926C43334
	for <linux-i2c@archiver.kernel.org>; Tue,  5 Jul 2022 10:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiGEK6A (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 5 Jul 2022 06:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiGEK5V (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jul 2022 06:57:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B58915837
        for <linux-i2c@vger.kernel.org>; Tue,  5 Jul 2022 03:56:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D401722504;
        Tue,  5 Jul 2022 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657018605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulkuAMZBSz6PPyOc3IxlopcEQ96ALAXIUBO+V5mbbKQ=;
        b=UKL/vhN69ykHHqqSpqRx5H/YuwGhvUqKIF8a4ADEmiDUdMTOFkdkoj6FK5WALyjv/OOJ0L
        y84usK0Jj8OLLwH1qJUlan7X/TGV1kvU5Q27e4IqJk6anJ4DzjRW7/Ib8IwB6T+I283zwC
        5G1jPbaOCz5P7F+TsLUP8ELPWeVp05Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657018605;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulkuAMZBSz6PPyOc3IxlopcEQ96ALAXIUBO+V5mbbKQ=;
        b=9SYM1ca/gXmuv5EVYX7La9sbTkdJ4hyDOCmHoPRXECP3o4ll7oTigRTcjA4HshZ65sSB9i
        /Eh/3wv0aZMwc4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 997D513A79;
        Tue,  5 Jul 2022 10:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 726+I+0YxGJZHAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 05 Jul 2022 10:56:45 +0000
Date:   Tue, 5 Jul 2022 12:56:43 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] i2c: i801: Add support for Intel Meteor Lake-P
Message-ID: <20220705125643.65f7328d@endymion.delvare>
In-Reply-To: <20220630074154.692578-1-jarkko.nikula@linux.intel.com>
References: <20220630074154.692578-1-jarkko.nikula@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, 30 Jun 2022 10:41:54 +0300, Jarkko Nikula wrote:
> Add SMBus PCI ID on Intel Meteor Lake-P.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> v2. Meteor Lake-P doesn't have a PCH die but integrates the
> functionality into a SoC. Change commit log and patch diff accordingly.
> Thanks to Andy Shevchenko for noticing this in an another patch.
> ---
>  Documentation/i2c/busses/i2c-i801.rst | 1 +
>  drivers/i2c/busses/Kconfig            | 1 +
>  drivers/i2c/busses/i2c-i801.c         | 3 +++
>  3 files changed, 5 insertions(+)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
