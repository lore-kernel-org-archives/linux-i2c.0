From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v7] i2c: Add support for NXP PCA984x family.
Date: Fri, 29 Dec 2017 00:31:05 +0100
Message-ID: <fcc1fe6d-303c-eb52-65e3-28d728e2f764@axentia.se>
References: <20171220182745.lo6i27ucfhjekmjp@rob-hp-laptop>
 <20171225212646.8062-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171225212646.8062-1-adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-12-25 22:26, Adrian Fiergolski wrote:
> This patch extends the current i2c-mux-pca954x driver and adds support for
> a newer PCA984x family of the I2C switches and multiplexers from NXP.
> 
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
> ---
> Following Rob's and Peter's remarks, bindings contain now one valid
> combination of compatibles per line.

Patch applied, thanks!

Any idea if you are going to tackle that device-id functionality for the
i2c core?

Cheers,
Peter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
