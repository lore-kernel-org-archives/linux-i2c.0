Return-Path: <SRS0=ieTw=DA=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE80C4363D
	for <linux-i2c@archiver.kernel.org>; Wed, 23 Sep 2020 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2755221D92
	for <linux-i2c@archiver.kernel.org>; Wed, 23 Sep 2020 14:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIWOQX (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 23 Sep 2020 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWOQX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Sep 2020 10:16:23 -0400
X-Greylist: delayed 172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Sep 2020 07:16:23 PDT
Received: from mail.scram.de (mail0.scram.de [IPv6:2a01:4f8:130:2201::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60681C0613CE
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2020 07:16:23 -0700 (PDT)
Received: from localhost (mail0.scram.de [78.47.204.202])
        by localhost (Postfix) with ESMTP id B8B2057377;
        Wed, 23 Sep 2020 16:13:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at scram.de
Received: from mail.scram.de ([78.47.204.202])
        by localhost (mail.scram.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1OVkS7QmSj1S; Wed, 23 Sep 2020 16:12:49 +0200 (CEST)
Received: (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender)
        by mail.scram.de (Postfix) with ESMTPSA id 8B9C156CC7;
        Wed, 23 Sep 2020 16:12:49 +0200 (CEST)
Subject: Re: [PATCH v2] i2c: cpm: Fix i2c_ram structure
To:     nicolas.vincent@vossloh.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
References: <20200923140840.8700-1-nicolas.vincent@vossloh.com>
From:   Jochen Friedrich <jochen@scram.de>
Message-ID: <b518e49b-87d7-55bb-42f3-619b83f90b6d@scram.de>
Date:   Wed, 23 Sep 2020 16:12:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923140840.8700-1-nicolas.vincent@vossloh.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Acked-by: Jochen Friedrich <jochen@scram.de>

Am 23.09.2020 um 16:08 schrieb nico.vince@gmail.com:
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
>   drivers/i2c/busses/i2c-cpm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index 1213e1932ccb..24d584a1c9a7 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -65,6 +65,9 @@ struct i2c_ram {
>   	char    res1[4];	/* Reserved */
>   	ushort  rpbase;		/* Relocation pointer */
>   	char    res2[2];	/* Reserved */
> +	/* The following elements are only for CPM2 */
> +	char    res3[4];	/* Reserved */
> +	uint    sdmatmp;	/* Internal */
>   };
>   
>   #define I2COM_START	0x80
> 
