Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E13C0015E
	for <linux-i2c@archiver.kernel.org>; Mon,  3 Jul 2023 08:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGCIih (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 3 Jul 2023 04:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGCIig (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Jul 2023 04:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF797B6;
        Mon,  3 Jul 2023 01:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DA9060E76;
        Mon,  3 Jul 2023 08:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1266BC433C7;
        Mon,  3 Jul 2023 08:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688373514;
        bh=mfQb+DW2VrDZqRE0Km5SJaxQ6Sjgk4SrBlpqdl7/biw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beDxIaJ+h2DknpSK6Q+RurzNUcXVv9Y8flyu8inV0wPO/2p0lAZJTStnrQpUdGufV
         3Vhaffgui5eF+aEzG21jDN9hiQ8yv4PybrHN5EWA2g8wVN4oTrLB4YzG4ZnNwSwUsn
         KeXC+DxOkIdrvOzweffkcz6fv1oFEZbZtdYn9mcV+giS5a1UPZLmoicfVpPq47dzl0
         oFcnzQdbpj589jwXgYhMMqJsuEueaPOmhu+8jL4jL8OTWDD4umZzNJi2Ju5/A9nIkt
         cEv50LiXqNPATS4uNVHQxuCw9PGzS5OHcNrcbt9PE545ECKxydD7TZsvFobCddt5XM
         IQy4E2NFHD2mQ==
Date:   Mon, 3 Jul 2023 10:38:28 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     wsa@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2] i2c: busses: i2c-nomadik: Remove a useless call in
 the remove function
Message-ID: <20230703083828.jfylmlylszf2lwpy@intel.intel>
References: <62ae6810d41e0429ebaadfac8a95409f4bc72456.1688160163.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ae6810d41e0429ebaadfac8a95409f4bc72456.1688160163.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Christophe,

On Fri, Jun 30, 2023 at 11:23:28PM +0200, Christophe JAILLET wrote:
> Since commit a410963ba4c0 ("Merge branch 'i2c-embedded/for-next' of
> git://git.pengutronix.de/git/wsa/linux"), there is no more
> request_mem_region() call in this driver.
> 
> So remove the release_mem_region() call from the remove function which is
> likely a left over.
> 
> There is no details in the above commit log, but at its end we can read:
>    Conflicts:
> 	   drivers/i2c/busses/i2c-nomadik.c
> 
> This may explain why this call has been left here.
> 
> Fixes: a410963ba4c0 ("Merge branch 'i2c-embedded/for-next' of git://git.pengutronix.de/git/wsa/linux
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
