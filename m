From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH] i2c: designware: Do not require clock when SSCN and FFCN
 are provided
Date: Wed, 16 Dec 2015 16:55:34 -0800
Message-ID: <CAPw-ZTm062Ouoh2K4kWLFcuQWsCjqaSC6u95a3d_1Fd4xWZU5w@mail.gmail.com>
References: <1450219138-5868-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35418 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604AbbLQAzg (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 16 Dec 2015 19:55:36 -0500
Received: by mail-lb0-f170.google.com with SMTP id u9so36015427lbp.2
        for <linux-i2c@vger.kernel.org>; Wed, 16 Dec 2015 16:55:35 -0800 (PST)
In-Reply-To: <1450219138-5868-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, wsa@the-dreams.de, Ken Xue <Ken.Xue@amd.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

> The current driver uses input clock source frequency to calculate
> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
> currently have a good way to provide the frequency information.
> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
> to directly provide these values.
>
> So, this patch removes the clock requirement when SSCN and FFCN
> are provided.
>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Tested on X-Gene ACPI boot with updated FW and work just fine.

-Loc
