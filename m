From: MikeB <mabnhdev@gmail.com>
Subject: Re: i2c-mux adapter names not unique
Date: Mon, 13 Mar 2017 11:05:48 -0400
Message-ID: <CAAuRgKDJBoQ8v6a=nOpcVDYOeycgP+WayRhXG7YNzt0pjXphxA@mail.gmail.com>
References: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
 <0cf3f298-87ab-0dfc-9453-cc46e31d4979@axentia.se> <CAAuRgKAYgBjk=FhQfMsGdOB+-4ObUkYgWVb-Uu+0wgM+ORWOug@mail.gmail.com>
 <26e08683-2bdb-4c8e-bd6e-b4887bc26dc3@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35700 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdCMPFu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 13 Mar 2017 11:05:50 -0400
Received: by mail-ua0-f181.google.com with SMTP id q7so137595323uaf.2
        for <linux-i2c@vger.kernel.org>; Mon, 13 Mar 2017 08:05:49 -0700 (PDT)
In-Reply-To: <26e08683-2bdb-4c8e-bd6e-b4887bc26dc3@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org

On Mon, Mar 13, 2017 at 10:48 AM, Peter Rosin <peda@axentia.se> wrote:
>
> And why not fix the bad assumption in OpenSwitch instead and kill the
> generic problem for every kind of adapter? Limiting yourself to a
> band-aid for i2c-mux adapters seems short-sighted and not very helpful
> for the next victim of this OpenSwitch problem...
>
> Note that you do not need two muxing levels to get duplicate names like
> this, it's enough with two parallel multiplexers on the root adapter. Or,
> of course, two AT91 adapters (or similar, i.e. with a fixed name).

If I thought that OpenSwitch's expectation of Linux to name unique
adapters uniquely, I would push for a change in OpenSwitch.

I personally think Linux's naming convention is a short-sighted and
insufficient which is why I came to Linux first.

I don't want a short-sighted band-aid which is why I asked the
original question.

I'll try elsewhere for a solution...

Regards, Mike
