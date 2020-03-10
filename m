From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] macintosh: windfarm: fix MODINFO regression
Date: Tue, 10 Mar 2020 22:04:25 +1100
Message-ID: <87zhcoii86.fsf@mpe.ellerman.id.au>
References: <20200303125046.5157-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:48981 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgCJLEl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 10 Mar 2020 07:04:41 -0400
In-Reply-To: <20200303125046.5157-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-i2c@vger.kernel.org, debian-powerpc@lists.debian.org, Mathieu Malaterre <malat@debian.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Wolfram Sang <wsa@the-dreams.de>, Erhard Furtner <erhard_f@mailbox.org>

Wolfram Sang <wsa@the-dreams.de> writes:

> Commit af503716ac14 made sure OF devices get an OF style modalias with
> I2C events. It assumed all in-tree users were converted, yet it missed
> some Macintosh drivers.
>
> Add an OF module device table for all windfarm drivers to make them
> automatically load again.
>
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199471
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>
> This should also help with this: https://lists.debian.org/debian-powerpc/2020/01/msg00062.html
> Some more testing would be appreciated because lm75 also has some code
> changes I can't test myself obviusly.
>
> By grepping, I found some more potential candidates (using a "MAC,"
> prefix but not defining a OF MODULE DEVICE TABLE). Does someone know
> about bugreports filed for those? I don't want to change them for no
> reason:
>
> drivers/macintosh/ams/ams-i2c.c
> drivers/macintosh/therm_adt746x.c
> sound/aoa/codecs/onyx.c
> sound/aoa/codecs/tas.c
> sound/ppc/keywest.c
>
> Happy hacking,
>
>    Wolfram
>
>  drivers/macintosh/windfarm_ad7417_sensor.c  |  7 +++++++
>  drivers/macintosh/windfarm_fcu_controls.c   |  7 +++++++
>  drivers/macintosh/windfarm_lm75_sensor.c    | 16 +++++++++++++++-
>  drivers/macintosh/windfarm_lm87_sensor.c    |  7 +++++++
>  drivers/macintosh/windfarm_max6690_sensor.c |  7 +++++++
>  drivers/macintosh/windfarm_smu_sat.c        |  7 +++++++
>  6 files changed, 50 insertions(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
