Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E2EC433DB
	for <linux-i2c@archiver.kernel.org>; Mon, 18 Jan 2021 19:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A745420725
	for <linux-i2c@archiver.kernel.org>; Mon, 18 Jan 2021 19:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407943AbhARTEC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:04:02 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:38868 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393817AbhARTBn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Jan 2021 14:01:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AA91D182CED5B;
        Mon, 18 Jan 2021 19:01:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shame59_0308f192754b
X-Filterd-Recvd-Size: 2090
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jan 2021 19:00:56 +0000 (UTC)
Message-ID: <82a5635e608a1c176bc1d0954d42b4d3ae0f8d7a.camel@perches.com>
Subject: Re: [PATCH v2 4/7] i2c: i2c-core-acpi: Add i2c_acpi_dev_name()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        devel@acpica.org, rjw@rjwysocki.net, lenb@kernel.org,
        andy@kernel.org, mika.westerberg@linux.intel.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        wsa@kernel.org, lee.jones@linaro.org, hdegoede@redhat.com,
        mgross@linux.intel.com, robert.moore@intel.com,
        erik.kaneda@intel.com, sakari.ailus@linux.intel.com,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Date:   Mon, 18 Jan 2021 11:00:55 -0800
In-Reply-To: <20210118185644.GH4077@smile.fi.intel.com>
References: <20210118003428.568892-1-djrscally@gmail.com>
         <20210118003428.568892-5-djrscally@gmail.com>
         <20210118133942.GI4077@smile.fi.intel.com>
         <d4671ea998010c9400ed7fd6cdf0d8ecf9a79af4.camel@perches.com>
         <20210118185644.GH4077@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, 2021-01-18 at 20:56 +0200, Andy Shevchenko wrote:
> On Mon, Jan 18, 2021 at 10:43:14AM -0800, Joe Perches wrote:
> > On Mon, 2021-01-18 at 15:39 +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 18, 2021 at 12:34:25AM +0000, Daniel Scally wrote:
> > > > We want to refer to an i2c device by name before it has been
> > > 
> > > I²C
> > 
> > Andy, are you next going to suggest renaming all the files with i2c?
> 
> Where did you get this from?

By extension from the request to use I²C.
And it's a leading question not a statement of fact.


