From: Leo Li <pku.leo@gmail.com>
Subject: Re: [PATCH V6 5/6] clk: qoriq: Add ls1043a support.
Date: Mon, 26 Oct 2015 17:20:27 -0500
Message-ID: <CADRPPNSS62G3D8ghNjd1kJMSjXkQJ9bfqeTP_ZqMk2ehRN5iyw@mail.gmail.com>
References: <1445587282-29529-1-git-send-email-B48286@freescale.com>
	<1445587282-29529-5-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1445587282-29529-5-git-send-email-B48286@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Zhiqiang Hou <B48286@freescale.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Shaohui Xie <Shaohui.Xie@freescale.com>, corbet@lwn.net, Bhupesh Sharma <bhupesh.sharma@freescale.com>, mturquette@baylibre.com, wsa@the-dreams.de, sboyd@codeaurora.org, wim@iguana.be, Wenbin Song <Wenbin.Song@freescale.com>, Scott Wood <scottwood@freescale.com>, Hu Vincent <Mingkai.Hu@freescale.com>, linux@roeck-us.net
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 23, 2015 at 3:01 AM, Zhiqiang Hou <B48286@freescale.com> wrote:
> From: Hou Zhiqiang <B48286@freescale.com>
>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> V6: V5 V4 V3 V2
>  - No change.

I know you mentioned the dependency in the summary of the patch
series.  But it's not likely these dependencies will be merged through
the ARM sub-maintainers tree and be resolved in this merge window.  So
it will be better to mention these dependencies here so that this
patch will go through the same tree as these dependency patches.

Scott,

What is your plan to merge the clock patches?  This patch need to go
together with it.

Regards,
Leo
