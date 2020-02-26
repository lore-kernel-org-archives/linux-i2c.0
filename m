From: Elie Morisse <syniurge@gmail.com>
Subject: Re: [PATCH v1 05/40] i2c: amd-mp2: Use generic definitions for bus frequencies
Date: Wed, 26 Feb 2020 14:58:09 -0300
Message-ID: <CAC_JBqpFF6BLU_cpW4prejWECdJCv_L7qDvVYaXjcJJRxvEOsQ@mail.gmail.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com> <20200224151530.31713-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34920 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgBZR6W (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 26 Feb 2020 12:58:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so88780ljb.2
        for <linux-i2c@vger.kernel.org>; Wed, 26 Feb 2020 09:58:21 -0800 (PST)
In-Reply-To: <20200224151530.31713-5-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Nehal Shah <nehal-bakulchandra.shah@amd.com>, Shyam Sundar S K <shyam-sundar.s-k@amd.com>

Le lun. 24 f=C3=A9vr. 2020 =C3=A0 12:15, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> a =C3=A9crit :
>
> Since we have generic definitions for bus frequencies, let's use them.
>
> Cc: Elie Morisse <syniurge@gmail.com>
> Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
> Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-amd-mp2-plat.c | 27 ++++++++++++++++-----------
>  include/linux/i2c.h                   |  2 ++
>  2 files changed, 18 insertions(+), 11 deletions(-)

Looks good to me.

Acked-by: Elie Morisse <syniurge@gmail.com>
