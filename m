From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [PATCH 5/6] arm64: renesas: draak: enable I2C controller 1
Date: Mon, 29 Jan 2018 16:46:52 +0100
Message-ID: <CAO3366w0GA+MsL-vyUsDtVAhNnHuX9zEy2KaZxQh_YQ4uJsL0Q@mail.gmail.com>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1510759526-30346-6-git-send-email-ulrich.hecht+renesas@gmail.com> <CAMuHMdX1iitObng0nvhmP4r5yb1CnqBwbchu6qDQLtqjPLbDQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35557 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeA2Pqy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 29 Jan 2018 10:46:54 -0500
In-Reply-To: <CAMuHMdX1iitObng0nvhmP4r5yb1CnqBwbchu6qDQLtqjPLbDQg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>

On Thu, Nov 16, 2017 at 10:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> If no devices are connected, perhaps it's wise to defer the status update
> to e.g. an overlay that describes what's connected to CN23?
>
> Or do you want it enabled to allow adding devices manually using
> /sys/bus/i2c/devices/i2c-1/new_device?

Indeed. It's an unpopulated bus on a development board with an
external connector, so I think it's valid to assume that it is
intended to be used for experimentation.

CU
Uli
