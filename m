From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Date: Fri, 23 Oct 2015 12:04:34 +0200
Message-ID: <CAMuHMdUQCBUyFWO1Jm7BqEVb2kC4v6pKpSrwdGytCuS=d-oZDQ@mail.gmail.com>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
	<131418014.1WnDGNUZcn@avalon>
	<20151022110505.GB1572@katana>
	<1917001.aD8sIkvx7f@avalon>
	<20151023080601.GC1642@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20151023080601.GC1642@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 23, 2015 at 10:06 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> b9653e9c000dc2ebd9c8712442c659ccd1586e22 from Geert's drivers tree ? On my
>
> Does that build for you?
>
> drivers/gpu/drm/drm_fb_helper.c: In function 'restore_fbdev_mode':
> drivers/gpu/drm/drm_fb_helper.c:448:5: error: 'error' undeclared (first use in this function)
>
> ??

Sorry, my fault. Wrong merge resolution:

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -445,7 +445,7 @@ static int restore_fbdev_mode(struct drm_fb_helper *fb_helpe
                if (crtc->funcs->cursor_set2) {
                        ret = crtc->funcs->cursor_set2(crtc, NULL, 0, 0, 0, 0, 0
                        if (ret)
-                               error = true;
+                               return ret;
                } else if (crtc->funcs->cursor_set) {
                        ret = crtc->funcs->cursor_set(crtc, NULL, 0, 0, 0);
                        if (ret)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
