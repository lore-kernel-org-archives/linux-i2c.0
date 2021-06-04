Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BB9C47099
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Jun 2021 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C5C613FF
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Jun 2021 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDOfh (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 4 Jun 2021 10:35:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:36371 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFDOfg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 4 Jun 2021 10:35:36 -0400
IronPort-SDR: l4GthF+N7GUXvWb9BEmDR15xCfg3+y2DRjcdAEu7l/fgs2JxmsWFWGit5yYJsEeultpjivvPU6
 ucYlF0U/D3mA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="225615156"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="225615156"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 07:33:44 -0700
IronPort-SDR: mq6gBWZXAkj+GkSNW2GLCunv1BTwmnrvqqRhVtECGFhXGTKpqrg9+OAUO6w5YXI5orW/ATSukf
 Udc7NXwh5WjA==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="483928034"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 07:33:39 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lpAtE-00HFAa-C2; Fri, 04 Jun 2021 17:33:36 +0300
Date:   Fri, 4 Jun 2021 17:33:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, devel@acpica.org,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Subject: Re: [PATCH v5 4/6] gpiolib: acpi: Add acpi_gpio_get_io_resource()
Message-ID: <YLo5wFds5JdE82P/@smile.fi.intel.com>
References: <20210603224007.120560-1-djrscally@gmail.com>
 <20210603224007.120560-5-djrscally@gmail.com>
 <YLokNQCJ7WXKZepR@smile.fi.intel.com>
 <ca51ab71-9cdd-0d00-959f-9e1b2df3588c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca51ab71-9cdd-0d00-959f-9e1b2df3588c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, Jun 04, 2021 at 03:09:43PM +0100, Daniel Scally wrote:
> On 04/06/2021 14:01, Andy Shevchenko wrote:
> > On Thu, Jun 03, 2021 at 11:40:05PM +0100, Daniel Scally wrote:
> >> Add a function to verify that a given acpi_resource represents an IO
> >> type GPIO resource, and return it if so.
> > I would rephrase this to something like:
> >
> > "Add a function to verify that a given ACPI resource represents a GpioIo() type
> > of resource, and return it if so."
> >
> > I can amend when applying to my branch.
> >
> That wording is perfectly fine by me

These two patches (with mentioned amendments) pushed to my review and testing
queue, thanks!

I'll send PR next week to all stakeholders.

-- 
With Best Regards,
Andy Shevchenko


