From: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Mon, 3 Jul 2017 14:22:44 +0800
Message-ID: <20170703062244.GA24742@spreadtrum.com>
References: <2083c9d6e96a72f9c1324c8a277acfd780a34094.1498472593.git.baolin.wang@spreadtrum.com>
 <6941c6866078fac8fe81d108b573f7408245a0b9.1498472593.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6941c6866078fac8fe81d108b573f7408245a0b9.1498472593.git.baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andy and Wolfram,

On 一,  6月 26, 2017 at 06:28:14下午 +0800, Baolin Wang wrote:
> This patch adds the I2C controller driver for Spreadtrum SC9860 platform.
> 
> Signed-off-by: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
> ---
> Changes since v2:
>  - Remove some redundant comments and parens.
>  - Define macros instead of magic number.
>  - Add some comments to explain clock formula.
>  - Change of_clk_get_by_name() to devm_clk_get().
>  - Deal with other frequency.
>  - Change register definiton to low case.
>  - Change is_last_msg to boolean.
>  - Other optimization.
> 
> Changes sice v1:
>  - Power on I2C device in probe().
>  - Remove redundant macros and usb __maybe_unused.
>  - Remove redundant 'of_match_ptr'.
>  - Modify return values and check the return value for 'clk_prepare_enable'.
> ---

Do you have any more comments about this patch? Thanks.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
