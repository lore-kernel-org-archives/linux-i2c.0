From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/2] i2c: meson: add gxbb compatible string
Date: Fri, 23 Sep 2016 18:04:50 -0500
Message-ID: <CAL_JsqKi9Dk5-nF9xFD-89TTUinaGjMv5s1=N2b-Xyu98b+S3w@mail.gmail.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <20160915194146.GB7863@katana> <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
 <20160923221312.GA5683@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757739AbcIWXFP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 19:05:15 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 78BD6203B8
        for <linux-i2c@vger.kernel.org>; Fri, 23 Sep 2016 23:05:13 +0000 (UTC)
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com [209.85.161.181])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B262203A4
        for <linux-i2c@vger.kernel.org>; Fri, 23 Sep 2016 23:05:11 +0000 (UTC)
Received: by mail-yw0-f181.google.com with SMTP id g192so125218680ywh.1
        for <linux-i2c@vger.kernel.org>; Fri, 23 Sep 2016 16:05:11 -0700 (PDT)
In-Reply-To: <20160923221312.GA5683@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 23, 2016 at 5:13 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Sep 23, 2016 at 10:01:13AM -0500, Rob Herring wrote:
>> On Thu, Sep 15, 2016 at 2:41 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > On Wed, Sep 14, 2016 at 11:49:15AM +0200, Jerome Brunet wrote:
>> >> This patchset adds a specific compatible string in the Meson I2C driver
>> >> for the Amlogic Meson gxbb SoC.
>> >>
>> >> Other patch series (pinctrl and device tree) are being sent to complete
>> >> the i2c support on meson gxbb
>> >>
>> >> Neil Armstrong (2):
>> >>   i2c: meson: add gxbb compatible string
>> >>   dt-bindings: i2c-meson: add gxbb compatible string
>> >
>> > Squashed both patches and applied to for-next, thanks!
>>
>> Please don't squash. We ask people to split DT bindings for a reason
>> being reviews and bindings may not go thru subsystem maintainers in
>> the future. It also makes it harder to find things in the archives or
>> patchwork (as does maintainer fixups of subject lines).
>
> I intentionally don't ask people to send me the patches squashed. So,
> you will have them seperate in patchwork et al. I only squash them just
> before commiting to my tree. That's because I found that when digging
> through git history, it is much more convenient to have all the
> information in one commit.

If git history was the only thing that mattered, then that would be
fine. But it is not. Maintainers should apply what's on the list.
Period. You wouldn't fixup pull requests to make the commit history
more to your liking, would you?

Rob
