Return-Path: <SRS0=GIpW=CC=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E6C433DF
	for <linux-i2c@archiver.kernel.org>; Mon, 24 Aug 2020 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1415120866
	for <linux-i2c@archiver.kernel.org>; Mon, 24 Aug 2020 17:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHXRDH (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:03:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgHXRDF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Aug 2020 13:03:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BA97B154;
        Mon, 24 Aug 2020 17:03:34 +0000 (UTC)
Date:   Mon, 24 Aug 2020 19:03:03 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] eeprom: at24: Add support for the Sony VAIO EEPROMs
Message-ID: <20200824190303.38e80f0c@endymion>
In-Reply-To: <CAMpxmJWUqCL=QRfrFdTh7E_PmJd8WL+yY5U+d1YBPtg8GRTuJg@mail.gmail.com>
References: <20200807150005.48c8c89b@endymion>
        <CAMpxmJWUqCL=QRfrFdTh7E_PmJd8WL+yY5U+d1YBPtg8GRTuJg@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, 18 Aug 2020 15:41:32 +0200, Bartosz Golaszewski wrote:
> On Fri, Aug 7, 2020 at 3:00 PM Jean Delvare <jdelvare@suse.de> wrote:
> >
> > Special handling of the Sony VAIO EEPROMs is the last feature of the
> > legacy eeprom driver that the at24 driver does not support. Adding
> > this would let us deprecate and eventually remove the legacy eeprom
> > driver.
> >
> > So add the option to specify a post-processing callback function that
> > is called after reading data from the EEPROM, before it is returned
> > to the user. The 24c02-vaio type is the first use case of that option:
> > the callback function will mask the sensitive data for non-root users
> > exactly as the legacy eeprom driver was doing.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Bartosz, this is a different approach to solving the problem compared
> > to your suggestion. It's even more generic in a way. Let me know what
> > you think.
> 
> Patch applied with a stray newline dropped.

Oh, I see it now. Sorry and that and thanks for catching and fixing it.

-- 
Jean Delvare
SUSE L3 Support
