From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: mux: pca954x: Add interrupt controller
 support
Date: Thu, 12 Jan 2017 20:15:14 +0100
Message-ID: <20170112191514.dpusqnbqahayx6j3@ninjato>
References: <1483952576-5308-1-git-send-email-preid@electromag.com.au>
 <1483952576-5308-4-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1483952576-5308-4-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 09, 2017 at 05:02:54PM +0800, Phil Reid wrote:
> Various muxes can aggregate multiple interrupts from each i2c bus.
> All of the muxes with interrupt support combine the active low irq lines
> using an internal 'and' function and generate a combined active low
> output. The muxes do provide the ability to read a control register to
> determine which irq is active. By making the mux an irq controller isr
> latency can potentially be reduced by reading the status register and
> then only calling the registered isr on that bus segment.
> 
> As there is no irq masking on the mux irq are disabled until irq_unmask is
> called at least once.
> 
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>

Is the ack from Peda here forgotten or still missing?

@peda: Once you are happy, do you want to take these patches via your
shiny new mux-tree or do you prefer if I pick them?

Regards,

   Wolfram

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
