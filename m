From: Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: Re: [PATCH] lib: Fix compilation when USE_STATIC_LIB
Date: Wed, 29 Nov 2017 12:04:06 +0100
Message-ID: <CA+_SqVakUBi3H3=GySprvYpZhZFhMXCzabY-ESwVb=vOaFP3zQ@mail.gmail.com>
References: <1511909897-18600-1-git-send-email-angelo@amarulasolutions.com> <20171129110808.4168f82f@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45804 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdK2LEr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Nov 2017 06:04:47 -0500
Received: by mail-oi0-f66.google.com with SMTP id x20so2079978oix.12
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 03:04:47 -0800 (PST)
In-Reply-To: <20171129110808.4168f82f@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org

Hi Jean,

On Wed, Nov 29, 2017 at 11:08 AM, Jean Delvare <jdelvare@suse.de> wrote:
>
> Hi Angelo,
>
> On Tue, 28 Nov 2017 23:58:17 +0100, Angelo Compagnucci wrote:
> > This patch removes the mandatory compiling of the shared library
> > when USE_STATIC_LIB is used.
>
> No, thanks. The current behavior is as desired: always build the
> dynamic library, and optionally build the static library. It was never
> the intent to allow only building the static library. Static libraries
> are evil.


In Buildroot we have the need to support also static only libraries
cause we have targets that doesn't support dynamic libraries (like
cortex M4 for which I'm fixing this bug).
The option for static only is also present for various other
architectures as a build option.

So, if this cannot be fixed upstream, I'll push a patch only on the
Buildroot side.

Sincerely, Angelo.


>
>
> --
> Jean Delvare
> SUSE L3 Support
