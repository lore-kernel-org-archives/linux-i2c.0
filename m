From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c:at91: add bound checking on smbus block length bytes
Date: Wed, 6 Aug 2014 13:53:46 +0200
Message-ID: <20140806115346.GB27338@ldesroches-Latitude-E6320>
References: <1404457391-22330-1-git-send-email-mark.roszko@gmail.com>
 <CAJjB1qJvvaO3PtN5dMAAAeABS5YMmRc1VRwKo6G_ZuDuo6L15g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJjB1qJvvaO3PtN5dMAAAeABS5YMmRc1VRwKo6G_ZuDuo6L15g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org> mailing list" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mark,

On Mon, Aug 04, 2014 at 12:29:56PM -0400, Mark Roszko wrote:
> Hi Ludovic,
> 
> Have you had a chance to look? This causes kernel panic in at91 systems in
> noisy environments and/or unreliable smbus slaves if left unfixed.

Thanks for the reminder, I had totally missed this patch.

Seems good, no objection to include this patch.

Only one comment: s/recieved/received otherwise

Acked-By: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Sorry for the delay.

Ludovic
