From: Ricardo =?ISO-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
Date: Sun, 29 Mar 2020 12:24:05 +0200
Message-ID: <e69c39e6d86fb4e9fe560a20485158e7aa7d80cf.camel@collabora.com>
References: <20200327151951.18111-1-ricardo.canuelo@collabora.com>
         <20200327154345.GA3971@ninjato>
         <CAGAzgsqJznZi83ijxCgQg463Q4AnwiNX-a0Q9+Og9MW5OJ4Vew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48772 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC2KYK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 29 Mar 2020 06:24:10 -0400
In-Reply-To: <CAGAzgsqJznZi83ijxCgQg463Q4AnwiNX-a0Q9+Og9MW5OJ4Vew@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Fri, 2020-03-27 at 13:26 -0700, dbasehore . wrote:
> 
> Enabling async is a confirmation that all dependencies to other
> devices are properly tracked, whether through the parent/child
> relationship or otherwise.

Thanks for the info, Derek.

Wouldn't it be risky then to enable async for all i2c client devices
indiscriminately? Or is it safe to assume that all i2c devices will be
idependent from each other?

Cheers,
Ricardo
