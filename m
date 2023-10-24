Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECD7C07545
	for <linux-i2c@archiver.kernel.org>; Tue, 24 Oct 2023 17:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJXRdp (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 24 Oct 2023 13:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343780AbjJXRdo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Oct 2023 13:33:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6541B3
        for <linux-i2c@vger.kernel.org>; Tue, 24 Oct 2023 10:33:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FCAC433C7;
        Tue, 24 Oct 2023 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698168822;
        bh=cRNvW+OGH4FZW5C10ppvR2jaVa3oMkeSWjybFPNXAIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXMNYUnAZaFjGuDJ2uNnMycMphCRDmkHACSKrVTdKnE9FhJezZCfvsTDA+sRXmNbW
         6J6j8sYtnLm+hR5wEYzDimuDBk6yu29G8iiO8T7Y6ixa3pkgKoOSlyzOwbD6xrrIFW
         tNghN/GJkGOlGTo8u95dy1XPyg4iCreQbeQd/RuK8LnQn9ChowR7Oz5GcLWBzaYB7Z
         wPfi4/vfJr7Ota/3YfvCC1jGHiKEvJTtFSxf0iBTK6iK3mSHbLSCxHRMyQsbBLLPED
         BrkRQ6NdW5CmgbCjLoMsFkYF8BKmtUp74ZjIVS5nrRhJ8JgSSJwpf7GGgzjMZ4s4B1
         nJimsps1YC7DA==
Date:   Tue, 24 Oct 2023 19:33:38 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH 1/2] ACPI: Add helper acpi_use_parent_companion
Message-ID: <20231024173338.haei2py7izlqxjmw@zenone.zhora.eu>
References: <90bd1071-317e-4dfe-b94b-9bcee15d66c5@gmail.com>
 <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Heiner,

On Sun, Oct 15, 2023 at 11:34:25PM +0200, Heiner Kallweit wrote:
> In several drivers devices use the ACPI companion of the parent.
> Add a helper for this use case to avoid code duplication.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Wolfram, can we take this in i2c? Otherwise this will take two
release rounds to get in.

Andi
