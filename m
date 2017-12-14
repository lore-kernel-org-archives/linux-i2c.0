From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Add support for NXP PCA984x family.
Date: Thu, 14 Dec 2017 22:22:52 +0100
Message-ID: <07bf7aae-59ab-cb2b-dcb0-95ec2de66633@axentia.se>
References: <990e4a1f-a9ac-c899-0075-ae3211ff9475@axentia.se>
 <20171214112003.13701-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214112003.13701-1-adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-12-14 12:20, Adrian Fiergolski wrote:
> This patch extends the current i2c-mux-pca954x driver and adds support for
> a newer PCA984x family of the I2C switches and multiplexers from NXP.
> 
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
> ---
> I have applied recent Peter's comments.

Look like you missed the pair about .enable assignments for the [pca_9847]
and [pca_9849] entries of chips[].

Cheers,
Peter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
