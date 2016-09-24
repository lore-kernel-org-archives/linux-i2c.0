From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/2] i2c: meson: add gxbb compatible string
Date: Fri, 23 Sep 2016 20:02:46 -0500
Message-ID: <CAL_JsqJGQ2az=eO0PbfcTrAPxUsym=UaDOOy1Rsw0-AbzMjnXg@mail.gmail.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <20160915194146.GB7863@katana> <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
 <20160923221312.GA5683@katana> <CAL_JsqKi9Dk5-nF9xFD-89TTUinaGjMv5s1=N2b-Xyu98b+S3w@mail.gmail.com>
 <20160923232641.GB5683@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757906AbcIXBDL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 21:03:11 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 412A220443
        for <linux-i2c@vger.kernel.org>; Sat, 24 Sep 2016 01:03:10 +0000 (UTC)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com [209.85.213.179])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C11203F3
        for <linux-i2c@vger.kernel.org>; Sat, 24 Sep 2016 01:03:07 +0000 (UTC)
Received: by mail-yb0-f179.google.com with SMTP id 2so67968853ybv.0
        for <linux-i2c@vger.kernel.org>; Fri, 23 Sep 2016 18:03:07 -0700 (PDT)
In-Reply-To: <20160923232641.GB5683@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 23, 2016 at 6:26 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > I intentionally don't ask people to send me the patches squashed. So,
>> > you will have them seperate in patchwork et al. I only squash them just
>> > before commiting to my tree. That's because I found that when digging
>> > through git history, it is much more convenient to have all the
>> > information in one commit.
>>
>> If git history was the only thing that mattered, then that would be
>> fine. But it is not. Maintainers should apply what's on the list.
>> Period.
>
> Huh? If you would *ask* me to stop squashing, I am listening to reasons.

I did state some reasons previously. Consistent rules for submitters
of DT bindings and being able to trace history beyond git. Now, I
guess you aren't changing the rules, but you probably aren't
requesting people to split DT bindings either? You might not be aware,
but we also generate a DT only tree with git-filter-branch[1] for
non-kernel projects to use bindings and dts files. For that, sure they
will only get the DT binding part of it, but what commit text do they
get? Finally, DT maintainer acks (which from me is a review really)
apply to the bindings only. Sometimes I review the drivers, but not
often. So I would like the git history of my reviews to be accurate in
terms of what I actually reviewed.

> If you want to force arbitrary rules on me, I am not. There are reasons
> where squashing/modifying patches makes more sense compared to forcing
> the author to resend. DTS bindings may not be one, we can discuss that.
> But that rule without allowing exceptions seems impractical to me.

Okay, "period" was a bit much. Exceptions are perfectly fine, we all
do some minor fixups time to time. It just shouldn't be the norm IMO.

Rob

[1] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/
