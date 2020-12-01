Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091D6C71155
	for <linux-i2c@archiver.kernel.org>; Tue,  1 Dec 2020 18:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849A7217A0
	for <linux-i2c@archiver.kernel.org>; Tue,  1 Dec 2020 18:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="f3rtzHEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgLAS4j (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLAS4j (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Dec 2020 13:56:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4032C0613CF;
        Tue,  1 Dec 2020 10:55:58 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0EA80DBD;
        Tue,  1 Dec 2020 19:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1606848957;
        bh=Nlsmy7Oo5UKk1TOiJqdEqFpGI+m3S8hclyWwhqNRL6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3rtzHEaMw1H6ldJJT8VkSSHu+KW9QlExGZlDRR9TuZIU9mr3OrSSG0MiSCoXsA14
         NYJn8ukgiqmkiKtDJ3Pq6koSmS85VRthPrMXVm2gUc/sElK3P2dovIyxpK6ESRAf0V
         5np4bMun098WBKjZd9jZxSNJdSGCpWQBlZYfeffQ=
Date:   Tue, 1 Dec 2020 20:55:48 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org, rjw@rjwysocki.net, lenb@kernel.org,
        gregkh@linuxfoundation.org, mika.westerberg@linux.intel.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        wsa@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk, kieran.bingham+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org,
        laurent.pinchart+renesas@ideasonboard.com,
        jorhand@linux.microsoft.com, kitakar@gmail.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 18/18] ipu3: Add driver for dummy INT3472 ACPI device
Message-ID: <20201201185548.GV4569@pendragon.ideasonboard.com>
References: <20201130133129.1024662-1-djrscally@gmail.com>
 <20201130133129.1024662-19-djrscally@gmail.com>
 <20201130200719.GB4077@smile.fi.intel.com>
 <8a1b0f5b-1289-256b-b25d-cf8af43bdc84@gmail.com>
 <20201201185417.GL4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201185417.GL4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Andy,

On Tue, Dec 01, 2020 at 08:54:17PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 01, 2020 at 08:30:03AM +0000, Dan Scally wrote:
> > On 30/11/2020 20:07, Andy Shevchenko wrote:
> 
> ...
> 
> > >> +static struct int3472_sensor_regulator_map int3472_sensor_regulator_maps[] = {
> > >> +	{ "GNDF140809R", 2, miix_510_ov2680 },
> > >> +	{ "YHCU", 2, surface_go2_ov5693 },
> > >> +	{ "MSHW0070", 2, surface_book_ov5693 },
> > >> +};
> > >
> > > Hmm... Usual way is to use DMI for that. I'm not sure above will not give us
> > > false positive matches.
> >
> > I considered DMI too, no problem to switch to that if it's a better choice.
> 
> I prefer DMI as it's a standard way to describe platform quirks in x86 world.

Do you think the Windows driver would use DMI ? That seems quite
unlikely to me, given how they would have to release a new driver binary
for every machine. I'm pretty sure that a different mechanism is used to
identify camera integration, and I think it would make sense to follow
the same approach. That would allow us to avoid large tables of DMI
identifiers that would need to be constently updated, potentially making
user experience better.

-- 
Regards,

Laurent Pinchart
