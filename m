Return-Path: <SRS0=cqaj=C7=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C681DC2D0E2
	for <linux-i2c@archiver.kernel.org>; Tue, 22 Sep 2020 12:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B92B2399A
	for <linux-i2c@archiver.kernel.org>; Tue, 22 Sep 2020 12:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIVMxt (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:53:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43886 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgIVMxs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 22 Sep 2020 08:53:48 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 08:53:47 EDT
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BwgpW6sQSz9tyM7;
        Tue, 22 Sep 2020 14:38:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id u8oFUFlt6mEH; Tue, 22 Sep 2020 14:38:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BwgpW5JRdz9tyM3;
        Tue, 22 Sep 2020 14:38:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 06D768B7DA;
        Tue, 22 Sep 2020 14:38:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id attwvv_zySey; Tue, 22 Sep 2020 14:38:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 61D4A8B7D8;
        Tue, 22 Sep 2020 14:38:44 +0200 (CEST)
Subject: Re: [PATCH] i2c: cpm: Fix i2c_ram structure
To:     nicolas.vincent@vossloh.com, jochen@scram.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
References: <20200922090400.6282-1-nicolas.vincent@vossloh.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <956c4b63-f859-df0c-2836-80a988ee6aa9@csgroup.eu>
Date:   Tue, 22 Sep 2020 14:38:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922090400.6282-1-nicolas.vincent@vossloh.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org



Le 22/09/2020 à 11:04, nico.vince@gmail.com a écrit :
> From: Nicolas VINCENT <nicolas.vincent@vossloh.com>
> 
> the i2c_ram structure is missing the sdmatmp field mentionned in
> datasheet for MPC8272 at paragraph 36.5. With this field missing, the
> hardware would write past the allocated memory done through
> cpm_muram_alloc for the i2c_ram structure and land in memory allocated
> for the buffers descriptors corrupting the cbd_bufaddr field. Since this
> field is only set during setup(), the first i2c transaction would work
> and the following would send data read from an arbitrary memory
> location.
> 
> Signed-off-by: Nicolas VINCENT <nicolas.vincent@vossloh.com>
> ---
>   drivers/i2c/busses/i2c-cpm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index 1213e1932ccb..c5700addbf65 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -64,7 +64,8 @@ struct i2c_ram {
>   	uint    txtmp;		/* Internal */
>   	char    res1[4];	/* Reserved */
>   	ushort  rpbase;		/* Relocation pointer */
> -	char    res2[2];	/* Reserved */
> +	char    res2[6];	/* Reserved */
> +	uint    sdmatmp;	/* Internal */

On CPM1, I2C param RAM has size 0x30 (offset 0x1c80-0x1caf)

Your change overlaps the miscellaneous area that contains CP Microcode 
Revision Number, ref MPC885 Reference Manual §18.7.3

>   };
>   
>   #define I2COM_START	0x80
> 


Christophe
