From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/6] i2c: at91: add support to FIFOs and alternative
 command
Date: Tue, 2 Jun 2015 17:52:22 +0200
Message-ID: <20150602155222.GB2806@odux.rfo.atmel.com>
References: <cover.1433250713.git.cyrille.pitchen@atmel.com>
 <20150602152647.GA2806@odux.rfo.atmel.com>
 <20150602153622.GB2661@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150602153622.GB2661@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 03, 2015 at 12:36:28AM +0900, Wolfram Sang wrote:
> 
> > If you send a new version, could you add stable in Cc to patch 3/6:
> 
> No need to send a new version just because of an additional ack. I can
> apply that. However...
> 
> > Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org #3.10 and later
> > If not, Wolfram could you do it please?
> 
> The problem with 3/6 is that it seems to depend on 1/6 which is a
> cleanup patch. If cleaning up is not essential for the bugfix, the
> latter should be done first. To avoid exactly this problem.
> 
> 

I was thinking the same so I have tried to cherry-pick the patch on a 3.10.79
and it didn't cause any conflicts so I thought it could be sent to stable as
is.
