From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: use clk_disable_unprepare in place of clk_disable
Date: Wed, 20 Jun 2012 10:26:08 -0600
Message-ID: <4FE1F9A0.6080200@wwwdotorg.org>
References: <1340196960-3002-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340196960-3002-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/20/2012 06:56 AM, Laxman Dewangan wrote:
> Use clk_disable_unprepare() inplace of clk_disable().
> This was missed as part of moving clock enable/disable to
> prepare/unprepare for using the common clock framework.

Wolfram,

Since I've taken the other I2C patch on this topic through the Tegra
tree (in order to satisfy any common clock dependencies there), I
believe I should take this one patch through the Tegra tree too.

I see no reason not to take the second patch in the series through the
I2C tree though.

Do you agree?
