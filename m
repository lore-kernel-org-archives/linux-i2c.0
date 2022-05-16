Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1C5C433FE
	for <linux-i2c@archiver.kernel.org>; Mon, 16 May 2022 06:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiEPGnn (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 16 May 2022 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiEPGnm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 16 May 2022 02:43:42 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CF335876;
        Sun, 15 May 2022 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1652683421;
  x=1684219421;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=UBLXuJ3x/eQp0h7RffFZ6La9xjLghucU1bkO5zIfwR8=;
  b=E6wWDmE0XsYIeyYopAjQls833PBad5MWIL0I+04i7EG41kmbR7/sfSKR
   7WCEagOqsbmvTVRsyzZABhDgYZRLAUXTVtmOspOkNPKHm14sANr1DoQsX
   fvAIR/J5c/N8vGt5sUIWkx2qBA7XPRCo/qvmMldK32n+fwHmY28jbzWL9
   gdeG17Txb9xPYGyCJrTVb1zPBLc22fj2ejojJsEibsQr54j25ZKcQrD2F
   B1i2EjUJcBUOhoindOh3bIywmz2KaKJieH0A3/3RplcvDxa8DkpIwemaI
   nNZVgGhmH1K9Et+Cciu0mKJRSw5qC0sNFSUmWEcRYEaeMKYsO+U620xJV
   Q==;
Date:   Mon, 16 May 2022 08:43:38 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Wolfram Sang <wsa@kernel.org>, <kernel@axis.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <krzk+dt@kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: add property to avoid device
 detection
Message-ID: <20220516064338.GA28916@axis.com>
References: <20220412085046.1110127-1-vincent.whitchurch@axis.com>
 <20220412085046.1110127-2-vincent.whitchurch@axis.com>
 <Yn+8CJ3j2SY2+Mq+@shikoro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yn+8CJ3j2SY2+Mq+@shikoro>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Sat, May 14, 2022 at 04:26:16PM +0200, Wolfram Sang wrote:
> That aside, I am not sure we should handle this at DT level. Maybe we
> should better change the GPIO driver to not populate a class if we have
> a firmware node?

Is it always safe to not do this detection if we have a firmware node?
Then maybe the core could just always skip it in that case without
looking for a special property or requiring individual drivers to choose
what to do?
