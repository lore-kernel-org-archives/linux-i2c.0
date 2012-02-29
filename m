From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [Intel-gfx] [PATCH 1/7] drm/i915: add dev_priv to intel_gmbus
Date: Wed, 29 Feb 2012 20:56:14 +0100
Message-ID: <20120229195614.GD28941@phenom.ffwll.local>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
 <CAC7LmnupmYAs-+pUQw-wYh7+rzeK5wowDQKrmE7hh3j=pvHdvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC7LmnupmYAs-+pUQw-wYh7+rzeK5wowDQKrmE7hh3j=pvHdvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eugeni Dodonov <eugeni-xQ4UrP1oEK3R7s880joybQ@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 27, 2012 at 02:53:37PM -0300, Eugeni Dodonov wrote:
> On Tue, Feb 14, 2012 at 19:37, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org> wrote:
> 
> > This way we can free up the bus->adaptor.algo_data pointer and make it
> > available for use with the bitbanging fallback algo.
> >
> > Signed-Off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
> >
> 
> Reviewed-by: Eugeni Dodonov <eugeni.dodonov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

I've slurped this series into -next, thanks for reviewing.
-Daniel
-- 
Daniel Vetter
Mail: daniel-/w4YWyX8dFk@public.gmane.org
Mobile: +41 (0)79 365 57 48
