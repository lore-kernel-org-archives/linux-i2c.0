From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH V6 3/6] Documentation: DT: Add entry for FSL LS1043ARDB board
Date: Sat, 31 Oct 2015 09:00:12 +0900
Message-ID: <CAOesGMhB0JqcO1CGegUHHSQNZ_P303fdjn_OqFofXgnSFDo=og@mail.gmail.com>
References: <1445587282-29529-1-git-send-email-B48286@freescale.com>
	<1445587282-29529-3-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1445587282-29529-3-git-send-email-B48286@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Zhiqiang Hou <B48286@freescale.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-clk@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com, scottwood@freescale.com, "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>, Wenbin.Song@freescale.com
List-Id: linux-i2c@vger.kernel.org

Hi,

On Fri, Oct 23, 2015 at 5:01 PM, Zhiqiang Hou <B48286@freescale.com> wrote:
> From: Mingkai Hu <Mingkai.Hu@freescale.com>
>
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> ---
> V6: V5 V4 V3 V2
>  - No change.

You have a large number of cc recipients on these emails. I don't
think the i2c list needs to be on a board binding doc, for example.

Also, this patch lacks description. Even short and trivial patches
deserve at least a one-line description. :)

Finally, LeoLi asked on IRC what to do with these patches. The
maintainer of your platform should gather them and send the platform
portions of the patch series (DT, Kconfig, Makefile entries, etc) to
arm@kernel.org. Please don't post patches to that alias until they are
reviewed, and we want one maintainer (or a team, but start with one)
to be in charge of handling this. That way we have one person that
will learn what we expect and not, and can train others over time.



-Olof
