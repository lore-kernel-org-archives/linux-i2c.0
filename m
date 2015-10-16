From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] i2c: cadence: Move to sensible power management
Date: Fri, 16 Oct 2015 13:04:10 +0530
Message-ID: <CAKfKVtEeULgMja5X4PToPNbAHnPUa1h1VWW4mGoJW2ajEvbweQ@mail.gmail.com>
References: <1444912015-6912-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33161 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbbJPHeL (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Oct 2015 03:34:11 -0400
Received: by qkas79 with SMTP id s79so50652673qka.0
        for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2015 00:34:10 -0700 (PDT)
In-Reply-To: <1444912015-6912-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>

On Thu, Oct 15, 2015 at 5:56 PM, Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
> Currently the clocks are enabled at probe and disabled at remove.
> Which keeps the clocks enabled even if no transaction is going on.
> This patch enables the clocks at the start of transfer and disables
> after it.
>
> Also adapts to runtime pm.
> Remove xi2c->suspended and use pm runtime status instead.
>
> converts dev pm to const to silence a checkpatch warning.
>
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>

for testing suspend resume
with the below patch

http://thread.gmane.org/gmane.linux.can/8639
