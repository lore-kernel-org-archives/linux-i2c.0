From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH 0/2] i2c: xgene-slimpro: Add ACPI support
Date: Mon, 17 Apr 2017 09:36:33 -0700
Message-ID: <CAFHUOYxKjG7YKuvWnVd8Sd+06rC4UvgnDe=m1dLw9hgRgtJn0Q@mail.gmail.com>
References: <1490733977-23760-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:36744 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754408AbdDQQgg (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 17 Apr 2017 12:36:36 -0400
Received: by mail-yb0-f169.google.com with SMTP id s22so6971406ybe.3
        for <linux-i2c@vger.kernel.org>; Mon, 17 Apr 2017 09:36:36 -0700 (PDT)
In-Reply-To: <1490733977-23760-1-git-send-email-hotran@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>, Hoan Tran <hotran@apm.com>

Hi All,

Do you have any comments on this patch set?

Thanks

On Tue, Mar 28, 2017 at 1:46 PM, Hoan Tran <hotran@apm.com> wrote:
> This patch set adds ACPI support by using PCC mailbox communication interface.
>
> Hoan Tran (2):
>   i2c: xgene-slimpro: Use a single function to send command message
>   i2c: xgene-slimpro: Add ACPI support by using PCC mailbox
>
>  drivers/i2c/busses/i2c-xgene-slimpro.c | 246 +++++++++++++++++++++++++--------
>  1 file changed, 192 insertions(+), 54 deletions(-)
>
> --
> 1.9.1
>
