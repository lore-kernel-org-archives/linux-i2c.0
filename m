From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCHv2] i2c: cadence: Enable power management
Date: Wed, 28 Oct 2015 12:59:37 +0530
Message-ID: <CAM=Q2cvOXPS8vCcgOzQiqHqWy28cCLHxa2e9uAwMhO_KdAfksw@mail.gmail.com>
References: <1446012279-2578-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34185 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391AbbJ1H3i (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Oct 2015 03:29:38 -0400
In-Reply-To: <1446012279-2578-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Linux-I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Shubhrajyoti Datta <shubhraj@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 28, 2015 at 11:34 AM, Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
> Currently the clocks are enabled at probe and disabled at remove.
> This patch enables the clocks at the start of transfer and disables
> after it.
>
> Also adapts to runtime pm.
> Remove xi2c->suspended and use pm runtime status instead.
>
> converts dev pm to const to silence a checkpatch warning.
>
Please ignore this patch
