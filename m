From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/5] mfd: axp20x: Use IRQF_TRIGGER_LOW on the axp288
Date: Wed, 14 Dec 2016 22:19:39 +0800
Message-ID: <CAGb2v66n-r261yEFcBCXhJLFeBjVKk8wntBH4vVM3VF0ZNbFgw@mail.gmail.com>
References: <20161214135209.16369-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:47206 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755304AbcLNOUJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 09:20:09 -0500
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com [209.85.223.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id C2FC826290
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 22:20:01 +0800 (CST)
Received: by mail-io0-f170.google.com with SMTP id h30so41109766iod.2
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 06:20:01 -0800 (PST)
In-Reply-To: <20161214135209.16369-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Wed, Dec 14, 2016 at 9:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The interrupt line of the entire family of axp2xx pmics is active-low,
> for devicetree enumerated irqs, this is dealt with in the devicetree.
>
> ACPI irq resources have a flag field for this too, I tried using this
> on my CUBE iwork8 Air tablet, but it does not contain the right data.
>
> The dstd shows the irq listed as either ActiveLow or ActiveHigh,
> depending on the OSID variable, which seems to be set by the
> "OS IMAGE ID" in the BIOS/EFI setup screen.
>
> Since the acpi-resource info is no good, simply pass in IRQF_TRIGGER_LOW
> on the axp288.
>
> Together with the other axp288 fixes in this series, this fixes the axp288
> irq contineously triggering.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This patch looks good to me. However, I do not have any AXP288 hardware
to test it on, nor am I familiar with the ACPI stuff.

Acked-by: Chen-Yu Tsai <wens@csie.org>

P.S. I don't think we're handling IRQ trigger types at all. The hardware
default for the NMI interrupt in the Allwinner chips just happens to be
active low.
