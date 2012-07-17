From: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v4] i2c: stu300: use devm managed resources
Date: Tue, 17 Jul 2012 09:42:00 +0530
Message-ID: <5004E610.9090000@st.com>
References: <1342438212-18965-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1342438212-18965-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 7/16/2012 5:00 PM, Linus Walleij wrote:
> Allocate memory for device state using devm_kzalloc(), get the
> clock using devm_clk_get(), get the IRQ using devm_request_irq(),
> request and remap memory using devm_request_and_ioremap().
> All to simplify accounting and letting the kernel do the
> garbage-collection.
>
> Signed-off-by: Linus Walleij<linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ChangeLog v3->v4:
> - Rebase on top of Wolframs i2c-embedded/for-next branch.
> ChangeLog v2->v3:
> - Also delete the cached physical base and size from the state
>    holder struct.
> ChangeLog v1->v2:
> - Use more devm* stuff, at Wolfram's request.
> - Note: based on a clean v3.5-rc6, may need some patch -p1<  patch
>    to apply on the i2c tree, if you want me to rebase it, just tell
>    me where to find the baseline.

Reviewed By: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>

~Rajeev
