From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
Date: Fri, 29 Jun 2012 18:42:08 +0530
Message-ID: <4FEDA9A8.1050504@ti.com>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com> <1340967927-27354-4-git-send-email-shubhrajyoti@ti.com> <20120629144002.3b4a31ee@endymion.delvare> <20120629145718.697b6955@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120629145718.697b6955@endymion.delvare>
Sender: linux-omap-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

On Friday 29 June 2012 06:27 PM, Jean Delvare wrote:
> drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: (near initial=
ization for =E2=80=98msg[1].actual=E2=80=99) [enabled by default]
>
> This needs to be all fixed (converted to C99-style struct
> initialization) before your patch is considered for inclusion. And
> there may be more that my config did not spot.
Yes,agree.

The idea of this patch was if the idea is agreed upon then.
then fixing all the callers could be worked on.

However do you agree with this approach?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
