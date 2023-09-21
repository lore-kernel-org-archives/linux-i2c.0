Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647FCE7D0AE
	for <linux-i2c@archiver.kernel.org>; Thu, 21 Sep 2023 21:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjIUVqA (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjIUVpk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Sep 2023 17:45:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839CE081;
        Thu, 21 Sep 2023 14:27:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF88FC433C8;
        Thu, 21 Sep 2023 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695331635;
        bh=jVkLh9DPAnAnP1lLTr3OB/S19OdOlVvPRQ+dX6pg1/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOw7/cSXng6klDeb+k67KP+hCxSkoFBDQUgh6X+482MYUPfJKtx/wNumFTmlgbOqc
         +FRRATEnaY6yiCNhiTfaCB3NJKvbTwkG/Quo4c3ySSkwBSeSgxO9ka45AwBaqw91xz
         aMsCNYU3L7xf5ekJdmPZl36GNGK0Y2OW6KS9bisaINknN8/3XjJwkNEv0Z//Uc1R5e
         J1mvMLj1dZnU2AqNakg5dn46XDskpLLZMu/hSP3DGtFSFrn0SHjTFseASCmMLqXsNW
         DpOdCCU/5CGskxSzJf7BBlx3tpeXsCo7YUyK/9zjYyCpwp48MU/AvPuLs5GOP5Hl6z
         aUirGCPfHOyAg==
Date:   Thu, 21 Sep 2023 23:27:09 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] i2c: rcar: improve accuracy for R-Car Gen3+
Message-ID: <20230921212709.kpjt3lyp6i6fjk57@zenone.zhora.eu>
References: <20230921125351.3954-1-wsa+renesas@sang-engineering.com>
 <20230921125351.3954-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921125351.3954-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Sep 21, 2023 at 02:53:50PM +0200, Wolfram Sang wrote:
> With some new registers, SCL can be calculated to be closer to the
> desired rate. Apply the new formula for R-Car Gen3 device types.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I guess you forgot

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

And as well as in the previous review, you can also add

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Thanks,
Andi
