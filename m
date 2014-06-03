From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: pca954x: Use the descriptor-based GPIO API
Date: Tue, 3 Jun 2014 13:19:41 +0200
Message-ID: <CACRpkdbnQayorTO9H0A7UM3L4NpcpPHkk78fNg-0Ss14-Rp43A@mail.gmail.com>
References: <1401754973-13274-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1401794126-22244-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401794126-22244-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 3, 2014 at 1:15 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:

> The ID-based GPIO API pushes handling of GPIO polarity to drivers.
> Simplify the driver by switching to the descriptor-based GPIO API.
>
> This also fixes a mismatch between the pca954x DT bindings that document
> a "reset-gpios" property and the driver that requests a "reset-gpio"
> property.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
