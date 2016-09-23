From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/2] i2c: meson: add gxbb compatible string
Date: Fri, 23 Sep 2016 10:01:13 -0500
Message-ID: <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com> <20160915194146.GB7863@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034960AbcIWPBl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 11:01:41 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6FF0820451
        for <linux-i2c@vger.kernel.org>; Fri, 23 Sep 2016 15:01:40 +0000 (UTC)
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com [209.85.213.175])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E3D200BE
        for <linux-i2c@vger.kernel.org>; Fri, 23 Sep 2016 15:01:34 +0000 (UTC)
Received: by mail-yb0-f175.google.com with SMTP id u125so67577676ybg.3
        for <linux-i2c@vger.kernel.org>; Fri, 23 Sep 2016 08:01:34 -0700 (PDT)
In-Reply-To: <20160915194146.GB7863@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 15, 2016 at 2:41 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Wed, Sep 14, 2016 at 11:49:15AM +0200, Jerome Brunet wrote:
>> This patchset adds a specific compatible string in the Meson I2C driver
>> for the Amlogic Meson gxbb SoC.
>>
>> Other patch series (pinctrl and device tree) are being sent to complete
>> the i2c support on meson gxbb
>>
>> Neil Armstrong (2):
>>   i2c: meson: add gxbb compatible string
>>   dt-bindings: i2c-meson: add gxbb compatible string
>
> Squashed both patches and applied to for-next, thanks!

Please don't squash. We ask people to split DT bindings for a reason
being reviews and bindings may not go thru subsystem maintainers in
the future. It also makes it harder to find things in the archives or
patchwork (as does maintainer fixups of subject lines).

Rob
